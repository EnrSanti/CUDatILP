#!/usr/bin/env python3

import sys
from collections import defaultdict

import clingo.ast as ast


class DependencyExtractor:
    def __init__(self):
        self.predicates = set()
        self.pos_edges = []
        self.neg_edges = []

    def visit_rule(self, rule):
        """
        Extract dependencies from a normal rule.
        """

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
        """
        Return predicates occurring in the head.
        Handles normal and disjunctive heads.
        """

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
        """
        Return list of (sign,predicate)
        sign ∈ {"pos","neg"}
        """

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
        """
        Extract predicate name from a literal.

        Ignore arithmetic comparisons,
        aggregates, theory atoms, etc.
        """

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


def parse_file(filename):

    extractor = DependencyExtractor()

    def on_statement(stmt):

        if stmt.ast_type == ast.ASTType.Rule:
            extractor.visit_rule(stmt)

    ast.parse_files([filename], on_statement)
    
    return (
        extractor.predicates,
        extractor.pos_edges,
        extractor.neg_edges,
    )


def main():

    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} file.lp")
        sys.exit(1)

    filename = sys.argv[1]

    try:
        predicates, pos_edges, neg_edges = parse_file(filename)

    except RuntimeError as e:
        print("Parse error:")
        print(e)
        sys.exit(1)

    stratified, sccs, violating = check_stratified(
        predicates,
        pos_edges,
        neg_edges,
    )

    print("Predicates")
    print("----------")
    for p in sorted(predicates):
        print(p)

    print()
    print("Positive dependencies")
    print("---------------------")
    for u, v in pos_edges:
        print(f"{u} -> {v}")

    print()
    print("Negative dependencies")
    print("---------------------")
    for u, v in neg_edges:
        print(f"{u} -|> {v}")

    print()
    print("SCCs")
    print("----")
    for scc in sccs:
        print(scc)

    print()

    if stratified:
        print("PROGRAM IS STRATIFIED")
    else:
        print("PROGRAM IS NOT STRATIFIED")
        print()
        print("Violating negative dependencies:")
        for u, v in violating:
            print(f"  {u} -|> {v}")


if __name__ == "__main__":
    main()