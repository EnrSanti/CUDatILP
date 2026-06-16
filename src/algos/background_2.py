#!/usr/bin/env python3

import sys
import re
import operator
import itertools
from collections import defaultdict

import clingo
import clingo.ast as ast


VAR_RE = re.compile(r"^[A-Z_]")


def is_var(t):
    return isinstance(t, str) and bool(VAR_RE.match(t))

STEP_RE = re.compile(
    r'([a-z_][A-Za-z0-9_]*)\s*\(([^()]*)\)\s*:\s*(-?\d+(?:\.\d+)?)\s*\.'
)

ARG_INTERVAL_RE = re.compile(
    r'^\s*(-?\d+(?:\.\d+)?)\s*\.\.\s*(-?\d+(?:\.\d+)?)\s*$'
)

ARG_POOL_RE = re.compile(r'^\s*(-?\d+(?:\.\d+)?(?:\s*;\s*-?\d+(?:\.\d+)?)+)\s*$')


def split_top_level_commas(s):
    """Split `s` on commas that aren't nested inside parens (none expected
    here since the outer regex already excludes '(' ')', but kept for
    safety/clarity)."""
    return [part.strip() for part in s.split(",")]


STEP_RE = re.compile(
    r'([a-z_][A-Za-z0-9_]*)\s*\(([^()]*)\)\s*:\s*(-?\d+(?:\.\d+)?)\s*\.'
)

ARG_INTERVAL_RE = re.compile(
    r'^\s*(-?\d+(?:\.\d+)?)\s*\.\.\s*(-?\d+(?:\.\d+)?)\s*$'
)


def expand_stepped_intervals(text):
    """
    Detect and remove statements of the form:
        name(arg1, arg2, ...):step.

    Matches clingo's actual pooling semantics: ';' at the top level of
    the argument list pools whole argument-TUPLES (not individual
    argument slots), e.g.

        var2(1..6,10;11)

    means: pool of two alternative tuples, (1..6, 10) and (11,) -- NOT
    a cartesian product across all of "1..6", "10", "11" together.

    Within EACH ';'-separated alternative, arguments are split on ','
    and combined via cartesian product as usual (intervals expand to
    a value-list, stepped by `step` if numeric/float; plain numbers
    stay fixed).

    Returns (patched_text, stepped) where stepped is a list of
    (pred, [tuple1, tuple2, ...]) -- the concatenation (NOT product)
    of facts from each ';'-alternative.
    """

    stepped = []

    def expand_one_arg(arg_text, step):
        m_interval = ARG_INTERVAL_RE.match(arg_text)

        if m_interval:
            a = float(m_interval.group(1))
            b = float(m_interval.group(2))

            if step == 0:
                raise ValueError(f"Step cannot be zero in interval: {arg_text}")

            n_steps = round((b - a) / step)

            if n_steps < 0:
                raise ValueError(f"Empty stepped interval (b < a?): {arg_text}")

            values = []
            for i in range(n_steps + 1):
                v = round(a + i * step, 10)
                if float(v).is_integer():
                    v = int(v)
                values.append(v)

            return values

        # plain number (pools are now split out before this is called)
        try:
            v = float(arg_text.strip())
            if v.is_integer():
                v = int(v)
            return [v]
        except ValueError:
            return [arg_text.strip()]

    def repl(m):
        pred = m.group(1)
        args_blob = m.group(2)
        step = float(m.group(3))

        # Step 1: split into ';'-separated whole-tuple alternatives
        alternatives = [alt.strip() for alt in args_blob.split(";")]

        all_tuples = []

        for alt in alternatives:
            # Step 2: within this alternative, split on top-level commas
            arg_texts = [a.strip() for a in alt.split(",")] if alt else []

            per_arg_values = [expand_one_arg(a, step) for a in arg_texts]

            # Step 3: cartesian product WITHIN this alternative only
            for combo in itertools.product(*per_arg_values):
                all_tuples.append(combo)

        stepped.append((pred, all_tuples))

        return ""

    patched = STEP_RE.sub(repl, text)

    return patched, stepped
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
#      - Variable                       -> str (variable name, e.g. "X")
#      - SymbolicTerm / Number          -> int
#      - SymbolicTerm / String          -> str
#      - SymbolicTerm / Function, 0-ary -> str (constant name), or
#                                           resolved value if it's a
#                                           known float-placeholder /
#                                           user-defined constant
#      - UnaryOperation (Minus)         -> negated number
#      - BinaryOperation                -> evaluated number, or a
#                                           deferred ("expr", op, l, r)
#                                           tuple if it depends on a
#                                           runtime variable binding
#      - Interval (a..b)                -> ("multi", [a, a+1, ..., b])
#      - Pool (a;b;c)                   -> ("multi", [a, b, c])
#
#    Only handles: SymbolicAtom over Function terms, with arguments
#    that are themselves Symbols (numbers/strings/constants),
#    Variables, arithmetic expressions, intervals, or pools.
#    No aggregates, no disjunction in the head.
# =====================================================================

