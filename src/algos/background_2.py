#!/usr/bin/env python3

import sys
from collections import defaultdict

import clingo
import clingo.ast as ast


# =====================================================================
# 1. Dependency extraction / stratification check
# =====================================================================

class DependencyExtractor:
    def __init__(self):
        self.predicates = set()
        self.pos_edges = []
        self.neg_edges = []

    def visit_rule(self, rule):
        head_preds = self.head_predicates(rule.head)

        if not head_preds:
            return

        body_literals = self.body_predicates(rule.body)

        for hp in head_preds:
            self.predicates.add(hp)

            for sign, bp in body_literals:
                self.predicates.add(bp)

                if sign == "neg":
                    self.neg_edges.append((hp, bp))
                else:
                    self.pos_edges.append((hp, bp))

    def head_predicates(self, head):
        result = []

        if head.ast_type == ast.ASTType.Literal:
            pred = self.literal_predicate(head)
            if pred:
                result.append(pred)

        elif head.ast_type == ast.ASTType.Disjunction:
            for elem in head.elements:
                pred = self.literal_predicate(elem.literal)
                if pred:
                    result.append(pred)

        return result

    def body_predicates(self, body):
        result = []

        for lit in body:
            pred = self.literal_predicate(lit)

            if pred is None:
                continue

            if lit.sign == ast.Sign.Negation:
                result.append(("neg", pred))
            else:
                result.append(("pos", pred))

        return result

    def literal_predicate(self, lit):
        atom = lit.atom

        if atom.ast_type != ast.ASTType.SymbolicAtom:
            return None

        sym = atom.symbol

        if sym.ast_type != ast.ASTType.Function:
            return None

        return sym.name


def tarjan(vertices, edges):

    graph = defaultdict(list)

    for u, v in edges:
        graph[u].append(v)

    index = 0
    indices = {}
    lowlink = {}
    stack = []
    onstack = set()
    sccs = []

    def strongconnect(v):
        nonlocal index

        indices[v] = index
        lowlink[v] = index
        index += 1

        stack.append(v)
        onstack.add(v)

        for w in graph[v]:
            if w not in indices:
                strongconnect(w)
                lowlink[v] = min(lowlink[v], lowlink[w])
            elif w in onstack:
                lowlink[v] = min(lowlink[v], indices[w])

        if lowlink[v] == indices[v]:
            comp = []
            while True:
                w = stack.pop()
                onstack.remove(w)
                comp.append(w)
                if w == v:
                    break
            sccs.append(comp)

    for v in vertices:
        if v not in indices:
            strongconnect(v)

    return sccs


def check_stratified(predicates, pos_edges, neg_edges):

    all_edges = pos_edges + neg_edges
    sccs = tarjan(predicates, all_edges)

    comp_of = {}
    for idx, comp in enumerate(sccs):
        for p in comp:
            comp_of[p] = idx

    violating = []

    for u, v in neg_edges:
        if comp_of[u] == comp_of[v]:
            violating.append((u, v))

    return len(violating) == 0, sccs, violating


# =====================================================================
# 2. AST -> evaluator rule format
#
#    Converts clingo terms into Python values:
#      - Variable                    -> str (variable name, e.g. "X")
#      - SymbolicTerm / Number        -> int
#      - SymbolicTerm / String        -> str
#      - SymbolicTerm / Function, 0-ary -> str (constant name)
#      - UnaryOperation (Minus)       -> negated number
#
#    Only handles: SymbolicAtom over Function terms, with arguments
#    that are themselves Symbols (numbers/strings/constants) or
#    Variables. No aggregates, no pooling, no binary arithmetic,
#    no disjunction in the head.
# =====================================================================

