#  ETS Test Quick Code #

##ETS Easy##
	Eshell V5.9  (abort with ^G)
	1> rd(user,{id,name,password}).
	user
	2>
	2> ets:new(u,[named_table,{keypos,#user.id}]).
	u
	3> [ets:insert(u,#user{id=Item}) || Item <-[1,2,3,4,5,6]].
	[true,true,true,true,true,true]
	4> ets:match(u,{'_','$1','_','_'}).
	[[1],[2],[3],[4],[5],[6]]
	5>

	Eshell V5.9  (abort with ^G)
	1> rd(p,{id ,name ,lev,t}).
	p
	2> rd(t,{pid,socket}).
	t
	3> ets:new(test,[named_table,{keypos,2}]).
	test
	4> [ ets:insert(test, #p{id=X,name=integer_to_list(X),lev=X-1,t= #t{pid=X+3,socket=(X-2)} }) || X<-lists:seq(1,10)].
	[true,true,true,true,true,true,true,true,true,true]
	5> ets:i(test).
	<1   > {p,9,"9",8,{t,12,7}}
	<2   > {p,6,"6",5,{t,9,4}}
	<3   > {p,7,"7",6,{t,10,5}}
	<4   > {p,5,"5",4,{t,8,3}}
	<5   > {p,4,"4",3,{t,7,2}}
	<6   > {p,8,"8",7,{t,11,6}}
	<7   > {p,3,"3",2,{t,6,1}}
	<8   > {p,2,"2",1,{t,5,0}}
	<9   > {p,10,"10",9,{t,13,8}}
	<10  > {p,1,"1",0,{t,4,-1}}
	EOT  (q)uit (p)Digits (k)ill /Regexp -->q
	ok
	 7> ets:match(test,#p{name='$1', t=#t{pid='$2'}, lev=3}).
	[]
	8> ets:match(test,#p{name='$1', t=#t{pid='$2',_='_'}, lev=3}).
	[]
	9> ets:match(test,#p{name='$1', t=#t{pid='$2',_='_'}, lev=3,_='_'}).
	[["4",7]]
	10> [ ets:insert(test, #p{id=X,name=integer_to_list(X),lev=X-5,t= #t{pid=X+3,socket=(X-2)} }) || X<-lists:seq(1,20)].
	[true,true,true,true,true,true,true,true,true,true,true,
	true,true,true,true,true,true,true,true,true]
	11> ets:i(test).
	12> [ ets:insert(test, #p{id=X,name=integer_to_list(X),lev=X-5,t= #t{pid=X+3,socket=(X-2)} }) || X<-lists:seq(9,30)].
	[true,true,true,true,true,true,true,true,true,true,true,
	true,true,true,true,true,true,true,true,true,true,true]
	13> ets:i(test).
	14> [ ets:insert(test, #p{id=X,name=integer_to_list(X),lev=X,t= #t{pid=X+3,socket=(X-2)} }) || X<-lists:seq(1,20)].
	[true,true,true,true,true,true,true,true,true,true,true,
	true,true,true,true,true,true,true,true,true]
	15> ets:i(test).
	16> ets:match(test,#p{name='$1', t=#t{pid='$2',_='_'}, lev=6,_='_'}).
	[["6",9]]
	17> ets:insert(test,{p,2999,"230",3,{t,261,211}}).
	true
	18> ets:match(test,#p{name='$1', t=#t{pid='$2',_='_'}, lev=6,_='_'}).
	[["6",9]]
	19> ets:match(test,#p{name='$1', t=#t{pid='$2',_='_'}, lev=3,_='_'}).
	[["3",6],["230",261]]
	20> MS = ets:fun2ms(fun(#p{name=Name, t=#t{pid=Pid}, lev=3})  -> [Name,Pid ] end   ).
	[{#p{id = '_',name = '$1',lev = 3,
	     t = #t{pid = '$2',socket = '_'}},
	  [],
	  [['$1','$2']]}]
	21>    MSResult = ets:select(test , MS ).
	[["3",6],["230",261]]
	22> 

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


