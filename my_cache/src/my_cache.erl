-module(my_cache).
-export([create/1, insert/3, insert/4, lookup/2]).

create(TableName) ->
  ets:new(TableName, [public, named_table, set]).

insert(TableName, Key, Value) ->
    ets:insert(TableName, {Key, Value, 0}).

insert(TableName, Key, Value, TimeInSecunds) ->
    Now = calendar:universal_time(),
    NewSecunds = calendar:datetime_to_gregorian_seconds(Now)+TimeInSecunds,
    ets:insert(TableName, {Key, Value, NewSecunds}).

lookup(TableName, Key) ->
    [{Key,Value,TimeInSecunds}] = ets:lookup(TableName,Key),
    if
      TimeInSecunds > 0  ->
        Now = calendar:universal_time(),
        DifferentSecunds = calendar:datetime_to_gregorian_seconds(Now) - TimeInSecunds,
        if
             DifferentSecunds > 0 -> 
                undefined;
        true ->
            Value
        end;   
    true ->
        Value
    end.  


