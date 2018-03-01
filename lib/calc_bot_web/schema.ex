defmodule CalcBotWeb.Schema do
  @moduledoc false

  use Absinthe.Schema
  use ApolloTracing

  import_types CalcBotWeb.Schema.AccountsTypes
  import_types CalcBot.Absinthe.Payload.Error

  query do
    import_fields(:accounts_queries)
  end

  mutation do
    import_fields(:accounts_mutations)
  end
end
