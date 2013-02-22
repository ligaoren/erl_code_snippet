
##ETS bag##

	%% select ETS table type based on your need
	
	Eshell V5.9  (abort with ^G)
	1> rd(t, {uid,fid}).
	t
	2> ets:new(t,[public,bag,named_table,{keypos, #t.uid}]).
	t
	3> ets:insert(t,#t{uid=1,fid=12}).
	true
	4> ets:insert(t,#t{uid=1,fid=13}).
	true
	5> ets:insert(t,#t{uid=1,fid=14}).
	true
	6> ets:insert(t,#t{uid=2,fid=14}).
	true
	7> ets:lookup(t,1).
	[#t{uid = 1,fid = 12},
	#t{uid = 1,fid = 13},
	#t{uid = 1,fid = 14}]
	8>
	8> ets:delete_object(t,#t{uid=1,fid=12}).
	true
	9> ets:lookup(t,1).
	[#t{uid = 1,fid = 13},#t{uid = 1,fid = 14}]
	10>


