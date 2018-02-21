defmodule CalcBot.Factory do
  use ExMachina.Ecto, repo: CalcBot.Repo

  def user_factory do
    %CalcBot.Accounts.User{
      username: sequence(:username, &"user#{&1}"),
      fullname: "full name",
      email: sequence(:email, &"user#{&1}@example.com"),
      password: "Str0nGP4sSwoRd"
    }
  end
end
