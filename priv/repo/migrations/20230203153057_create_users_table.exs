defmodule BetTipper.Repo.Migrations.CreateUsersTable do
  use BetTipper.Migration

  def change do
    create table(:users) do
      add :email, :string

      timestamps()
    end
  end
end
