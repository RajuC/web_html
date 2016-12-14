-module(wh_id_handler).

-export([init/3]).
-export([allowed_methods/2]).
-export([content_types_provided/2]).

-export([handle_get/2]).

init(_Protocol, _Req, _Opts) ->
    {upgrade, protocol, cowboy_rest}.

allowed_methods(Req, State) ->
    {[ <<"GET">>], Req, State}.

content_types_provided(Req, State) ->
    {[
        {{<<"application">>, <<"json">>, []}, handle_get}
    ], Req, State}.

handle_get(Req, State) ->
    {Id, _Req1} = cowboy_req:binding(id, Req),
    % Qs = cowboy_req:parse_qs(Req),
    {Qs, _Req2} = cowboy_req:qs_vals(Req),    
    lager:info("~p||handle_get||Id : ~p|| QS : ~p",[?MODULE, Id, Qs]),
    {jsx:encode(<<"Got the Id request">>),
     Req,
     State}.