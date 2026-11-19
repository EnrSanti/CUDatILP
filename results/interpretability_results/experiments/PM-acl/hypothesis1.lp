accept(X,'true') :- not subject_role(X,'auditor'), not ab1(X), not ab2(X), not ab3(X), not ab4(X). 
accept(X,'false') :- not action_action_type(X,'read'). 
accept(X,'true') :- subject_role(X,'auditor'). 
accept(X,'false') :- not subject_user_id(X,'contractor__15__0'). 
accept(X,'false') :- subject_user_id(X,'contractor__15__0'). 
ab1(X) :- action_action_type(X,'read'), resource_resource_id(X,'task__13__3__4'). 
ab2(X) :- action_action_type(X,'read'), resource_resource_id(X,'task__17__3__1'). 
ab3(X) :- action_action_type(X,'read'), resource_resource_id(X,'task__9__1__2'). 
ab4(X) :- action_action_type(X,'read'), subject_user_id(X,'pjl6__1'), not resource_resource_id(X,'bg__6__1').