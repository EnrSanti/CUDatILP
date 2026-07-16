% ── petal shape ──────────────────────────────────────────────
% aspect ratio: setosa has very wide short petals (ratio ~0.3)
% virginica has long narrow petals (ratio ~0.6)
petal_aspect_ratio(R) :-
    petal_length(L),
    petal_width(W),
    R = W / (L + 0.001).

% petal area proxy: setosa tiny, virginica large
petal_area(A) :-
    petal_length(L),
    petal_width(W),
    A = L * W.

% ── sepal shape ──────────────────────────────────────────────
sepal_aspect_ratio(R) :-
    sepal_length(L),
    sepal_width(W),
    R = W / (L + 0.001).

sepal_area(A) :-
    sepal_length(L),
    sepal_width(W),
    A = L * W.

% ── sepal vs petal size contrast ─────────────────────────────
% setosa: sepal much bigger than petal
% virginica: petal approaches sepal size
petal_to_sepal_length(R) :-
    petal_length(PL),
    sepal_length(SL),
    R = PL / (SL + 0.001).

petal_to_sepal_area(R) :-
    petal_area(PA),
    sepal_area(SA),
    R = PA / (SA + 0.001).

% ── combined discriminant ────────────────────────────────────
% Fisher-style linear combination of the two most discriminating dims
% (petal_length and petal_width dominate in LDA)
petal_score(S) :-
    petal_length(L),
    petal_width(W),
    S = L + W * 2.

% sepal width is inversely correlated with species in some directions
sepal_contrast(C) :-
    sepal_width(SW),
    petal_length(PL),
    C = SW / (PL + 0.001).


%feature: petal_aspect_ratio/1      MAX DEFAULT 0.
%feature: petal_area/1              MAX DEFAULT 0.
%feature: sepal_aspect_ratio/1      MAX DEFAULT 0.
%feature: sepal_area/1              MAX DEFAULT 0.
%feature: petal_to_sepal_length/1   MAX DEFAULT 0.
%feature: petal_to_sepal_area/1     MAX DEFAULT 0.
%feature: petal_score/1             MAX DEFAULT 0.
%feature: sepal_contrast/1          MAX DEFAULT 0.
