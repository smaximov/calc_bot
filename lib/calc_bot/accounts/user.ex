defmodule CalcBot.Accounts.User do
  @moduledoc """
  User schema.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias CalcBot.Accounts.User

  @type t :: %__MODULE__{
          id: integer | nil,
          username: String.t() | nil,
          fullname: String.t() | nil,
          email: String.t() | nil,
          password: String.t() | nil,
          password_hash: String.t() | nil,
          inserted_at: NaiveDateTime.t() | nil,
          updated_at: NaiveDateTime.t() | nil
        }

  schema "users" do
    field(:username, :string)
    field(:fullname, :string)
    field(:email, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)

    timestamps()
  end

  @doc """
  Returns a changeset suitable for creating a new user.
  """
  @spec changeset(user :: __MODULE__.t(), attrs :: map) :: Ecto.Changeset.t()
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :fullname, :email, :password])
    |> validate_required([:username, :fullname, :email, :password])
    |> validate_password()
    |> put_password_hash()
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> check_constraint(:email, name: "basic_email_format_check")
  end

  @password_length 8

  @spec validate_password(changeset :: Ecto.Changeset.t(), opts :: Keyword.t()) ::
          Ecto.Changeset.t()
  defp validate_password(changeset, opts \\ []) do
    alias NotQwerty123.PasswordStrength

    validate_change(changeset, :password, fn :password, password ->
      case PasswordStrength.strong_password?(password, min_length: @password_length) do
        {:error, message} ->
          [{:password, {Keyword.get(opts, :message, message), [validation: :password]}}]

        _ ->
          []
      end
    end)
  end

  @spec put_password_hash(changeset :: Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
