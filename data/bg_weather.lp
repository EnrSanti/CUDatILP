humidity_index(HI) :-
    humidity(H),
    temperature(T),
    HI = H*T/100.

cloud_density(CD) :-
    cloud_cover(C),
    humidity(H),
    CD = C*H/100.

thermal_instability(TI) :-
    temperature_change( DT),
    humidity(H),
    DT >= 0,
    TI = DT*H.

thermal_instability(TI) :-
    temperature_change( DT),
    humidity( H),
    DT < 0,
    TI = (- DT)*H.

cloud_instability( CI) :-
    cloud_density( CD),
    pressure_change( DP),
    DP >= 0,
    CI = CD*DP.

cloud_instability( CI) :-
    cloud_density( CD),
    pressure_change( DP),
    DP < 0,
    CI = CD*(-DP).



storm_potential( SP) :-
    cloud_instability( CI),
    thermal_instability( TI),
    SP = CI*TI.



rain_potential( RP) :-
    humidity_index( HI),
    cloud_density( CD),
    RP = HI*CD.



visibility_degradation( VD) :-
    humidity_index( HI),
    cloud_density( CD),
    VD = HI + CD.

%feature: humidity_index/1 MAX default 1.
%feature: cloud_instability/1 MAX default 1.
%feature: storm_potential/1 MAX default 1.
%feature: rain_potential/1 MAX default 1.
%feature: visibility_degradation/1 MAX default 1.