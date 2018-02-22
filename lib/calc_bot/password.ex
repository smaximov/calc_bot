defmodule CalcBot.Password do
  @moduledoc "Passwords management utilities"

  alias Ecto.Changeset
  import Ecto.Changeset

  @doc "Validate password in changeset."
  @spec validate_password(changeset :: Changeset.t(), opts :: Keyword.t()) :: Changeset.t()
  def validate_password(changeset, opts \\ []) do
    alias NotQwerty123.PasswordStrength

    min_length = Keyword.get(opts, :min_length, 8)
    message = Keyword.get(opts, :message, "is too weak")

    validate_change(changeset, :password, fn :password, password ->
      case PasswordStrength.strong_password?(password, min_length: min_length) do
        {:error, _} ->
          [{:password, {message, [validation: :password]}}]

        _ ->
          []
      end
    end)
  end

  @doc "Swap password with its hash in changeset."
  @spec put_password_hash(changeset :: Changeset.t()) :: Changeset.t()
  def put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end

  def put_password_hash(changeset), do: changeset
end