class RuleExtractor:
    _CMP_OPS = {
        ast.ComparisonOperator.LessThan: "<",
        ast.ComparisonOperator.LessEqual: "<=",
        ast.ComparisonOperator.GreaterThan: ">",
        ast.ComparisonOperator.GreaterEqual: ">=",
        ast.ComparisonOperator.Equal: "=",
        ast.ComparisonOperator.NotEqual: "!=",
    }
    _BIN_OPS = {
        ast.BinaryOperator.Plus: lambda a, b: a + b,
        ast.BinaryOperator.Minus: lambda a, b: a - b,
        ast.BinaryOperator.Multiplication: lambda a, b: a * b,
        ast.BinaryOperator.Division: lambda a, b: a / b,
        ast.BinaryOperator.Modulo: lambda a, b: a % b,
        ast.BinaryOperator.Power: lambda a, b: a ** b,
    }

    def __init__(self, name_to_value=None):
        self.facts = set()    # ground facts: set of (pred, *args)
        self.rules = []       # list of {"head": ..., "body": [...]}
        self.name_to_value = name_to_value or {}
        self.constants = {}

    # -----------------------------------------------------------------
    # term conversion
    # -----------------------------------------------------------------

    def term_to_value(self, term):
        """Convert a clingo AST term into a Python value, var-name string,
        deferred ("expr", ...) tuple, or multi-valued ("multi", [...]) tuple."""

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
                    if sym.name in self.name_to_value:
                        return self.name_to_value[sym.name]
                    if sym.name in self.constants:
                        return self.constants[sym.name]
                    return sym.name
                raise ValueError(f"Nested function terms not supported: {sym}")

            raise ValueError(f"Unsupported symbol type: {sym.type}")

        if t == ast.ASTType.UnaryOperation:
            inner = self.term_to_value(term.argument)
            if term.operator_type == ast.UnaryOperator.Minus and isinstance(inner, (int, float)):
                return -inner
            raise ValueError(f"Unsupported unary operation: {term}")

        if t == ast.ASTType.BinaryOperation:
            op = term.operator_type

            if op not in self._BIN_OPS:
                raise ValueError(f"Unsupported binary operator {op!r}: {term}")

            left = self.term_to_value(term.left)
            right = self.term_to_value(term.right)

            if is_var(left) or is_var(right):
                # depends on a runtime binding -> defer to evaluation
                return ("expr", op, left, right)

            try:
                return self._BIN_OPS[op](left, right)
            except ZeroDivisionError:
                raise ValueError(f"Division by zero in: {term}")

        if t == ast.ASTType.Interval:
            left = self.term_to_value(term.left)
            right = self.term_to_value(term.right)

            if is_var(left) or is_var(right):
                raise ValueError(
                    f"Interval with unbound variable not supported here: {term}"
                )

            if not isinstance(left, int) or not isinstance(right, int):
                raise ValueError(f"Interval bounds must be integers: {term}")

            return ("multi", list(range(left, right + 1)))

        if t == ast.ASTType.Pool:
            values = [self.term_to_value(arg) for arg in term.arguments]

            flat = []
            for v in values:
                if isinstance(v, tuple) and len(v) == 2 and v[0] == "multi":
                    flat.extend(v[1])
                else:
                    flat.append(v)

            return ("multi", flat)

        raise ValueError(f"Unsupported term type: {t!r} (term: {term!r})")

    # -----------------------------------------------------------------
    # comparisons
    # -----------------------------------------------------------------

    def comparison_to_atom(self, lit, atom):

        if lit.sign == ast.Sign.Negation:
            raise ValueError(f"Unsupported negated comparison: {lit}")

        guards = atom.guards

        if len(guards) != 1:
            raise ValueError(f"Unsupported chained comparison (multiple guards): {lit}")

        guard = guards[0]
        op = guard.comparison

        if op not in self._CMP_OPS:
            raise ValueError(f"Unsupported comparison operator {op!r}: {lit}")

        left = self.term_to_value(atom.term)
        right = self.term_to_value(guard.term)

        return ("cmp", self._CMP_OPS[op], (left, right))

    # -----------------------------------------------------------------
    # literals
    # -----------------------------------------------------------------

    def literal_to_atom(self, lit):
        """
        Convert a Literal into one of:
          ("pos"/"neg", pred, args_tuple)   -- symbolic atom
          ("cmp", op, (left, right))        -- comparison, op in
                                                {"<","<=",">",">=","=","!="}

        Raises a precise ValueError for any other unsupported literal kind.
        """

        atom = lit.atom
        t = atom.ast_type

        if t == ast.ASTType.Comparison:
            return self.comparison_to_atom(lit, atom)

        if t == ast.ASTType.BodyAggregate:
            raise ValueError(f"Unsupported body aggregate (#count/#sum/...): {lit}")

        if t == ast.ASTType.Aggregate:
            raise ValueError(f"Unsupported aggregate: {lit}")

        if t == ast.ASTType.TheoryAtom:
            raise ValueError(f"Unsupported theory atom: {lit}")

        if t == ast.ASTType.BooleanConstant:
            raise ValueError(f"Unsupported boolean constant (#true/#false): {lit}")

        if t != ast.ASTType.SymbolicAtom:
            raise ValueError(f"Unsupported atom type {t!r}: {lit}")

        sym = atom.symbol

        if sym.ast_type == ast.ASTType.Pool:
            raise ValueError(f"Unsupported pooled atom (e.g. p(1;2)): {lit}")

        if sym.ast_type != ast.ASTType.Function:
            raise ValueError(f"Unsupported symbolic term type {sym.ast_type!r} in atom: {lit}")

        pred = sym.name
        args = tuple(self.term_to_value(a) for a in sym.arguments)

       

        sign = "neg" if lit.sign == ast.Sign.Negation else "pos"

        return sign, pred, args

    # -----------------------------------------------------------------
    # constant definitions ("name = value.")
    # -----------------------------------------------------------------

    def is_constant_definition(self, rule):
        """
        Detect (without resolving constants) whether `rule` has the
        raw syntactic shape 'name = value.' or 'value = name.':
        a ground, non-negated Comparison head with a single '=' guard,
        no body, where one side is a bare 0-ary Function symbol.
        """

        head = rule.head

        if head.ast_type != ast.ASTType.Literal or rule.body:
            return False

        if head.sign == ast.Sign.Negation:
            return False

        atom = head.atom

        if atom.ast_type != ast.ASTType.Comparison:
            return False

        guards = atom.guards
        if len(guards) != 1 or guards[0].comparison != ast.ComparisonOperator.Equal:
            return False

        def is_bare_constant_symbol(term):
            return (
                term.ast_type == ast.ASTType.SymbolicTerm
                and term.symbol.type == clingo.SymbolType.Function
                and len(term.symbol.arguments) == 0
            )

        left_term = atom.term
        right_term = guards[0].term

        return is_bare_constant_symbol(left_term) or is_bare_constant_symbol(right_term)

    def try_collect_constant(self, rule):
        """
        If `rule` has the shape 'name = value.', record self.constants[name]
        = value (resolving `value` through term_to_value, but NOT resolving
        `name` itself, since it's the symbol being defined) and return True.
        """

        if not self.is_constant_definition(rule):
            return False

        head = rule.head
        atom = head.atom
        guards = atom.guards

        left_term = atom.term
        right_term = guards[0].term

        def is_bare_constant_symbol(term):
            return (
                term.ast_type == ast.ASTType.SymbolicTerm
                and term.symbol.type == clingo.SymbolType.Function
                and len(term.symbol.arguments) == 0
            )

        if is_bare_constant_symbol(left_term):
            name = left_term.symbol.name
            value = self.term_to_value(right_term)
        else:
            name = right_term.symbol.name
            value = self.term_to_value(left_term)

        self.constants[name] = value
        return True

    # -----------------------------------------------------------------
    # rule / fact visiting
    # -----------------------------------------------------------------

    def visit_rule(self, rule):

        if self.try_collect_constant(rule):
            return

        head = rule.head

        if head.ast_type != ast.ASTType.Literal:
            return

        atom = head.atom

        if atom.ast_type == ast.ASTType.SymbolicAtom and atom.symbol.ast_type == ast.ASTType.Pool:
            if rule.body:
                raise ValueError(f"Pooled atom with non-empty body not supported: {rule}")
            if head.sign == ast.Sign.Negation:
                raise ValueError(f"Negated pooled head not supported: {rule}")

            for pred, args in self.expand_atom_pool(atom):
                if any(isinstance(a, str) and is_var(a) for a in args):
                    raise ValueError(f"Fact with variables not supported: {pred}{args}")
                for ground_args in expand_multi_args(args):
                    self.facts.add((pred,) + ground_args)
            return

        head_atom = self.literal_to_atom(head)

        sign, pred, args = head_atom

        if sign == "neg":
            raise ValueError(f"Negated head not supported: {pred}{args}")

        body = []

        for lit in rule.body:
            atom = self.literal_to_atom(lit)

            if atom[0] in ("pos", "neg"):
                _, _, atom_args = atom
                if any(isinstance(a, tuple) and len(a) == 2 and a[0] == "multi" for a in atom_args):
                    raise ValueError(
                        f"Interval/pool arguments not supported in body literals: {lit}"
                    )

            body.append(atom)

        if not body:
            if any(isinstance(a, str) and is_var(a) for a in args):
                raise ValueError(f"Fact with variables not supported: {pred}{args}")

            for ground_args in expand_multi_args(args):
                self.facts.add((pred,) + ground_args)
        else:
            self.rules.append({"head": (pred, args), "body": body})
        
    def expand_atom_pool(self, atom):
        """
        Given a SymbolicAtom whose .symbol is a Pool of Function terms
        (e.g. val3(1;43) -> Pool[Function val3(1), Function val3(43)]),
        return a list of (pred, args) pairs, one per pool alternative.
        Each alternative may itself contain Interval/Pool arguments,
        which are returned as ("multi", [...]) markers for the caller
        to expand further.
        """

        sym = atom.symbol

        if sym.ast_type != ast.ASTType.Pool:
            raise ValueError(f"expand_atom_pool called on non-pool atom: {atom}")

        results = []

        for alt in sym.arguments:
            if alt.ast_type != ast.ASTType.Function:
                raise ValueError(f"Unsupported pooled atom alternative: {alt}")

            pred = alt.name
            args = tuple(self.term_to_value(a) for a in alt.arguments)
            results.append((pred, args))

        return results
