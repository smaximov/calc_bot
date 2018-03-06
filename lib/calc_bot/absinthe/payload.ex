defmodule CalcBot.Absinthe.Payload do
  @moduledoc """
    Mutation payload builder.
  """

  alias CalcBot.Absinthe.Payload.Error

  @type t :: %__MODULE__{
          success: boolean,
          result: result | nil,
          errors: [Error.t()] | nil
        }

  @type result :: Ecto.Schema.t()

  @enforce_keys [:success]
  defstruct success: nil, result: nil, errors: nil

  @doc false
  defmacro __using__(_opts) do
    quote do
      import CalcBot.Absinthe.Payload, only: [payload: 1, payload: 2]
    end
  end

  @doc "Generate mutation payload type"
  @spec payload(term, Keyword.t()) :: Macro.t()
  defmacro payload(type, opts \\ []) do
    payload_name = Keyword.get_lazy(opts, :name, fn -> :"#{type}_payload" end)

    quote location: :keep do
      object unquote(payload_name) do
        @desc "Indicates whether the mutation completed successfully or not"
        field :success, non_null(:boolean)

        @desc "A list of failed validations or null if the mutation has succeeded"
        field :errors, list_of(:payload_error)

        @desc "The object mutated or null if the mutation has failed"
        field :result, unquote(type)
      end
    end
  end

  @doc "Build payload struct"
  @spec build({:ok, result} | {:error, Error.error()}) :: t
  def build({:ok, result}), do: success(result)
  def build({:error, errors}), do: failure(errors)

  @doc "Build payload for a successful mutation"
  @spec success(result) :: t
  def success(result) do
    %__MODULE__{success: true, result: result}
  end

  @doc "Build payload for a failed mutation"
  @spec failure(Error.error() | [Error.error()]) :: t
  def failure(errors) when is_list(errors) do
    %__MODULE__{success: false, errors: Enum.flat_map(errors, &Error.build/1)}
  end

  def failure(errors) do
    %__MODULE__{success: false, errors: Error.build(errors)}
  end
end
