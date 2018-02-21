defmodule CalcBotWeb.Resolvers.Accounts do
  @moduledoc """
  Accounts resolvers.
  """

  def list_bots(_parent, _args, _resolution) do
    {:ok, [%{token: 'bot token', username: 'bot username'}]}
  end
end
