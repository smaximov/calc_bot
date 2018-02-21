defmodule CalcBot.AccountsTest do
  use CalcBot.DataCase

  alias CalcBot.Accounts

  describe "users" do
    alias CalcBot.Accounts.User

    @valid_attrs %{
      username: "johndoe",
      fullname: "John Doe",
      email: "John.Doe@example.com",
      password: "some_password"
    }
    @invalid_attrs %{username: nil, fullname: nil, email: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user/1 returns the existing user with given id" do
      user = user_fixture()
      assert Accounts.get_user(user.id) == user
    end

    test "get_user/1 returns nil when the user does not exist" do
      assert Accounts.get_user(0) == nil
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == @valid_attrs.email
      refute user.password, "must be nil"
      assert user.password_hash, "must be present"
      refute user.password_hash == @valid_attrs.password, "password hash must not match password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(@invalid_attrs)

      assert "can't be blank" in errors_on(changeset).username
      assert "can't be blank" in errors_on(changeset).fullname
      assert "can't be blank" in errors_on(changeset).email
      assert "can't be blank" in errors_on(changeset).password
    end
  end
end
