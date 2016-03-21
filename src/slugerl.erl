-module(slugerl).
-export([slugify/1]).

apply_transforms([],Str) ->
    Str;
apply_transforms([{RegExp,Replace}|Rest],Str) ->
    NewStr = re:replace(Str,RegExp,Replace,[global,{return,list}]),
    apply_transforms(Rest,NewStr).

slugify([]) -> "no-title";
slugify(Str) ->
    Transforms = [{"[^[:alnum:]]+","-"},
		  {"^[\s-]+",""},
		  {"[\w\s-]+$",""}, % "
		  {"\W+"," "},
		  {"[-\s]+","-"}],
    apply_transforms(Transforms,string:to_lower(Str)).
