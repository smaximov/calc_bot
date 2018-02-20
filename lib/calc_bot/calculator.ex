defmodule CalcBot.Calculator do
  @moduledoc """
  Parse and evaluate expressions.
  """

  alias CalcBot.Calculator.Lexer
  alias CalcBot.Calculator.Parser

  @doc ~S"""
  Parse and evaluate `input`.

  ## Examples

      iex> CalcBot.Calculator.eval("1")
      {:ok, 1}

      iex> CalcBot.Calculator.eval("1 + 2")
      {:ok, 3}

      iex> CalcBot.Calculator.eval("invalid input")
      {:error, "illegal characters \"i\""}

      iex> CalcBot.Calculator.eval("1 +")
      {:error, "parse error"}

      iex> CalcBot.Calculator.eval("1 / 0")
      {:error, "division by zero"}
  """
  @spec eval(input :: String.t()) :: {:ok, number} | {:error, String.t()}
  def eval(input) do
    with {:ok, tokens} <- Lexer.scan(input),
         {:ok, ast_node} <- Parser.parse(tokens) do
      visit_node(ast_node)
    end
  end

  defp visit_node(node) when is_integer(node) or is_float(node), do: {:ok, node}

  defp visit_node({bin_op, left, right}) do
    with {:ok, left} <- visit_node(left),
         {:ok, right} <- visit_node(right) do
      apply_bin_op(bin_op, left, right)
    end
  end

  defp apply_bin_op(:/, left, right), do: safe_div(left, right)
  defp apply_bin_op(bin_op, left, right), do: {:ok, apply(:erlang, bin_op, [left, right])}

  defp safe_div(_left, right) when right == 0, do: {:error, "division by zero"}
  defp safe_div(left, right), do: {:ok, left / right}
end
