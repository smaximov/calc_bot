defmodule CalcBotWeb.Resolvers.Accounts do
  @moduledoc """
  Accounts resolvers.
  """

  def list_bots(_parent, _args, _resolution) do
    {:ok, [%{token: 'bot token', username: 'bot username'}]}
  end

  def create_user(args, _resolution) do
    CalcBot.Accounts.create_user(args)
  end
end
