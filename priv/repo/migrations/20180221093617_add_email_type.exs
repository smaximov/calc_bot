defmodule CalcBot.Repo.Migrations.AddEmailType do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS citext"

    execute ~S"""
    CREATE DOMAIN email AS citext
    CONSTRAINT basic_email_format_check CHECK (VALUE ~ '\A.+@.+\..+\Z')
    """

    execute ~S"""
    COMMENT ON DOMAIN email
    IS 'Text type with case-insensitive comparison and basic email format checks'
    """

    execute ~S"""
    COMMENT ON CONSTRAINT basic_email_format_check ON DOMAIN email
    IS $$Basic email format check (requires the presence of '@' and '.')$$
    """
  end

  def down do
    execute "DROP DOMAIN email"
  end
end
