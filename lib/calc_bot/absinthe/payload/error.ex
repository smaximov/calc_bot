defmodule CalcBot.Absinthe.Payload.Error do
  @moduledoc "Payload error type"

  use Absinthe.Schema.Notation

  alias Ecto.Changeset

  import CalcBotWeb.ErrorHelpers, only: [translate_error: 1]

  @type t :: %__MODULE__{
          field: String.t() | atom,
          message: String.t()
        }

  @type error :: String.t() | Changeset.t()

  @enforce_keys [:field, :message]
  defstruct field: nil, message: nil

  @desc "Validation message information"
  object :payload_error do
    @desc "The input field the message applies to"
    field :field, non_null(:string)

    @desc "Validation message"
    field :message, non_null(:string)
  end

  @doc "Build payload errors"
  @spec build(error) :: [t]
  def build(errors) when is_binary(errors), do: [%__MODULE__{field: '', message: errors}]

  def build(%Changeset{} = changeset) do
    changeset
    |> Changeset.traverse_errors(&translate_error/1)
    |> Enum.map(fn {field, message} -> %__MODULE__{field: field, message: message} end)
  end
end
