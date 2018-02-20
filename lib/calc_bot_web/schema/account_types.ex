defmodule CalcBotWeb.Schema.AccountTypes do
  @moduledoc false

  use Absinthe.Schema.Notation

  alias CalcBotWeb.Resolvers

  object :account_queries do
    @desc "Get all bots"
    field :bots, non_null(list_of(:bot)) do
      resolve(&Resolvers.Account.list_bots/3)
    end
  end

  @desc "Telegram Bot info"
  object :bot do
    @desc "Telegram Bot token"
    field(:token, non_null(:string))

    @desc "Telegram Bot username"
    field(:username, non_null(:string))
  end
end
