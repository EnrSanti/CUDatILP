% ho fatti x(). y().

above_bis :- x(VALx), y(VALy), VALy>VALx.


above(2):-above_bis.
ciao("aaa").

%feature: above_bis/0.
%feature: above/1 MIN DEFAULT -2.
%feature: ciao/1 MIN DEFAULT "abb".