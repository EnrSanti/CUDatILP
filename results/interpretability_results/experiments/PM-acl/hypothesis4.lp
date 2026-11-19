accept(X,'true') :- not action_action_type(X,'read'), not ab1(X), not ab2(X), not ab3(X). 
accept(X,'true') :- action_action_type(X,'read'), not ab4(X), not ab5(X), not ab6(X). 
accept(X,'false') :- not subject_user_id(X,'auditor__1'). 
accept(X,'false') :- subject_user_id(X,'auditor__1'). 
ab1(X) :- subject_role(X,'auditor'). 
ab2(X) :- subject_user_id(X,'employee__17__0'). 
ab3(X) :- subject_role(X,'employee'), subject_user_id(X,'employee__14__1'), not resource_resource_id(X,'task__14__0__4'). 
ab4(X) :- resource_resource_id(X,'task__13__3__4'). 
ab5(X) :- resource_resource_id(X,'task__9__1__2'). 
ab6(X) :- subject_user_id(X,'pjl6__1'), not resource_resource_id(X,'bg__6__1').