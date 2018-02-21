defmodule CalcBot.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false, comment: "Unique user identifier"
      add :fullname, :string, null: false
      add :email, :email, null: false
      add :password_hash, :string, null: false, comment: "Hashed password"

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
  end
end
