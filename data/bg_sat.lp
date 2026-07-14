orbital_energy(E) :-
    velocity(V),
    altitude(H),
    E = V*V/2 - 398600.4/H.

drag_factor(D) :-
    altitude(H),
    D = 1/(H*H).

eccentricity_risk(R) :-
    eccentricity(E),
    R = E*E/(1-E).

decay_probability(P) :-
    drag_factor(D),
    eccentricity_risk(R),
    P = D*R.

collision_time(T) :-
    nearest_distance(D),
    relative_velocity(V),
    T = D/V.

collision_index(C) :-
    mass(M),
    relative_velocity(V),
    nearest_distance(D),
    C = M*V*V/(D*D).

impact_risk_score(R) :-
    collision_index(C),
    collision_time(T),
    R = C/(T+0.001).

%feature: orbital_energy/1 MAX DEFAULT 1.
%feature: drag_factor/1 MAX DEFAULT 0.
%feature: decay_probability/1 MAX DEFAULT 0.
%feature: impact_risk_score/1 MAX DEFAULT 0.
%feature: collision_index/1 MAX DEFAULT 0.