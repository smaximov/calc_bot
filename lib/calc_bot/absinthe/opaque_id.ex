defmodule CalcBot.Absinthe.OpaqueID do
  @moduledoc "This module provide the opaque ID type."

  use Absinthe.Schema.Notation

  alias Absinthe.Blueprint.Input

  @config Hashids.new(salt: "CalcBot", min_len: 8)

  @desc "Opaque ID type"
  scalar :opaque_id, name: "OpaqueID" do
    serialize &encode/1
    parse &decode/1
  end

  defp encode(id), do: Hashids.encode(@config, id)

  defp decode(%Input.String{value: value}) do
    case Hashids.decode(@config, value) do
      {:ok, [id]} -> {:ok, id}
      _error -> :error
    end
  end

  defp decode(%Input.Null{}), do: {:ok, nil}
end
