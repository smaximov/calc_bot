defmodule CalcBotWeb.Router do
  use CalcBotWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", CalcBotWeb do
    pipe_through(:api)
  end
end
