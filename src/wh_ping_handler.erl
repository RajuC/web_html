-module(wh_ping_handler).

-export([init/3]).
-export([allowed_methods/2]).
-export([content_types_provided/2]).
-export([options/2]).
-export([handle_get/2]).


init(_Protocol, _Req, _Opts) ->
    {upgrade, protocol, cowboy_rest}.

allowed_methods(Req, State) ->
  {[<<"GET">>], Req, State}.

content_types_provided(Req, State) ->
    Handlers = [{<<"application/json">>, handle_get}],
    {Handlers, Req, State}.

options(Req, State) ->
io:format("~n~p||func_name||=================||i am hererr~n~n",[?MODULE]),
    Req1 = cowboy_req:set_resp_header(<<"access-control-allow-methods">>, <<"GET, OPTIONS">>, Req),
    Req2 = cowboy_req:set_resp_header(<<"access-control-allow-origin">>, <<"*">>, Req1),
    {ok, Req2, State}.



handle_get(Req, State) ->
  lager:info("~p||handle_get||Ping Request",[?MODULE]),
  Req1 = cowboy_req:set_resp_header(<<"access-control-max-age">>, <<"1728000">>, Req),
  Req2 = cowboy_req:set_resp_header(<<"access-control-allow-methods">>, <<"HEAD, GET, POST">>, Req1),
  Req3 = cowboy_req:set_resp_header(<<"access-control-allow-headers">>, <<"content-type, authorization">>, Req2),
  Req4 = cowboy_req:set_resp_header(<<"Access-Control-Allow-Origin">>, <<$*>>, Req3),  
   {jsx:encode([{<<"reply">>, <<"pong">>}]),
    % {<<"pong">>,
   Req4,
   State}.





%%%  success ajax request example 

%       $.ajax({
%       url: "http://localhost:8081/ping",
%       dataType: 'json',
%       success:successHandler,
%       error: errorHandler
%     });

  
  
  
% function successHandler(data) {
%     console.log("sucesss...")
%     console.log(data)
% }

% function errorHandler(jqXHR, errorType, exception) {
%   console.log("i am in error");
%     console.log(errorType, exception);
% }