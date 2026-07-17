% GOOD air: CO low AND far from industry 
% so good requires BOTH conditions simultaneously
% a single feature that is small only when both are satisfied
good_air_index(G) :-
    co(C), proximity_to_industrial_areas(D),
    G = C * (1 / (D + 0.1)).

% HAZARDOUS: co>2.01 OR no2>26.5 
% normalised to their respective thresholds
hazard_driver(H) :-
    co(C), no2(N),
    H = C / 2.01 + N / 26.5.


% near industry AND humid = worst poor conditions
% product captures co-occurrence
poor_driver(P) :-
    proximity_to_industrial_areas(D), humidity(H),
    P = H / (D + 0.1).

% moderate is the "middle" — not clean enough for good, not bad enough for hazardous
% encode as distance from the good/hazardous boundaries
moderate_zone(M) :-
    co(C), temperature(T),
    M = C * T / 100.

% SO2<=7.2 defines good independently of CO
% so SO2 is a "clean background" indicator
% combine with proximity: clean background near industry is suspicious
so2_proximity(SP) :-
    so2(S), proximity_to_industrial_areas(D),
    SP = S * (1 / (D + 0.1)).

% NO2>26.5 triggers hazardous — NO2 is purely industrial/traffic
% at short distances it dominates; encode the distance decay
no2_local(NL) :-
    no2(N), proximity_to_industrial_areas(D),
    NL = N / (D * D + 0.1).

% humidity>47.2 triggers poor — humidity traps ALL pollutants
% so humidity should amplify whichever gas is already elevated
humidity_trap(HT) :-
    humidity(H), co(C), no2(N),
    HT = H * (C + N / 10) / 100.

%feature: good_air_index/1   MAX DEFAULT 0.
%feature: hazard_driver/1    MAX DEFAULT 0.
%feature: poor_driver/1      MAX DEFAULT 0.
%feature: moderate_zone/1    MAX DEFAULT 0.
%feature: so2_proximity/1    MAX DEFAULT 0.
%feature: no2_local/1        MAX DEFAULT 0.
%feature: humidity_trap/1    MAX DEFAULT 0.