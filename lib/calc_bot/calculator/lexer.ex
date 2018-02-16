defmodule CalcBot.Calculator.Lexer do
  @moduledoc """
    Lexical analyzer.
  """

  @type tokens :: [token]
  @type error :: String.t()
  @type line :: integer
  @type token ::
          {:int, line, integer}
          | {:float, line, float}
          | {:+, line}
          | {:-, line}
          | {:*, line}
          | {:/, line}
          | {:")", line}
          | {:"(", line}

  @doc ~S"""
  Tokenize input.

  ## Examples

      iex> CalcBot.Calculator.Lexer.lex("1 + 2")
      {:ok, [{:int, 1, 1}, {:+, 1}, {:int, 1, 2}]}

      iex> CalcBot.Calculator.Lexer.lex(" ")
      {:error, "no input"}

      iex> CalcBot.Calculator.Lexer.lex("invalid input")
      {:error, "illegal characters \"i\""}
  """
  @spec lex(input :: String.t()) :: {:ok, tokens} | {:error, error}
  def lex(input) do
    case :calc_lexer.string(to_charlist(input)) do
      {:ok, [], _} -> {:error, "no input"}
      {:ok, tokens, _} -> {:ok, tokens}
      {:error, {_, _, error}, _} -> {:error, format_error(error)}
    end
  end

  defp format_error(error) do
    Enum.join(:calc_lexer.format_error(error))
  end
end
