reachable(X,Y) :- edge(X,Y).
reachable(X,Y) :- edge(X,Z), reachable(Z,Y).

blocked(X,Y) :- reachable(X,Y), not open(X,Y).