defmodule CalcBot.Absinthe.Middleware.Payload do
  @moduledoc """
  Absinthe middleware for building `CalcBot.Absinthe.Payload`.
  """

  @behaviour Absinthe.Middleware

  alias Absinthe.Resolution
  alias CalcBot.Absinthe.Payload

  @impl Absinthe.Middleware
  def call(%Resolution{value: value, errors: []} = resolution, _config) do
    %{resolution | value: Payload.success(value)}
  end

  def call(%Resolution{value: nil, errors: errors} = resolution, _config) do
    %{resolution | value: Payload.failure(errors), errors: []}
  end
end