def expand_multi_args(args):
    """
    Given a tuple of args where some may be ("multi", [v1, v2, ...])
    markers (produced by Interval/Pool terms), yield every concrete
    ground tuple from their cartesian product. Plain (non-multi) args
    are held fixed.
    """

    choices = []

    for a in args:
        if isinstance(a, tuple) and len(a) == 2 and a[0] == "multi":
            choices.append(a[1])
        else:
            choices.append([a])

    for combo in itertools.product(*choices):
        yield combo

# =====================================================================
# 3. Evaluator (TP fixpoint per stratum)
# =====================================================================

def apply_subst(args, subst):
    return tuple(resolve(a, subst) for a in args)

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


_CMP_FUNCS = {
    "<": operator.lt,
    "<=": operator.le,
    ">": operator.gt,
    ">=": operator.ge,
    "=": operator.eq,
    "!=": operator.ne,
}


def resolve(val, subst):
    if is_var(val):
        return subst.get(val, val)

    if isinstance(val, tuple) and len(val) == 4 and val[0] == "expr":
        _, op, left, right = val

        lval = resolve(left, subst)
        rval = resolve(right, subst)

        if is_var(lval) or is_var(rval):
            raise ValueError(f"Unbound variable in arithmetic expression: {val}")

        try:
            return RuleExtractor._BIN_OPS[op](lval, rval)
        except ZeroDivisionError:
            raise ValueError(f"Division by zero evaluating: {val}")

    return val


