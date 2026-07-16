% ============================================================
%  IoT Greenhouse plant growth background knowledge
% ============================================================

% ── shoot-root ratio ─────────────────────────────────────────
% Classic agronomic indicator of above/below ground balance
% High S/R = shoot-dominated (good aerial growth)
% Low S/R = root-dominated (stress response)
shoot_root_ratio(R) :-
    average_wet_weight_of_the_growth_vegetative_awwgv(S),
    average_wet_weight_of_the_root_awwr(Root),
    R = S / (Root + 0.001).

dry_shoot_root_ratio(R) :-
    average_dry_weight_of_vegetative_plants_adwv(S),
    average_dry_weight_of_the_root_adwr(Root),
    R = S / (Root + 0.001).

% ── water content percentages ─────────────────────────────────
% Vegetative water content: (wet - dry) / wet
% High = succulent, well-watered plant
veg_water_content(W) :-
    average_wet_weight_of_the_growth_vegetative_awwgv(Wet),
    average_dry_weight_of_vegetative_plants_adwv(Dry),
    W = (Wet - Dry) / (Wet + 0.001) * 100.

root_water_content(W) :-
    average_wet_weight_of_the_root_awwr(Wet),
    average_dry_weight_of_the_root_adwr(Dry),
    W = (Wet - Dry) / (Wet + 0.001) * 100.

% ── dry matter efficiency ─────────────────────────────────────
% How much dry matter is being produced per unit wet weight
veg_dm_efficiency(E) :-
    average_dry_weight_of_vegetative_plants_adwv(D),
    average_wet_weight_of_the_growth_vegetative_awwgv(W),
    E = D / (W + 0.001).

root_dm_efficiency(E) :-
    average_dry_weight_of_the_root_adwr(D),
    average_wet_weight_of_the_root_awwr(W),
    E = D / (W + 0.001).

% ── specific leaf area proxy ──────────────────────────────────
leaf_size(S) :-
    average_leaf_area_of_the_plant_alap(A),
    average_number_of_plant_leaves_anpl(N),
    S = A / (N + 0.001).

% ── leaf area index proxy ─────────────────────────────────────
leaf_area_per_biomass(L) :-
    average_leaf_area_of_the_plant_alap(A),
    average_wet_weight_of_the_growth_vegetative_awwgv(W),
    L = A / (W + 0.001).

% ── chlorophyll efficiency ────────────────────────────────────
chlorophyll_density(C) :-
    average_of_chlorophyll_in_the_plant_achp(Chl),
    average_leaf_area_of_the_plant_alap(A),
    C = Chl / (A + 0.001).

chlorophyll_per_leaf(C) :-
    average_of_chlorophyll_in_the_plant_achp(Chl),
    average_number_of_plant_leaves_anpl(N),
    C = Chl / (N + 0.001).

% ── root architecture ─────────────────────────────────────────
root_fineness(F) :-
    average_root_length_arl(L),
    average_root_diameter_ard(D),
    F = L / (D + 0.001).

root_volume(V) :-
    average_root_length_arl(L),
    average_root_diameter_ard(D),
    V = L * D * D.

root_density(RD) :-
    average_dry_weight_of_the_root_adwr(W),
    average_root_length_arl(L),
    RD = W / (L + 0.001).

% ── growth efficiency ─────────────────────────────────────────
height_biomass_ratio(H) :-
    plant_height_rate_phr(Height),
    average_wet_weight_of_the_growth_vegetative_awwgv(W),
    H = Height / (W + 0.001).

growth_vigour(G) :-
    average_of_chlorophyll_in_the_plant_achp(Chl),
    plant_height_rate_phr(H),
    G = Chl * H.

% ── overall plant balance score ───────────────────────────────
total_biomass(T) :-
    average_wet_weight_of_the_growth_vegetative_awwgv(V),
    average_wet_weight_of_the_root_awwr(R),
    T = V + R.

root_fraction(F) :-
    average_wet_weight_of_the_root_awwr(R),
    total_biomass(T),
    F = R / (T + 0.001).

overall_dm_ratio(R) :-
    average_dry_weight_of_vegetative_plants_adwv(DV),
    average_dry_weight_of_the_root_adwr(DR),
    average_wet_weight_of_the_growth_vegetative_awwgv(WV),
    average_wet_weight_of_the_root_awwr(WR),
    R = (DV + DR) / (WV + WR + 0.001).

% ── IoT vs traditional greenhouse signal ─────────────────────
high_chlorophyll_efficiency :-
    chlorophyll_density(C), C > 0.1,
    veg_dm_efficiency(E), E > 0.05.

balanced_growth :-
    shoot_root_ratio(R), R > 1.5, R <= 8.0,
    root_fineness(F), F > 5.0.

stress_indicator :-
    veg_water_content(W), W < 70.0,
    root_water_content(RW), RW < 60.0.

% ============================================================
% ============================================================

%feature: shoot_root_ratio/1                   MAX DEFAULT 0.
%feature: dry_shoot_root_ratio/1               MAX DEFAULT 0.
%feature: veg_water_content/1                  MAX DEFAULT 0.
%feature: root_water_content/1                 MAX DEFAULT 0.
%feature: veg_dm_efficiency/1                  MAX DEFAULT 0.
%feature: root_dm_efficiency/1                 MAX DEFAULT 0.
%feature: leaf_size/1                          MAX DEFAULT 0.
%feature: leaf_area_per_biomass/1              MAX DEFAULT 0.
%feature: chlorophyll_density/1                MAX DEFAULT 0.
%feature: chlorophyll_per_leaf/1               MAX DEFAULT 0.
%feature: root_fineness/1                      MAX DEFAULT 0.
%feature: root_volume/1                        MAX DEFAULT 0.
%feature: root_density/1                       MAX DEFAULT 0.
%feature: height_biomass_ratio/1               MAX DEFAULT 0.
%feature: growth_vigour/1                      MAX DEFAULT 0.
%feature: total_biomass/1                      MAX DEFAULT 0.
%feature: root_fraction/1                      MAX DEFAULT 0.
%feature: overall_dm_ratio/1                   MAX DEFAULT 0.
%feature: high_chlorophyll_efficiency/0.
%feature: balanced_growth/0.
%feature: stress_indicator/0.