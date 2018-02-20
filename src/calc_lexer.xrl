Definitions.

WHITESPACE = [\s\t]

DIGIT = [0-9]
NON_ZERO_DIGIT = [1-9]
FRACTIONAL_PART = \.{DIGIT}+
SIGN = [\+\-]
OPERATOR = {SIGN}|[\*\/]
PARENTESIS = [\(\)]

INTEGER = 0|{NON_ZERO_DIGIT}{DIGIT}*
EXPONENT_PART = [eE]{SIGN}?{DIGIT}*
FLOAT = {INTEGER}{FRACTIONAL_PART}({EXPONENT_PART})?

Rules.

{WHITESPACE} : skip_token.
{INTEGER} : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
{FLOAT} : {token, {float, TokenLine, list_to_float(TokenChars)}}.
{OPERATOR} : {token, {list_to_atom(TokenChars), TokenLine}}.
{PARENTESIS} : {token, {list_to_atom(TokenChars)}, TokenLine}.

Erlang code.
