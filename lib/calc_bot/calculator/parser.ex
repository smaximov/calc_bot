defmodule CalcBot.Calculator.Parser do
  @moduledoc """
  Expression parser.
  """

  @type ast_node :: bin_op_node | number
  @type bin_op_node :: {bin_op, ast_node, ast_node}
  @type bin_op :: :+ | :- | :* | :/

  @doc ~S"""
  Parse `tokens` scanned by `CalcBot.Calculator.Lexer.scan/1`.

  ## Examples

      iex> {:ok, tokens} = CalcBot.Calculator.Lexer.scan("1 + 2")
      iex> CalcBot.Calculator.Parser.parse(tokens)
      {:ok, {:+, 1, 2}}

      iex> {:ok, tokens} = CalcBot.Calculator.Lexer.scan("1 +")
      iex> CalcBot.Calculator.Parser.parse(tokens)
      {:error, "parse error"}
  """
  @spec parse(tokens :: CalcBot.Calculator.Lexer.tokens()) ::
          {:ok, ast_node} | {:error, String.t()}
  def parse(tokens) do
    case :calc_parser.parse(tokens) do
      {:error, _} -> {:error, "parse error"}
      result -> result
    end
  end
end
