PROJECT = web_html
DEPS = cowboy lager jsx cowboy_cors

dep_cowboy_cors = git git@github.com:RajuC/cowboy_cors.git master


include erlang.mk

ERLC_OPTS += +'{parse_transform, lager_transform}' -Dlager
TEST_ERLC_OPTS += +'{parse_transform, lager_transform}' -Dlager
