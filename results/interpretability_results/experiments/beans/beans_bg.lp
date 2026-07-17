% ── solidity / convexity irregularity ────────────────────────
% solidity_gap: 1 - solidity, i.e. fraction of convex hull that
% is "missing" from the actual bean shape (indentation/concavity)
% Barbunya highest (~0.017) = most irregular boundary,
% Seker lowest (~0.009) = smoothest, most convex shape
solidity_gap(G) :-
    solidity(S),
    G = 1 - S.

% ── roundness vs compactness divergence ──────────────────────
% these two metrics agree closely for "normal" shapes but diverge
% for elongated ones; Barbunya is near zero (both metrics agree),
% Horoz/Dermason/Sira show a consistent positive gap (~0.09-0.10)
roundness_compact_gap(G) :-
    roundness(R),
    compactness(C),
    G = R - C.

% ── shape factor cross-ratio ──────────────────────────────────
% shapeFactor1 and shapeFactor3 both encode area normalization
% but at different powers; their ratio strips out redundancy
% Horoz highest (~0.014), Bombay lowest (~0.0055)
sf1_sf3_ratio(R) :-
    shapeFactor1(S1),
    shapeFactor3(S3),
    R = S1 / (S3 + 0.000001).

% ── extent-solidity interaction ───────────────────────────────
% extent (bbox fill) and solidity (hull fill) multiplied together
% penalizes beans that are loose in BOTH senses simultaneously;
% Seker highest (~0.767, tightly packed both ways), Horoz lowest (~0.693)
extent_solidity_prod(P) :-
    extent(E),
    solidity(S),
    P = E * S.

% ── eccentricity vs roundness divergence ──────────────────────
% eccentricity measures ellipse elongation, roundness measures
% area/perimeter compactness; a large negative gap flags beans
% that are "round by area" but "elongated by ellipse fit"
% Seker most negative (~-0.363), Horoz only positive class (~0.075)
ecc_roundness_gap(G) :-
    eccentricity(E),
    roundness(R),
    G = E - R.

% ── perimeter economy relative to axes ────────────────────────
% how much boundary length is "spent" per unit of combined axis
% length; lower values mean a more efficient (rounder) boundary
% Dermason lowest (~1.609), Barbunya highest (~1.708)
perimeter_per_axis(R) :-
    perimeter(P),
    majorAxisLength(L),
    minorAxisLength(W),
    R = P / (L + W + 0.000001).

% ── area efficiency vs squared perimeter ──────────────────────
% isoperimetric-style ratio: max for a perfect circle is 1/(4*pi);
% Dermason closest to that ideal (~0.0726), Horoz farthest (~0.0633)
area_per_perimeter2(R) :-
    area(A),
    perimeter(P),
    R = A / (P * P + 0.000001).


%feature: solidity_gap/1               MAX DEFAULT 0.
%feature: roundness_compact_gap/1      MAX DEFAULT 0.
%feature: sf1_sf3_ratio/1              MAX DEFAULT 0.
%feature: extent_solidity_prod/1       MAX DEFAULT 0.
%feature: ecc_roundness_gap/1          MAX DEFAULT 0.
%feature: perimeter_per_axis/1         MAX DEFAULT 0.
%feature: area_per_perimeter2/1        MAX DEFAULT 0.