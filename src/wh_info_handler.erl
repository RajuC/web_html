-module(wh_info_handler).

-export([init/3]).
-export([allowed_methods/2]).
-export([content_types_provided/2]).

-export([handle_get/2]).


init(_Protocol, _Req, _Opts) ->
    {upgrade, protocol, cowboy_rest}.

allowed_methods(Req, State) ->
	{[<<"GET">>], Req, State}.

content_types_provided(Req, State) ->
    {[{{<<"application">>, <<"json">>, '*'}, handle_get}],
        Req, State}.

handle_get(Req, State) ->
    lager:info("~p||handle_get||Info Request",[?MODULE]),
    Res = lists:map(
           fun({Name, Info, Version}) ->
             [{Name, [{description, list_to_binary(Info)},
                      {version, list_to_binary(Version)}]}]
           end,
           application:which_applications()),
    {jsx:encode(Res),
     Req,
     State}.
