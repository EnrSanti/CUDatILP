% ── NPK ──────────────────────────────────────────────────────
npk_total(T) :-
    nitrogen(N), phosphorous(P), potassium(K),
    T = N + P + K.

nitrogen_ratio(R) :-
    nitrogen(N), npk_total(T),
    R = N / (T + 0.001).

pk_ratio(R) :-
    phosphorous(P), potassium(K),
    R = P / (K + 0.001).

cn_ratio(R) :-
    carbon(C), nitrogen(N),
    R = C / (N + 0.001).

% ── water / climate ──────────────────────────────────────────
water_index(W) :-
    rainfall(R), humidity(H),
    W = R * H / 100.

effective_moisture(M) :-
    humidity(H), temperature(T),
    M = H / (T + 1).

rainfall_efficiency(RE) :-
    rainfall(R), effective_moisture(M),
    RE = R * M / 100.

heat_load(HL) :-
    temperature(T), rainfall(R),
    HL = T / (R + 0.1) * 100.

aridity_index(AI) :-
    temperature(T), rainfall(R),
    AI = T * T / (R + 1).

ph_deviation(D) :-
    ph(P),
    D = P - 7.

fertility_score(F) :-
    npk_total(T), carbon(C),
    F = T * (1 + C).

nutrient_efficiency(E) :-
    fertility_score(F), rainfall(R),
    E = F / (R + 1) * 100.

% ── climate zone scores ───────────────────────────────────────
% Only define the 1 case — DEFAULT 0 handles the missing case

tropical_score(1) :-
    temperature(T), humidity(H), rainfall(R),
    T > 25, H > 75, R > 150.

arid_score(1) :-
    temperature(T), humidity(H),
    T > 30, H < 40.

temperate_score(1) :-
    temperature(T), rainfall(R),
    T > 15, T <= 28, R > 80, R <= 200.

cool_moist_score(1) :-
    temperature(T), humidity(H),
    T < 20, H > 60.

% ── pH zone scores ────────────────────────────────────────────
acidic_score(1) :-
    ph(P), P < 5.5.

alkaline_score(1) :-
    ph(P), P > 7.5.

neutral_ph_score(1) :-
    ph(P), P >= 6.0, P <= 7.0.

% ── compound scores ───────────────────────────────────────────
% These only use base features directly — no dependency on other scores
% to avoid stratification issues

paddy_score(1) :-
    temperature(T), humidity(H), rainfall(R), ph(P),
    T > 25, H > 75, R > 150,
    water_index(W), W > 150,
    P < 7.

plantation_score(1) :-
    temperature(T), humidity(H), rainfall(R),
    carbon(C), ph(P),
    T > 25, H > 75, R > 150,
    P < 5.5, C > 1.0.

legume_score(1) :-
    nitrogen_ratio(R), pk_ratio(PR), ph(P),
    R < 0.4, PR > 0.8,
    P >= 6.0, P <= 7.0.

% ============================================================
% ============================================================
%feature: npk_total/1            MAX DEFAULT 0.
%feature: nitrogen_ratio/1       MAX DEFAULT 0.
%feature: pk_ratio/1             MAX DEFAULT 0.
%feature: cn_ratio/1             MAX DEFAULT 0.
%feature: water_index/1          MAX DEFAULT 0.
%feature: effective_moisture/1   MAX DEFAULT 0.
%feature: rainfall_efficiency/1  MAX DEFAULT 0.
%feature: heat_load/1            MAX DEFAULT 0.
%feature: aridity_index/1        MAX DEFAULT 0.
%feature: ph_deviation/1         MAX DEFAULT 0.
%feature: fertility_score/1      MAX DEFAULT 0.
%feature: nutrient_efficiency/1  MAX DEFAULT 0.
%feature: tropical_score/1       MAX DEFAULT 0.
%feature: arid_score/1           MAX DEFAULT 0.
%feature: temperate_score/1      MAX DEFAULT 0.
%feature: cool_moist_score/1     MAX DEFAULT 0.
%feature: acidic_score/1         MAX DEFAULT 0.
%feature: alkaline_score/1       MAX DEFAULT 0.
%feature: neutral_ph_score/1     MAX DEFAULT 0.
%feature: paddy_score/1          MAX DEFAULT 0.
%feature: plantation_score/1     MAX DEFAULT 0.
%feature: legume_score/1         MAX DEFAULT 0.