class RuleExtractor:
    def __init__(self):
        self.facts = set()    # ground facts: set of (pred, *args)
        self.rules = []       # list of {"head": ..., "body": [...]}

    def term_to_value(self, term):
        """Convert a clingo AST term into a Python value or var-name string."""

        t = term.ast_type

        if t == ast.ASTType.Variable:
            return term.name

        if t == ast.ASTType.SymbolicTerm:
            sym = term.symbol

            if sym.type == clingo.SymbolType.Number:
                return sym.number

            if sym.type == clingo.SymbolType.String:
                return sym.string

            if sym.type == clingo.SymbolType.Function:
                if len(sym.arguments) == 0:
                    return sym.name
                raise ValueError(
                    f"Nested function terms not supported: {sym}"
                )

            raise ValueError(f"Unsupported symbol type: {sym.type}")

        if t == ast.ASTType.UnaryOperation:
            inner = self.term_to_value(term.argument)
            if term.operator_type == ast.UnaryOperator.Minus and isinstance(inner, (int, float)):
                return -inner
            raise ValueError(f"Unsupported unary operation: {term}")

        raise ValueError(f"Unsupported term type: {t!r} (term: {term!r})")

    def literal_to_atom(self, lit):
        """
        Convert a Literal (SymbolicAtom) into (sign, pred, args_tuple).
        Returns None for non-symbolic atoms (comparisons, aggregates, ...).
        """

        atom = lit.atom

        if atom.ast_type != ast.ASTType.SymbolicAtom:
            return None

        sym = atom.symbol

        if sym.ast_type != ast.ASTType.Function:
            return None

        pred = sym.name
        args = tuple(self.term_to_value(a) for a in sym.arguments)

        sign = "neg" if lit.sign == ast.Sign.Negation else "pos"

        return sign, pred, args

    def visit_rule(self, rule):

        head = rule.head

        if head.ast_type != ast.ASTType.Literal:
            # disjunctions / aggregates in head not supported here
            return

        head_atom = self.literal_to_atom(head)

        if head_atom is None:
            return

        sign, pred, args = head_atom

        if sign == "neg":
            raise ValueError(f"Negated head not supported: {pred}{args}")

        body = []

        for lit in rule.body:
            atom = self.literal_to_atom(lit)
            if atom is None:
                raise ValueError(
                    "Unsupported body literal (comparison/aggregate/theory atom); "
                    "extend RuleExtractor to handle it"
                )
            body.append(atom)

        if not body:
            # fact (must be ground)
            if any(isinstance(a, str) and a[:1].isupper() for a in args):
                raise ValueError(f"Fact with variables not supported: {pred}{args}")
            self.facts.add((pred,) + args)
        else:
            self.rules.append({"head": (pred, args), "body": body})


# =====================================================================
# 3. Evaluator (TP fixpoint per stratum)
# =====================================================================

import re

VAR_RE = re.compile(r"^[A-Z_]")


def is_var(t):
    return isinstance(t, str) and bool(VAR_RE.match(t))


def apply_subst(args, subst):
    return tuple(subst.get(a, a) if is_var(a) else a for a in args)


def match_atom(pattern_args, fact_args, subst):
    if len(pattern_args) != len(fact_args):
        return None

    new_subst = dict(subst)

    for p, f in zip(pattern_args, fact_args):
        if is_var(p):
            if p in new_subst:
                if new_subst[p] != f:
                    return None
            else:
                new_subst[p] = f
        else:
            if p != f:
                return None

    return new_subst


def solve_body(body, facts):
    pos = [b for b in body if b[0] == "pos"]
    neg = [b for b in body if b[0] == "neg"]

    def rec(lits, subst):
        if not lits:
            yield subst
            return

        sign, pred, args = lits[0]
        rest = lits[1:]

        ground_args = apply_subst(args, subst)

        for fact in facts:
            if fact[0] != pred:
                continue

            new_subst = match_atom(ground_args, fact[1:], subst)

            if new_subst is not None:
                yield from rec(rest, new_subst)

    for subst1 in rec(pos, {}):
        ok = True

        for sign, pred, args in neg:
            ground_args = apply_subst(args, subst1)

            if any(is_var(a) for a in ground_args):
                raise ValueError(
                    f"Unbound variable in negative literal: not {pred}{ground_args}"
                )

            if (pred,) + ground_args in facts:
                ok = False
                break

        if ok:
            yield subst1


