% ho fatti x(). y().

x(12).

above_r :- x(VAL), y(VAL2), VAL2>VAL.
above_rp :- x(VAL), y(VAL2), VAL2+VAL>1.

%feature: above_r/0
%feature: above_rp/0
%feature: x/1 MIN