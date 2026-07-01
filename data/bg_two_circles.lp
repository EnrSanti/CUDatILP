% ho fatti x(). y().

inside_small :- x(VAL), y(VAL2).
inside_big :- x(VAL), y(VAL2), VAL < 0.4.
%feature: inside_small/0
%feature: inside_big/0