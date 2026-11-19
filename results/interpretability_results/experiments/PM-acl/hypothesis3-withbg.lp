accept(X,'true') :- same_dept(X,N13), N13>0.0, not ab3(X), not ab4(X), not ab5(X). 
accept(X,'false') :- not subject_user_id(X,'acct__16'). 
accept(X,'false') :- subject_user_id(X,'acct__16'). 
ab1(X) :- subject_user_id(X,'auditor__16'). 
ab2(X) :- action_action_type(X,'setschedule'), not ab1(X). 
ab3(X) :- resource_resource_id(X,'none'), subject_tasks(X,'none'), not ab2(X). 
ab4(X) :- action_action_type(X,'setstatus'), subject_tasks(X,'none'). 
ab5(X) :- subject_user_id(X,'contractor__14__1'), resource_resource_id(X,'none').