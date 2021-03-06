%%%-------------------------------------------------------------------
%%% @author johhy <https://github.com/johhy>
%%% @copyright (C) 2014, johhy
%%% @doc
%%%
%%% @end
%%% Created : 10 Jan 2014 by johhy <https://github.com/johhy>
%%%-------------------------------------------------------------------
-module(ly_calculator_tests).

-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

test_error() ->
    [?_assertEqual({error, malformed_expression}, ly_calculator:do("rrrr")),
     ?_assertEqual({error, malformed_expression}, ly_calculator:do("-5g")),
     ?_assertEqual({error, malformed_expression}, ly_calculator:do("7...9")),
     ?_assertEqual({error, malformed_expression}, ly_calculator:do("7.9.")),
     ?_assertEqual({error, malformed_expression}, ly_calculator:do(".9")),
     ?_assertEqual({error, malformed_expression}, ly_calculator:do("9.")),
     ?_assertEqual({error, badarith}, ly_calculator:do("1/0"))].

test_no_error() ->
    [?_assertEqual({ok, 12.0}, ly_calculator:do("7+5")),
     ?_assertEqual({ok, 8.0}, ly_calculator:do("5+3")),
     ?_assertEqual({ok, 4.0}, ly_calculator:do("-5+9")),
     ?_assertEqual({ok, 6.0}, ly_calculator:do("+3*2")),
     ?_assertEqual({ok, 2.0}, ly_calculator:do("-5+8-(3*2-1)+4")),
     ?_assertEqual({ok, 8.0}, ly_calculator:do("(5+3)")),
     ?_assertEqual({ok, -8.0}, ly_calculator:do("-(5+3)")),
     ?_assertEqual({ok, 15.0}, ly_calculator:do("(5*3)")),
     ?_assertEqual({ok, 5.0}, ly_calculator:do("(5)"))].

test_gram() ->
    [?_assertEqual({ok, 8.0}, gram:parse([{plus},{number, 4.0}, {multi},
		      {obrac},{number,5.0},{minus},{number,3.0},{cbrac} ,{'$end'}])),
     ?_assertEqual({ok, 7.0}, gram:parse([{plus},{number, 8.0}, {minus},
		      {obrac},{number,5.0},{minus},{number,4.0},{cbrac}, {'$end'}])),
     ?_assertEqual({ok, 7.0}, gram:parse([{obrac},{number,5.0},{plus},{number,2.0},
					  {cbrac}, {'$end'}]))].
all_test_() ->
    [test_error(), test_no_error(), test_gram()].
    
