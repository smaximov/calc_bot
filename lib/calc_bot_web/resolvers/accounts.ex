defmodule CalcBotWeb.Resolvers.Accounts do
  @moduledoc """
  Accounts resolvers.
  """

  alias CalcBot.Absinthe.Payload

  def list_bots(_parent, _args, _resolution) do
    {:ok, [%{token: 'bot token', username: 'bot username'}]}
  end

  def create_user(args, _resolution) do
    result =
      args
      |> CalcBot.Accounts.create_user()
      |> Payload.build()

    {:ok, result}
  end
end
