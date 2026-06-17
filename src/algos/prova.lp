k=10.
val((1..k)).
val2(1..10,2..10).
val3(1;43).
cose(X) :- val(X), not val(X+1).
species(monkey).
is_fish(monkey,0).
is_whale(monkey,0).
is_mammal(monkey,1).
habitat(X,land) :- species(X),is_whale(X,0.5), not ab1(X).

habitat(X,water) :- species(X), is_fish(X,0.5).
habitat(X,water) :- species(X), is_fish(X,1.5).
habitat(ab,water) :- 2*2<6.
x=1200.
val(x).
habitat(ab1,water) :- (2*2.5)**2<Y, Y=X, val(X).

ab1(X) :- not is_fish(X,0), species(X).
ab2(X) :- atom(X), X<20.
ab2(X) :- atom(X),atom(Y), X<Y.

%commenti not
q :-val(12).
%feature: species/1 MIN
%feature: q 
