defmodule CalcBot.Accounts.User do
  @moduledoc """
  User schema.
  """

  use Ecto.Schema

  import Ecto.Changeset

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
  @spec changeset(user :: t, attrs :: map) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = user, attrs) do
    alias CalcBot.Password

    user
    |> cast(attrs, [:username, :fullname, :email, :password])
    |> validate_required([:username, :fullname, :email, :password])
    |> Password.validate_password()
    |> Password.put_password_hash()
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> check_constraint(:email, name: "basic_email_format_check")
  end
end