def solve_body(body, facts):
    pos = [b for b in body if b[0] == "pos"]
    cmp = [b for b in body if b[0] == "cmp"]
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

        # --- comparison / assignment handling -----------------------
        # Repeatedly resolve "=" assignments until fixpoint, collecting
        # the remaining (non-assignment-resolved) comparisons to check.
        subst1 = dict(subst1)
        remaining = list(cmp)
        ok = True

        changed = True
        while changed:
            changed = False
            still_remaining = []

            for _, op, (left, right) in remaining:
                lval = resolve(left, subst1)
                rval = resolve(right, subst1)

                if op == "=":
                    l_unbound = is_var(lval)
                    r_unbound = is_var(rval)

                    if l_unbound and not r_unbound:
                        subst1[lval] = rval
                        changed = True
                        continue
                    if r_unbound and not l_unbound:
                        subst1[rval] = lval
                        changed = True
                        continue
                    if not l_unbound and not r_unbound:
                        if not _CMP_FUNCS["="](lval, rval):
                            ok = False
                        continue
                    # both unbound: keep for later
                    still_remaining.append((_, op, (left, right)))
                    continue

                if is_var(lval) or is_var(rval):
                    still_remaining.append((_, op, (left, right)))
                    continue

                if not _CMP_FUNCS[op](lval, rval):
                    ok = False

            remaining = still_remaining

            if not ok:
                break

        if not ok:
            continue

        if remaining:
            raise ValueError(f"Unbound variable(s) in comparisons: {remaining}")
        # --------------------------------------------------------------
        print("DEBUG subst1 before neg check:", subst1, "neg:", neg)
        # check negated literals
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

    # no more layers
    if not pred_stratum:
        return fixpoint(rules, facts)

    max_stratum = max(pred_stratum.values())

    # compute fixpoint at each layer
    for s in range(max_stratum + 1):
        rules_in_stratum = [
            r for r in rules if pred_stratum.get(r["head"][0], 0) == s
        ]
        facts = fixpoint(rules_in_stratum, facts)

    return facts


