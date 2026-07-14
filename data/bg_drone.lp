
% battery consumption: heavier payload + longer route = more energy used
battery_consumption(C) :-
    distance(D),
    payload(P),
    C = D*(1 + P).

% wind load: heavier drone is less affected by wind
wind_load(L) :-
    wind_speed(W),
    drone_mass(M),
    L = W/M.

% effective battery: charge remaining after the mission
effective_battery(E) :-
    battery(B),
    battery_consumption(C),
    E = B - C.

% flight stress: wind load amplified by payload
flight_stress(S) :-
    wind_load(W),
    payload(P),
    S = W*(1+P).

% collision time: seconds to reach nearest obstacle
collision_time(T) :-
    nearest_obstacle(D),
    relative_speed(V),
    T = D/(V+0.01).

% collision severity: kinetic energy proxy
collision_severity(S) :-
    drone_mass(M),
    relative_speed(V),
    S = M*V*V.

% impact risk: severity penalised by reaction time available
impact_risk(R) :-
    collision_time(T),
    collision_severity(S),
    R = S/(T+1).

% mission score: battery margin relative to flight stress
mission_score(S) :-
    effective_battery(B),
    flight_stress(F),
    S = B/(F+1).

%feature: effective_battery/1 MAX DEFAULT 0.
%feature: flight_stress/1 MAX DEFAULT 0.
%feature: impact_risk/1 MAX DEFAULT 0.
%feature: mission_score/1 MAX DEFAULT 0.
