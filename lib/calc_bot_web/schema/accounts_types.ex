defmodule CalcBotWeb.Schema.AccountsTypes do
  @moduledoc false

  use Absinthe.Schema.Notation
  use CalcBot.Absinthe.Payload

  alias CalcBotWeb.Resolvers

  object :user do
    field :username, non_null(:string)
    field :fullname, non_null(:string)
    field :email, non_null(:string)
  end

  @desc "The result of mutating `User'"
  payload :user

  @desc "Telegram Bot info"
  object :bot do
    @desc "Telegram Bot token"
    field :token, non_null(:string)

    @desc "Telegram Bot username"
    field :username, non_null(:string)
  end

  object :accounts_queries do
    @desc "Get all bots"
    field :bots, non_null(list_of(non_null(:bot))) do
      resolve &Resolvers.Accounts.list_bots/3
    end
  end

  object :accounts_mutations do
    @desc "Create new user"
    field :sign_in, non_null(:user_payload) do
      arg :username, non_null(:string)
      arg :fullname, non_null(:string)
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &Resolvers.Accounts.create_user/2
    end
  end
end