# =====================================================================
# 4. Driver
# =====================================================================

def parse_file(filename_content, name_to_value=None):

    # --- Pass 1: collect constant definitions (name = value.) ---
    const_collector = RuleExtractor(name_to_value=name_to_value)

    def collect_constants(stmt):
        if stmt.ast_type == ast.ASTType.Rule:
            const_collector.try_collect_constant(stmt)

    ast.parse_string(filename_content, collect_constants)

    # --- Pass 2: full extraction, with constants already known ---
    dep = DependencyExtractor()
    rex = RuleExtractor(name_to_value=name_to_value)
    rex.constants = dict(const_collector.constants)

    def on_statement(stmt):
        if stmt.ast_type == ast.ASTType.Rule:
            dep.visit_rule(stmt)
            rex.visit_rule(stmt)

    ast.parse_string(filename_content, on_statement)

    return dep, rex


def preprocess_floats(filename):
    """
    Read `filename`, find every float literal (e.g. 36.6, -2.5, 0.001),
    and replace each *distinct* value with a unique placeholder constant
    of the form "<base>_n" (n = 1, 2, 3, ...), where <base> is
    "_float_placeholder" or, if that string already occurs in the file,
    a version prefixed with extra underscores until it's unique.

    Occurrences of the same float value are mapped to the same
    placeholder. String literals ("...") are left untouched (floats
    inside quotes are not replaced).

    Returns:
        patched_text   : the file content with floats replaced
        value_to_name  : dict float_value -> placeholder name (str)
        name_to_value  : dict placeholder name -> float_value (reverse map)
    """

    FLOAT_RE = re.compile(r'(?<![\w.])(-?\d+\.\d+)(?![\w.])')
    STRING_RE = re.compile(r'"(?:\\.|[^"\\])*"')

    def find_free_placeholder_base(text):
        base = "_float_placeholder"

        while base in text:
            base = "_" + base

        return base

    with open(filename, "r", encoding="utf-8") as f:
        text = f.read()

    base = find_free_placeholder_base(text)

    value_to_name = {}
    name_to_value = {}
    counter = [0]

    def repl_float(m):
        val = float(m.group(1))

        if val not in value_to_name:
            counter[0] += 1
            name = f"{base}_{counter[0]}"
            value_to_name[val] = name
            name_to_value[name] = val

        return value_to_name[val]

    def repl_segment(segment):
        return FLOAT_RE.sub(repl_float, segment)

    pieces = []
    last_end = 0

    for m in STRING_RE.finditer(text):
        pieces.append(repl_segment(text[last_end:m.start()]))
        pieces.append(m.group(0))
        last_end = m.end()

    pieces.append(repl_segment(text[last_end:]))

    patched_text = "".join(pieces)

    return patched_text, value_to_name, name_to_value


