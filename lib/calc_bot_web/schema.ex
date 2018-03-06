defmodule CalcBotWeb.Schema do
  @moduledoc false

  use Absinthe.Schema

  import_types CalcBot.Absinthe.OpaqueID
  import_types CalcBot.Absinthe.Payload.Error
  import_types CalcBotWeb.Schema.AccountsTypes

  query do
    import_fields(:accounts_queries)
  end

  mutation do
    import_fields(:accounts_mutations)
  end

  def middleware(middleware, _, %{identifier: :subscription}), do: middleware

  def middleware(middleware, _, %{identifier: :mutation}) do
    [ApolloTracing.Middleware.Tracing] ++ middleware ++ [CalcBot.Absinthe.Middleware.Payload]
  end

  def middleware(middleware, _, _) do
    [ApolloTracing.Middleware.Tracing, ApolloTracing.Middleware.Caching] ++ middleware
  end
end
