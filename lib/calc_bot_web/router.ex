defmodule CalcBotWeb.Router do
  use CalcBotWeb, :router

  # NOTE(smaximov): suppress dialyzer's warning:
  #   lib/phoenix/router.ex:2: Function call/2 has no local return
  @dialyzer {:nowarn_function, call: 2}

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", CalcBotWeb do
    pipe_through(:api)
  end
end
