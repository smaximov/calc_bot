defmodule CalcBotWeb.Schema do
  @moduledoc false

  use Absinthe.Schema
  use ApolloTracing

  import_types(CalcBotWeb.Schema.AccountsTypes)

  query do
    import_fields(:accounts_queries)
  end
end
