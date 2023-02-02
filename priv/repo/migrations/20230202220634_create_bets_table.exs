defmodule BetTipper.Repo.Migrations.CreateBetsTable do
  use Ecto.Migration

  def change do
    create table(:bets) do
      add :patron_id, :binary_id, null: false
      add :bet_amount_cents, :integer, null: false
      add :win_amount_cents, :integer
      add :free_bet_id, :binary_id
      add :free_bet_awarded_at, :utc_datetime_usec
      add :free_bet_expires_at, :utc_datetime_usec
      add :tip_percentage, :float
      add :friend_id, :binary_id

      timestamps()
    end
  end
end
