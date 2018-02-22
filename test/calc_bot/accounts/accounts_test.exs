defmodule CalcBot.AccountsTest do
  use CalcBot.DataCase

  alias CalcBot.Accounts

  describe "users" do
    alias CalcBot.Accounts.User

    test "list_users/0 returns all users" do
      {:ok, user} = params_for(:user) |> Accounts.create_user()

      assert Accounts.list_users() == [user]
    end

    test "get_user/1 returns the existing user with given id" do
      {:ok, user} = params_for(:user) |> Accounts.create_user()

      assert Accounts.get_user(user.id) == user
    end

    test "get_user/1 returns nil when the user does not exist" do
      assert Accounts.get_user(0) == nil
    end

    test "create_user/1 with valid data creates a user" do
      user_params = params_for(:user)

      assert {:ok, %User{} = user} = Accounts.create_user(user_params)
      assert user.email == user_params.email
      refute user.password, "must be nil"
      assert user.password_hash, "must be present"
      refute user.password_hash == user_params.password, "password hash must not match password"
    end

    test "create_user/1 requires username, password, fullname, email to be present" do
      user = %{username: nil, password: nil, fullname: nil, email: nil}

      assert {:error, %Changeset{} = changeset} = Accounts.create_user(user)

      assert "can't be blank" in errors_on(changeset).username
      assert "can't be blank" in errors_on(changeset).fullname
      assert "can't be blank" in errors_on(changeset).email
      assert "can't be blank" in errors_on(changeset).password
    end

    test "create_user/1 with invalid email returns error changeset" do
      result = params_for(:user, email: "invalid@email") |> Accounts.create_user()

      assert {:error, %Changeset{} = changeset} = result
      assert "is invalid" in errors_on(changeset).email
    end

    test "create_user/1 with short password returns error changeset" do
      result = params_for(:user, password: "short") |> Accounts.create_user()

      assert {:error, %Changeset{} = changeset} = result
      assert "is too weak" in errors_on(changeset).password
    end

    test "create_user/1 with common password returns error changeset" do
      result = params_for(:user, password: "qwerty123") |> Accounts.create_user()

      assert {:error, %Changeset{} = changeset} = result
      assert "is too weak" in errors_on(changeset).password
    end

    test "authenticate_user/2 with not existing user returns an error" do
      assert {:error, _} = Accounts.authenticate_user("no@such.email", "password")
    end

    test "authenticate_user/2 with invalid password returns an error" do
      {:ok, user} = params_for(:user, password: "sTr0nGP4sSw0rD") |> Accounts.create_user()
      assert {:error, _} = Accounts.authenticate_user(user.email, "password")
    end

    test "authenticate_user/2 with valid password returns the user" do
      password = "sTr0nGP4sSw0rD"

      {:ok, user} = params_for(:user, password: password) |> Accounts.create_user()
      assert {:ok, ^user} = Accounts.authenticate_user(user.email, password)
    end
  end
end
