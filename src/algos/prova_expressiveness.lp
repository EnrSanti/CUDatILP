val(1).
c(1).
a(X) :- c(X), not b(X).
b(X) :- not c(X), val(X).