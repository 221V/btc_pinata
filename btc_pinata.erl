-module(btc_pinata).
-compile(export_all).

loop(Client, Server) ->
 receive 
  {tcp, Client, Data} -> 
   io:format("CLIENT: ~p~n", [Data]),
   gen_tcp:send(Server, Data),
   loop(Client, Server);
  {tcp, Server, Data} ->
   io:format("SERVER: ~p~n", [Data]),
   gen_tcp:send(Client, Data),
   loop(Client, Server)
 end.

start() ->
 {ok, Server} = gen_tcp:connect("ownme.ipredator.se", 10002, [binary, {packet, 0}, {active, true}]),
 {ok, Client} = gen_tcp:connect("ownme.ipredator.se", 10000, [binary, {packet, 0}, {active, true}]),
 loop(Client, Server).


main(_) ->
 start().