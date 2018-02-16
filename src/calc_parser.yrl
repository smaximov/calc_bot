Nonterminals Expr BinOp Number.

Terminals '-' '+' '/' '*' '(' ')' int float.

Rootsymbol Expr.

Left 100 '-' '+'.
Left 200 '*' '/'.

Expr -> Expr BinOp Expr : {'$2', '$1', '$3'}.
Expr -> '(' Expr ')' : '$2'.
Expr -> Number : unwrap('$1').

BinOp -> '-' : literal('$1').
BinOp -> '+' : literal('$1').
BinOp -> '*' : literal('$1').
BinOp -> '/' : literal('$1').

Number -> int : '$1'.
Number -> float : '$1'.

Erlang code.

literal({Token, _}) -> Token.
unwrap({_, _, Value}) -> Value.
