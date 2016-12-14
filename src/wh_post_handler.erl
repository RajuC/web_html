-module(wh_post_handler).

-export([init/3]).
-export([allowed_methods/2]).
-export([content_types_accepted/2]).

-export([handle_post/2]).


init(_Protocol, _Req, _Opts) ->
    {upgrade, protocol, cowboy_rest}.

allowed_methods(Req, State) ->
	{[<<"POST">>], Req, State}.

content_types_accepted(Req, State) ->
    {[{{<<"application">>, <<"json">>, '*'}, handle_post}],
        Req, State}.

handle_post(Req, State) ->
    {ok, Body, Req1} = cowboy_req:body(Req),
    lager:info("~p||handle_post||Body : ~p",[?MODULE, Body]),
    {true,
     cowboy_req:set_resp_body(
       jsx:encode(<<"Got the Post request...">>),
       Req1),
     State}.

