## Echo Code ##

	-module(echo).
	-compile(export_all).
	
	
	start() ->
	spawn(fun() ->self()!{ping,self()}, echo:ping_pong() end).
	
	s() ->
	  spawn(fun() -> echo:ping_pong() end).
	
	
	ping_pong() ->   
	  receive
	      {ping,From} ->timer:sleep(1000),io:format("~p Receive ~p From ~p.~n",[self(),ping,From]) ,From ! {pong,self()};
	      {pong,From} ->timer:sleep(1000),io:format("~p receive ~p From ~p.~n",[self(),pong,From]), From ! {ping,self()};
	      {send_ping_to,Pid} -> Pid!{ping,self()}
	  end,
	  ping_pong().



## Erlang Shell ##

	Eshell V5.9  (abort with ^G)
	1> A= echo:s().
	<0.34.0>
	2> B=echo:s().
	<0.36.0>
	3> A!{send_ping_to,B}.
	{send_ping_to,<0.36.0>}
	<0.36.0> Receive ping From <0.34.0>.
	<0.34.0> receive pong From <0.36.0>.
	<0.36.0> Receive ping From <0.34.0>.
	<0.34.0> receive pong From <0.36.0>.
	<0.36.0> Receive ping From <0.34.0>.
	<0.34.0> receive pong From <0.36.0>.
	<0.36.0> Receive ping From <0.34.0>.
	<0.34.0> receive pong From <0.36.0>.
	<0.36.0> Receive ping From <0.34.0>.
	<0.34.0> receive pong From <0.36.0>.
	<0.36.0> Receive ping From <0.34.0>.
	4> 
	
	
	
	
	22> process_info(A).
	[{current_function,{echo,ping_pong,1}},
	{initial_call,{erlang,apply,2}},
	{status,waiting},
	{message_queue_len,0},
	{messages,[]},
	{links,[]},
	{dictionary,[]},
	{trap_exit,false},
	{error_handler,error_handler},
	{priority,normal},
	{group_leader,<0.25.0>},
	{total_heap_size,233},
	{heap_size,233},
	{stack_size,2},
	{reductions,3},
	{garbage_collection,[{min_bin_vheap_size,46368},
	                      {min_heap_size,233},
	                      {fullsweep_after,65535},
	                      {minor_gcs,0}]},
	{suspending,[]}]
	23> [A!{ping,self()}||_<- lists:seq(1,100)].
	
	25> process_info(A).
	[{current_function,{timer,sleep,1}},
	{initial_call,{erlang,apply,2}},
	{status,waiting},
	{message_queue_len,97},
	{messages,[{ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,<0.32.0>},
	            {ping,...},
	            {...}|...]},
	{links,[]},
	{dictionary,[]},
	{trap_exit,false},
	{error_handler,error_handler},
	{priority,normal},
	{group_leader,<0.25.0>},
	{total_heap_size,610},
	{heap_size,233},
	{stack_size,4},
	{reductions,18},
	{garbage_collection,[{min_bin_vheap_size,46368},
	                      {min_heap_size,233},
	                      {fullsweep_after,65535},
	                      {minor_gcs,1}]},
	{suspending,[]}]
	
	26> flush().
	Shell got {pong,<0.34.0>}
	Shell got {pong,<0.34.0>}
	Shell got {pong,<0.34.0>}
	Shell got {pong,<0.34.0>}
	Shell got {pong,<0.34.0>}
	Shell got {pong,<0.34.0>}
	Shell got {pong,<0.34.0>}
	Shell got {pong,<0.34.0>}
	Shell got {pong,<0.34.0>}
	Shell got {pong,<0.34.0>}
	ok
	