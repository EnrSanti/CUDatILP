% ============================================================
%  Online Gaming Engagement — background knowledge
% ============================================================

% ── total weekly playtime ────────────────────────────────────
% raw volume of play per week
weekly_playtime(W) :-
    playTimeHours(H),
    sessionsPerWeek(S),
    W = H * S.

high_weekly_playtime :-
    weekly_playtime(W),
    W > 20.

% ── session efficiency ───────────────────────────────────────
% how long each session lasts relative to playtime per session
session_efficiency(E) :-
    avgSessionDurationMinutes(D),
    playtimehours(H),
    E = D / (H * 60 + 0.1).

% efficiency > 1 means sessions are longer than declared playtime suggests
high_session_efficiency :-
    session_efficiency(E),
    E > 0.8.

% ── progression rate ─────────────────────────────────────────
% how fast the player levels up relative to time invested
progression_rate(PR) :-
    playerLevel(L),
    weekly_playtime(W),
    PR = L / (W + 0.1).

fast_progressor :-
    progression_rate(PR),
    PR > 3.

slow_progressor :-
    progression_rate(PR),
    PR < 0.5.

% ── achievement density ──────────────────────────────────────
% achievements per level: measures completionist tendency
achievement_density(AD) :-
    achievementsUnlocked(A),
    playerLevel(L),
    AD = A / (L + 0.1).

high_achievement_density :-
    achievement_density(AD),
    AD > 1.5.

low_achievement_density :-
    achievement_density(AD),
    AD < 0.3.

% ── commitment index ─────────────────────────────────────────
% sessions per week weighted by duration: true time commitment
commitment_index(CI) :-
    sessionsPerWeek(S),
    avgSessionDurationMinutes(D),
    CI = S * D / 60.

high_commitment :-
    commitment_index(CI),
    CI > 15.

low_commitment :-
    commitment_index(CI),
    CI < 3.

% ── purchase engagement ──────────────────────────────────────
% buyers who also play a lot: strong retention signal
invested_player :-
    inGamePurchases(P),
    high_weekly_playtime,
    P > 0.

% buyer with high commitment: monetisation + engagement
monetised_engaged :-
    inGamePurchases(P),
    high_commitment,
    P > 0.

% ── difficulty-progression fit ───────────────────────────────
% playing hard games at high level = skilled retained player
skilled_engaged :-
    gameDifficulty(hard),
    playerLevel(L),
    L > 50.

% playing easy games at low level = casual / at-risk churn
casual_low_skill :-
    gameDifficulty(easy),
    playerLevel(L),
    L < 20.

% mismatch: high level on easy game = bored, churn risk
boredom_risk :-
    gameDifficulty(easy),
    playerLevel(L),
    L > 60.

% ── age-adjusted engagement ──────────────────────────────────
% younger players with high weekly playtime: core demographic
young_heavy_player :-
    age(A),
    high_weekly_playtime,
    A < 25.

% older players with high commitment: highly retained niche
mature_committed :-
    age(A),
    high_commitment,
    A > 35.

% ── session consistency ──────────────────────────────────────
% many short sessions vs few long ones
session_intensity(SI) :-
    avgSessionDurationMinutes(D),
    sessionsPerWeek(S),
    SI = D / (S + 0.1).

% long rare sessions: binge pattern
binge_player :-
    session_intensity(SI),
    SI > 60.

% short frequent sessions: habit-loop pattern (strong retention)
habit_loop_player :-
    session_intensity(SI),
    sessionsPerWeek(S),
    SI < 30,
    S > 5.

% ── compound engagement signals ──────────────────────────────
% all strong signals present: predict High
strong_engagement :-
    high_commitment,
    high_achievement_density,
    not boredom_risk.

% weak signals across the board: predict Low
weak_engagement :-
    low_commitment,
    low_achievement_density,
    not invested_player.

% mixed signals: predict Medium
mixed_engagement :-
    not strong_engagement,
    not weak_engagement.


% numerical
%feature: weekly_playtime/1        MAX DEFAULT 0.
%feature: session_efficiency/1     MAX DEFAULT 0.
%feature: progression_rate/1       MAX DEFAULT 0.
%feature: achievement_density/1    MAX DEFAULT 0.
%feature: commitment_index/1       MAX DEFAULT 0.
%feature: session_intensity/1      MAX DEFAULT 0.

% binary
%feature: high_weekly_playtime/0.
%feature: high_session_efficiency/0.
%feature: fast_progressor/0.
%feature: slow_progressor/0.
%feature: high_achievement_density/0.
%feature: low_achievement_density/0.
%feature: high_commitment/0.
%feature: low_commitment/0.
%feature: invested_player/0.
%feature: monetised_engaged/0.
%feature: skilled_engaged/0.
%feature: casual_low_skill/0.
%feature: boredom_risk/0.
%feature: young_heavy_player/0.
%feature: mature_committed/0.
%feature: binge_player/0.
%feature: habit_loop_player/0.
%feature: strong_engagement/0.
%feature: weak_engagement/0.
%feature: mixed_engagement/0.