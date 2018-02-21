defmodule CalcBotWeb.Schema do
  @moduledoc false

  use Absinthe.Schema
  use ApolloTracing

  import_types(CalcBotWeb.Schema.AccountTypes)

  query do
    import_fields(:account_queries)
  end
end
