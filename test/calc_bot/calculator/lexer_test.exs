defmodule CalcBot.Calculator.LexerTest do
  use ExUnit.Case, async: true

  alias CalcBot.Calculator.Lexer

  doctest CalcBot.Calculator.Lexer

  test "scans floats" do
    assert Lexer.scan("1.2") == {:ok, [{:float, 1, 1.2}]}
    assert Lexer.scan("1.2e12") == {:ok, [{:float, 1, 1.2e12}]}
    assert Lexer.scan("1.2E-12") == {:ok, [{:float, 1, 1.2e-12}]}
  end

  test "scans parentheses" do
    assert Lexer.scan("(") == {:ok, [{:"(", 1}]}
    assert Lexer.scan(")") == {:ok, [{:")", 1}]}
  end
end
