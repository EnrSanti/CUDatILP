% ============================================================
%  Project-management access control: background knowledge (v2)
%  Idea: access depends on (1) what the role may do on that kind of
%  resource and (2) whether the resource is in the subject's department
% ============================================================

% ── department of the subject ─────────────────────────────────
% not given directly: every subject has exactly one of subject_projects
% (employee, contractor, planner, accountant, auditor), subject_project_leds
% (projectleader) or subject_dept_id (manager), all pointing to one dept
subject_dept(D) :-
    subject_projects(P),
    project_dept(P, D).
subject_dept(D) :-
    subject_project_leds(P),
    project_dept(P, D).
subject_dept(D) :-
    subject_dept_id(D).

has_resource :-
    resource_type(_).

% ── same department ──────────────────────────────────────────
% subject and resource are in the same department: 381 rows,
% all accepted except one
same_dept :-
    subject_dept(D),
    resource_dept_id(D).

% ── permission matrix without a resource ────────────────────
% generic requests with no resource: only some (role, action) pairs
% are ever accepted
permitted_generic :-
    subject_role(contractor),
    action_action_type(read),
    not has_resource.
permitted_generic :-
    subject_role(contractor),
    action_action_type(request),
    not has_resource.
permitted_generic :-
    subject_role(employee),
    action_action_type(read),
    not has_resource.
permitted_generic :-
    subject_role(employee),
    action_action_type(request),
    not has_resource.
permitted_generic :-
    subject_role(planner),
    action_action_type(setschedule),
    not has_resource.

permitted_action :- permitted_generic.


% project ids encode their department (proj__14__0 is in dept__14);
% ASP cannot split strings, so the mapping is given as facts
project_dept(proj__0__0, dept__0).
project_dept(proj__0__1, dept__0).
project_dept(proj__1__0, dept__1).
project_dept(proj__1__1, dept__1).
project_dept(proj__2__0, dept__2).
project_dept(proj__2__1, dept__2).
project_dept(proj__3__0, dept__3).
project_dept(proj__3__1, dept__3).
project_dept(proj__4__0, dept__4).
project_dept(proj__4__1, dept__4).
project_dept(proj__5__0, dept__5).
project_dept(proj__5__1, dept__5).
project_dept(proj__5__2, dept__5).
project_dept(proj__5__3, dept__5).
project_dept(proj__6__0, dept__6).
project_dept(proj__6__1, dept__6).
project_dept(proj__7__0, dept__7).
project_dept(proj__7__1, dept__7).
project_dept(proj__7__2, dept__7).
project_dept(proj__7__3, dept__7).
project_dept(proj__8__0, dept__8).
project_dept(proj__8__1, dept__8).
project_dept(proj__9__0, dept__9).
project_dept(proj__9__1, dept__9).
project_dept(proj__10__0, dept__10).
project_dept(proj__10__1, dept__10).
project_dept(proj__11__0, dept__11).
project_dept(proj__11__1, dept__11).
project_dept(proj__11__2, dept__11).
project_dept(proj__11__3, dept__11).
project_dept(proj__12__0, dept__12).
project_dept(proj__12__1, dept__12).
project_dept(proj__13__0, dept__13).
project_dept(proj__13__2, dept__13).
project_dept(proj__13__3, dept__13).
project_dept(proj__14__0, dept__14).
project_dept(proj__14__1, dept__14).
project_dept(proj__14__2, dept__14).
project_dept(proj__14__3, dept__14).
project_dept(proj__15__0, dept__15).
project_dept(proj__15__1, dept__15).
project_dept(proj__16__0, dept__16).
project_dept(proj__16__1, dept__16).
project_dept(proj__17__0, dept__17).
project_dept(proj__17__1, dept__17).
project_dept(proj__17__2, dept__17).
project_dept(proj__17__3, dept__17).
project_dept(proj__18__0, dept__18).
project_dept(proj__18__1, dept__18).
project_dept(proj__19__0, dept__19).
project_dept(proj__19__1, dept__19).


%feature: same_dept/0.
%feature: permitted_action/0.
