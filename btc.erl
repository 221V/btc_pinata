-module(btc).
-compile(export_all).

tohex(Data) ->
	string:join([integer_to_list(X,16) || X <- Data], "").


%to_hex(X) when X < 10 -> X + $0;
%to_hex(X) -> X + $a - 10.

%bin_to_hex(Bin) -> << << ( to_hex(X) ), ( to_hex (Y) ) >> || <<X : 4, Y : 4>> <= Bin >>.

%198.167.222.202

loop(Client, Server) ->
	receive
	{tcp, Client, Data} ->
	io:format("CLIENT: ~p~n", [tohex(Data)]),
	gen_tcp:send(Server, Data),
	loop(Client, Server);
	{tcp, Server, Data} ->
	io:format("SERVER: ~p~n", [tohex(Data)]),
	gen_tcp:send(Client, Data),
	loop(Client, Server)
	end.

start() ->
	{ok, Server} = gen_tcp:connect("ownme.ipredator.se", 10002, [list, {packet, 0}, {active, true}]),
	{ok, Client} = gen_tcp:connect("ownme.ipredator.se", 10000, [list, {packet, 0}, {active, true}]),
	loop(Client, Server).


main(_) ->
	start().