def tp_step(rules, facts):
    new_facts = set(facts)

    for rule in rules:
        head_pred, head_args = rule["head"]

        for subst in solve_body(rule["body"], facts):
            new_facts.add((head_pred,) + apply_subst(head_args, subst))

    return new_facts


def fixpoint(rules, facts):
    while True:
        new_facts = tp_step(rules, facts)

        if new_facts == facts:
            return facts

        facts = new_facts


def compute_strata(predicates, pos_edges, neg_edges, sccs):
    """
    Stratum number per predicate, derived from the SCC condensation graph.
    Edge p -> q (pos): stratum(p) >= stratum(q)
    Edge p -> q (neg): stratum(p) >  stratum(q)
    """

    comp_of = {}
    for idx, comp in enumerate(sccs):
        for p in comp:
            comp_of[p] = idx

    n = len(sccs)
    cond_edges = defaultdict(set)

    for u, v in pos_edges:
        cu, cv = comp_of[u], comp_of[v]
        if cu != cv:
            cond_edges[cu].add((cv, False))

    for u, v in neg_edges:
        cu, cv = comp_of[u], comp_of[v]
        if cu != cv:
            cond_edges[cu].add((cv, True))

    memo = {}

    def stratum_of(c):
        if c in memo:
            return memo[c]

        best = 0
        for dep, is_neg in cond_edges[c]:
            d = stratum_of(dep)
            best = max(best, d + 1 if is_neg else d)

        memo[c] = best
        return best

    pred_stratum = {}
    for c, comp in enumerate(sccs):
        s = stratum_of(c)
        for p in comp:
            pred_stratum[p] = s

    return pred_stratum


def evaluate(rules, facts, pred_stratum):
    if not pred_stratum:
        return fixpoint(rules, facts)

    max_stratum = max(pred_stratum.values())

    for s in range(max_stratum + 1):
        rules_in_stratum = [
            r for r in rules if pred_stratum.get(r["head"][0], 0) == s
        ]
        facts = fixpoint(rules_in_stratum, facts)

    return facts


# =====================================================================
# 4. Driver
# =====================================================================

def parse_file(filename):

    dep = DependencyExtractor()
    rex = RuleExtractor()

    def on_statement(stmt):
        if stmt.ast_type == ast.ASTType.Rule:
            dep.visit_rule(stmt)
            rex.visit_rule(stmt)

    ast.parse_files([filename], on_statement)

    return dep, rex


def main():

    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} file.lp")
        sys.exit(1)

    filename = sys.argv[1]

    try:
        dep, rex = parse_file(filename)
    except RuntimeError as e:
        print("Parse error:")
        print(e)
        sys.exit(1)

    stratified, sccs, violating = check_stratified(
        dep.predicates, dep.pos_edges, dep.neg_edges
    )

    if not stratified:
        print("PROGRAM IS NOT STRATIFIED")
        for u, v in violating:
            print(f"  {u} -|> {v}")
        sys.exit(1)

    print("Program is stratified. SCCs:")
    for scc in sccs:
        print(" ", scc)

    pred_stratum = compute_strata(dep.predicates, dep.pos_edges, dep.neg_edges, sccs)

    print("\nStrata:")
    for p in sorted(pred_stratum, key=lambda p: (pred_stratum[p], p)):
        print(f"  {pred_stratum[p]}: {p}")

    answer_set = evaluate(rex.rules, rex.facts, pred_stratum)

    print("\nAnswer set:")
    for f in sorted(answer_set, key=lambda x: (x[0], x[1:])):
        pred = f[0]
        args = f[1:]
        if args:
            print(f"{pred}({','.join(map(str, args))})")
        else:
            print(pred)


if __name__ == "__main__":
    main()