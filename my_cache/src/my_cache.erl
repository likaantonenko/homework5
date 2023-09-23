-module(my_cache).
-export([create/1, insert/3, insert/4]).

create(TableName) ->
  ets:new(TableName, [public, named_table, set]).

insert(TableName, Key, Value) ->
    ets:insert(TableName, {Key, Value, 0}).

insert(TableName, Key, Value, TimeInSecunds) ->
    Now = calendar:now_to_datetime(erlang:timestamp()),
    NewSecunds = calendar:datetime_to_gregorian_seconds(Now)+TimeInSecunds,
    ets:insert(TableName, {Key, Value, NewSecunds}).

