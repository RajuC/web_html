
-module(wh_req_handler).


-export([init/3,
         content_types_provided/2,
         content_types_accepted/2,
         allowed_methods/2,
         handle_get/2,
         handle_post/2]).

init(_Protocol, _Req, _Opts) ->
    {upgrade, protocol, cowboy_rest}.

content_types_provided(Req, State) ->
    Handlers = [{<<"application/json">>, handle_get}],
    {Handlers, Req, State}.

content_types_accepted(Req, State) ->
    {[{{<<"application">>, <<"json">>, '*'}, handle_post}],
        Req, State}.

allowed_methods(Req, State) ->
    {[<<"GET">>, <<"POST">>, <<"OPTIONS">>], Req, State}.


%  handle the get request 
handle_get(Req, State) ->
    lager:info("~p||handle_get||GET req",[?MODULE]),
    {jsx:encode(<<"Send the POST Req instead of GET">>), Req, State}.

handle_post(Req, State) ->
    {ok, Body, Req1} = cowboy_req:body(Req),
    lager:info("~p||handle_post||POST Req Body : ~p",[?MODULE, Body]),
    {true,
     cowboy_req:set_resp_body(
       jsx:encode(<<"Got the Post request...">>),
       Req1),
     State}.


