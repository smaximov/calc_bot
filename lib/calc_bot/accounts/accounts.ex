defmodule CalcBot.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias CalcBot.Repo
  alias CalcBot.Accounts.User
  alias CalcBot.Password

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  @spec list_users() :: [CalcBot.Accounts.User.t()]
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      nil

  """
  @spec get_user(id :: integer) :: CalcBot.Accounts.User.t() | nil
  def get_user(id), do: Repo.get(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_user(attrs :: map) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @dialyzer {:no_match, authenticate_user: 2}
  @doc """
  Authenticates a user by email/password.

  ## Examples

      iex> authenticate_user("no@such.email", "secret")
      {:error, _}

      iex> authenticate_user("existing@user.email", "invalid password")
      {:error, _}

      iex> authenticate_user("existing@user.email", "valid password")
      {:ok, %User{}}
  """
  @spec authenticate_user(String.t(), String.t()) :: {:ok, User.t()} | {:error, String.t()}
  def authenticate_user(email, password) do
    result =
      User
      |> Repo.get_by(email: email)
      |> Password.check_password(password)

    case result do
      {:ok, user} -> {:ok, user}
      {:error, _} -> {:error, "Specified email/password combination is invalid"}
    end
  end
end
