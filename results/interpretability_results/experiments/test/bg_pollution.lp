
a(X) :- population_density(X), X>500.
b(X) :- a(X).
b(Y) :- a(X), Y=X+1.


%feature: a/1	MAX DEFAULT -2.
%feature: b/1 	ALL DEFAULT -2.