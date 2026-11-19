accept(X,'true') :- same_dept(X,N13), N13>0.0, not ab3(X), not ab4(X), not ab5(X), not ab6(X), not ab7(X). 
accept(X,'false') :- not subject_user_id(X,'acct__1'). 
accept(X,'false') :- subject_user_id(X,'acct__1'). 
ab1(X) :- subject_user_id(X,'auditor__16'). 
ab2(X) :- action_action_type(X,'setschedule'), not ab1(X). 
ab3(X) :- resource_resource_id(X,'none'), subject_tasks(X,'none'), not ab2(X). 
ab4(X) :- resource_resource_id(X,'task__5__2__0'), not subject_user_id(X,'acct__5'). 
ab5(X) :- resource_resource_id(X,'none'), subject_user_id(X,'contractor__14__1'). 
ab6(X) :- resource_resource_id(X,'task__12__1__3'), not subject_user_id(X,'employee__12__0'). 
ab7(X) :- subject_user_id(X,'employee__1__0'), resource_resource_id(X,'none').