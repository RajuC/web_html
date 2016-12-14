-module(wh_cors).
-behaviour(cowboy_cors_policy).

-export([policy_init/1]).
-export([allowed_origins/2]).
-export([allow_credentials/2]).
-export([exposed_headers/2]).
-export([allowed_headers/2]).
-export([allowed_methods/2]).

policy_init(Req) ->
    {ok, Req, undefined_state}.

allowed_origins(Req, State) ->
    {[<<"*">>], Req, State}.

allow_credentials(Req, State) ->
    {true, Req, State}.

exposed_headers(Req, State) ->
    {[<<"accept">>, <<"access-token">>,
      <<"user-id">>], Req, State}.

allowed_headers(Req, State) ->
    {[<<"accept">>, <<"access-token">>,
      <<"user-id">>], Req, State}.

allowed_methods(Req, State) ->
    {[<<"GET">>, <<"DELETE">>, <<"POST">>, <<"PUT">>, <<"PATCH">>, <<"OPTIONS">>], Req, State}.



