
species(monkey).
is_fish(monkey,0).
is_whale(monkey,0).
is_mammal(monkey,1).
habitat(X,land) :- species(X),is_whale(X,0), not ab1(X).

habitat(X,water) :-species(X), is_fish(X,0).
habitat(X,water) :-species(X), is_fish(X,1).

ab1(X) :-species(X), not is_fish(X,0).