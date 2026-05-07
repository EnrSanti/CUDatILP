from dataclasses import dataclass, field
@dataclass
class FlatState:

    nodes: list = field(default_factory=list)
    literals: list = field(default_factory=list)
    #use for construction
    @classmethod
    def from_root(cls, root):
        return cls._flatten(root)


    @classmethod
    def _flatten(cls, root):

        state = cls()
        stack = [(root,0)]

        while stack:

            node,lv = stack.pop()

            _, L, subrules, _ = node

            start_L = len(state.literals)
            state.literals.extend(L)
                
            #aggiunge node
            state.nodes.append([start_L, len(L),lv])

            lv+=1
            for sub in subrules:
                stack.append((sub,lv))

        return state