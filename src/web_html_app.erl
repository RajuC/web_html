-module(web_html_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    PrivDir = code:priv_dir(web_html),
	Dispatch = cowboy_router:compile([
	{'_', [
            {"/", cowboy_static, {priv_file, web_html, "index.html"}},
            {"/ping",  wh_ping_handler, []},
            {"/info",  wh_info_handler, []},
            {"/id/:id", wh_id_handler, []},
            {"/post",  wh_post_handler, []},
            {"/req",   wh_req_handler, []},
            {"/[...]", cowboy_static, {priv_dir, web_html, ""}},
            {"/[...]", cowboy_static, {PrivDir++"/PGM1/", web_html, ""}},
            {"/[...]", cowboy_static, {PrivDir++"/PGM2/", web_html, ""}},
            {"/[...]", cowboy_static, {PrivDir++"/PGM3/", web_html, ""}},
            {"/[...]", cowboy_static, {PrivDir++"/PGM4/", web_html, ""}},
            {"/[...]", cowboy_static, {PrivDir++"/PGM5/", web_html, ""}}
		]}
	]),
	{ok, _} = cowboy:start_http(http, 100, [{port, 8081}], [
		{env, [{dispatch, Dispatch},
			   {cors_policy, wh_cors}]},
		{middlewares, [
                        cowboy_router,
                        cowboy_cors,
                        cowboy_handler
                       ]}	   
	]),
	web_html_sup:start_link().

stop(_State) ->
	ok.


