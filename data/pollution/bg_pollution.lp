% Combined particulate burden
pm_total(T) :-
    pm25(P25),
    pm10(P10),
    T = P25 + P10.

% Fine-to-coarse ratio: high ratio = more dangerous fine particles
pm_fine_ratio(R) :-
    pm25(P25),
    pm10(P10),
    R = P25 / (P10 + 0.001).

% Combined gas load
gas_index(G) :-
    no2(N),
    so2(S),
    co(C),
    G = N + S + C*10.

% NO2-SO2 interaction: both from combustion, synergistic effect
combustion_index(CI) :-
    no2(N),
    so2(S),
    CI = N * S.

% Proximity-weighted pollution: close industry + high gas = dangerous
industrial_exposure(E) :-
    gas_index(G),
    proximity_to_industrial_areas(D),
    E = G / (D + 0.1).

% PM scaled by industrial proximity
industrial_pm_risk(R) :-
    pm_total(T),
    proximity_to_industrial_areas(D),
    R = T / (D + 0.1).

% High humidity traps pollutants, low temp reduces dispersion
dispersion_factor(DF) :-
    temperature(T),
    humidity(H),
    DF = T / (H + 0.1).

% Humidity amplifies PM danger (particles absorb moisture, penetrate deeper)
humid_pm_index(HPI) :-
    pm25(P),
    humidity(H),
    HPI = P * H / 100.

% People exposed to industrial pollution
population_industrial_risk(PIR) :-
    population_density(PD),
    industrial_exposure(E),
    PIR = PD * E / 1000.

% People breathing fine particles
population_pm_risk(PPR) :-
    population_density(PD),
    humid_pm_index(HPI),
    PPR = PD * HPI / 1000.

% Full pollution burden: all gases + particles
pollution_burden(PB) :-
    pm_total(PT),
    gas_index(G),
    PB = PT + G.

% Health risk score: burden weighted by population and proximity
health_risk_score(HRS) :-
    pollution_burden(PB),
    population_density(PD),
    proximity_to_industrial_areas(D),
    HRS = PB * PD / (D + 1).

% Atmospheric risk: dispersion failure under high pollution
atmospheric_risk(AR) :-
    pollution_burden(PB),
    dispersion_factor(DF),
    AR = PB / (DF + 0.1).

%feature: pm_total/1              MAX DEFAULT 0.
%feature: pm_fine_ratio/1         MAX DEFAULT 0.
%feature: gas_index/1             MAX DEFAULT 0.
%feature: combustion_index/1      MAX DEFAULT 0.
%feature: industrial_exposure/1   MAX DEFAULT 0.
%feature: industrial_pm_risk/1    MAX DEFAULT 0.
%feature: dispersion_factor/1     MAX DEFAULT 0.
%feature: humid_pm_index/1        MAX DEFAULT 0.
%feature: population_industrial_risk/1  MAX DEFAULT 0.
%feature: population_pm_risk/1    MAX DEFAULT 0.
%feature: pollution_burden/1      MAX DEFAULT 0.
%feature: health_risk_score/1     MAX DEFAULT 0.
%feature: atmospheric_risk/1      MAX DEFAULT 0.