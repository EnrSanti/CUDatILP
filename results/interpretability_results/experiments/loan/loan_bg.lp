% ============================================================
% Loan Eligibility Background Knowledge
% ============================================================


% ------------------------------------------------------------
% Income and loan affordability
% ------------------------------------------------------------

loan_to_income_ratio(R) :-
    person_income(I),
    loan_amnt(L),
    R = L / (I + 0.001).

high_loan_burden :-
    loan_to_income_ratio(R),
    R > 0.5.


% Existing percentage of income used for loan
income_commitment(R) :-
    loan_percent_income(P),
    R = P * 100.


% Remaining income after loan obligation
remaining_income(R) :-
    person_income(I),
    loan_amnt(L),
    R = I - L.


% ------------------------------------------------------------
% Credit profile
% ------------------------------------------------------------

good_credit_score:-
    credit_score(S),
    S >= 700.


poor_credit_score :-
    credit_score(S),
    S < 600.


credit_history_strength(R) :-
    cb_person_cred_hist_length(Y),
    credit_score(S),
    R = S * Y.


% Previous defaults indicator

default_risk :-
    previous_loan_defaults_on_file("Yes").


% ------------------------------------------------------------
% Employment stability
% ------------------------------------------------------------

employment_stability(R) :-
    person_emp_exp(E),
    person_age(A),
    R = E / (A + 0.001).


experienced_worker:-
    person_emp_exp(E),
    E >= 5.


young_applicant :-
    person_age(A),
    A < 25.

% ------------------------------------------------------------
% Loan characteristics
% ------------------------------------------------------------


interest_income_ratio(R) :-
    loan_int_rate(I),
    person_income(Inc),
    R = I / (Inc + 0.001).


% ------------------------------------------------------------
% Applicant financial stability
% ------------------------------------------------------------

financial_capacity(C) :-
    person_income(I),
    credit_score(S),
    C = I * S.


risk_score(R) :-
    loan_percent_income(P),
    credit_score(S),
    previous_loan_defaults_on_file(D),
    R = P * 100 - S / 100.


% ------------------------------------------------------------
% Housing stability
% ------------------------------------------------------------

stable_housing:-
    person_home_ownership("OWN").
stable_housing:-
	person_home_ownership("MORTGAGE").


% ------------------------------------------------------------
% Loan intent groups
% ------------------------------------------------------------

educational_loan :-
    loan_intent(EDUCATION).


medical_loan:-
    loan_intent("MEDICAL").


% ------------------------------------------------------------
% Composite eligibility concepts
% ------------------------------------------------------------

low_risk_customer:-
    good_credit_score,
    not high_loan_burden,
    default_risk.


loan_affordable :-
    loan_percent_income(P),
    P < 0.3,
    credit_score(S),
    S > 650.


stable_applicant :-
    experienced_worker,
    stable_housing,
    default_risk.



% ============================================================
% Features
% ============================================================

%feature: loan_to_income_ratio/1       MAX DEFAULT 0.
%feature: high_loan_burden/0.
%feature: income_commitment/1           MAX DEFAULT 0.
%feature: remaining_income/1            MAX DEFAULT 0.
%feature: good_credit_score/0.
%feature: poor_credit_score/0.
%feature: credit_history_strength/1      MAX DEFAULT 0.
%feature: employment_stability/1         MAX DEFAULT 0.
%feature: experienced_worker/0.
%feature: young_applicant/0.
%feature: interest_income_ratio/1        MAX DEFAULT 0.
%feature: financial_capacity/1           MAX DEFAULT 0.
%feature: risk_score/1                   MAX DEFAULT 0.
%feature: stable_housing/0.
%feature: educational_loan/0.
%feature: medical_loan/0.
%feature: low_risk_customer/0.
%feature: loan_affordable/0.
%feature: stable_applicant/0.