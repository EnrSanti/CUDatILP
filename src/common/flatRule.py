from dataclasses import dataclass, field
@dataclass
class FlatState:

    nodes: list = field(default_factory=list)
    literals: list = field(default_factory=list)
    edges: list = field(default_factory=list)
    #use for construction


    @classmethod
    def from_root(cls, root):
        ids = cls._assign_ids(root)
        return cls._flatten(root, ids)

    @staticmethod
    def _assign_ids(root):
        ids = {}
        stack = [root]

        while stack:
            node = stack.pop()

            if id(node) in ids:
                continue

            node_id = len(ids)
            ids[id(node)] = node_id

            _, _, subrules, _ = node
            stack.extend(subrules)

        return ids

    @classmethod
    def _flatten(cls, root, ids):
        state = cls()

        stack = [root]

        while stack:
            node = stack.pop()
            node_id = ids[id(node)]

            _, L, subrules, _ = node

            start_L = len(state.literals)
            state.literals.extend(L)

            state.nodes.append([node_id, start_L, len(L)])

            for sub in subrules:
                state.edges.append((node_id, ids[id(sub)]))
                stack.append(sub)

        return state