def main():

    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} file.lp")
        sys.exit(1)

    filename = sys.argv[1]

    with open(filename, "r", encoding="utf-8") as f:
        raw_text = f.read()
    text_without_steps, stepped_facts = expand_stepped_intervals(raw_text)

    with open(filename + ".__tmp_stepped__", "w", encoding="utf-8") as f:
        f.write(text_without_steps)

    preprocessed_file, _, map_str_float = preprocess_floats(filename + ".__tmp_stepped__")

    print(preprocessed_file)
    print(map_str_float)

    try:
        dep, rex = parse_file(preprocessed_file, name_to_value=map_str_float)
    except RuntimeError as e:
        print("Parse error:")
        print(e)
        sys.exit(1)
    except ValueError as e:
        print(f"Background error: {e}")
        sys.exit(1)

    # inject the stepped-interval facts directly
    for pred, tuples in stepped_facts:
        dep.predicates.add(pred)
        for t in tuples:
            rex.facts.add((pred,) + t)

    stratified, sccs, violating = check_stratified(
        dep.predicates, dep.pos_edges, dep.neg_edges
    )

    if not stratified:
        print("PROGRAM IS NOT STRATIFIED")
        for u, v in violating:
            print(f"  {u} -|> {v}")
        sys.exit(1)

    print("Program is stratified.")

    pred_stratum = compute_strata(dep.predicates, dep.pos_edges, dep.neg_edges, sccs)

    try:
        answer_set = evaluate(rex.rules, rex.facts, pred_stratum)
    except ValueError as e:
        print(f"Evaluation error: {e}")
        sys.exit(1)

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