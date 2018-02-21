defmodule CalcBotWeb.Router do
  @moduledoc false

  use CalcBotWeb, :router

  # NOTE(smaximov): suppress dialyzer's warning:
  #   lib/phoenix/router.ex:2: Function call/2 has no local return
  @dialyzer {:nowarn_function, call: 2}

  # Enable GraphiQL playground in development
  if Mix.env() == :dev do
    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: CalcBotWeb.Schema,
      json_codec: Jason,
      default_url: {__MODULE__, :graphql_default_url},
      interface: :playground
  end

  scope "/api" do
    forward "/", Absinthe.Plug,
      schema: CalcBotWeb.Schema,
      json_codec: Jason,
      pipeline: {ApolloTracing.Pipeline, :plug}
  end

  def graphql_default_url, do: CalcBotWeb.Endpoint.url() <> "/api"
end
