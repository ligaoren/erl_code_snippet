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

##Erlang Record Match##
	-record(test,{a,b}).
	
	tr(#test{a=1,b=3}=T) ->
	  io:format("1,3!");
	tr(#test{} =T  ) ->
	   io:format("OK");
	tr(Any) ->
	   io:format("Bad~n").
	
	
	Erlang R15B (erts-5.9) [source] [64-bit] [smp:2:2] [async-threads:0] [hipe] [kernel-poll:false]
	
	Eshell V5.9  (abort with ^G)
	1> c(v).
	v.erl:6: Warning: variable 'T' is unused
	v.erl:8: Warning: variable 'T' is unused
	v.erl:10: Warning: variable 'Any' is unused
	v.erl:37: Warning: variable 'H' is unused
	v.erl:37: Warning: variable 'T' is unused
	{ok,v}
	2> rd(test,{a,b}).
	test
	3> v:tr(#test{}).
	OKok
	4> v:tr(#test{a=1,b=3}).
	1,3!ok
	5> v:tr(#test{a=2,b=3}).
	OKok
	6>
	
	
	
	
	    attributes []
	'tr'/1 =
	    %% Line 6
	    fun (_cor0) ->
	        case _cor0 of
	          <T = {'test',1,3}> when 'true' ->
	              %% Line 7
	              call 'io':'format'
	                  ([49|[44|[51|[33]]]])
	          %% Line 8
	          <T = {'test',_cor2,_cor3}> when 'true' ->
	              %% Line 9
	              call 'io':'format'
	                  ([79|[75]])
	          %% Line 10
	          <Any> when 'true' ->
	              %% Line 11
	              call 'io':'format'
	                  ([66|[97|[100|[126|[110]]]]])
	        end
	'reload'/1 =
	    %% Line 13
	    fun (_cor0) ->
	        %% Line 14
	        case call 'code':'get_object_code'
	                 (_cor0) of
	          <{M,B,F}> when 'true' ->
	              %% Line 15
	              call 'code':'load_binary'
	                  (M, F, B)
	          ( <_cor1> when 'true' ->
	                primop 'match_fail'
	                    ({'badmatch',_cor1})
	            -| ['compiler_generated'] )
	        end 
	
