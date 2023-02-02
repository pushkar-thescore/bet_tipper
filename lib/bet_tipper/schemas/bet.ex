defmodule BetTipper.Schemas.Bet do
  @moduledoc """
  Defines a bet record and optionally a free bet record in case the free_bet_id field is populated.
  """

  use BetTipper.Schema

  schema "bets" do
    field :bet_amount_cents, :integer
    field :free_bet_awarded_at, :utc_datetime_usec
    field :free_bet_id, Ecto.UUID
    field :free_bet_expires_at, :utc_datetime_usec
    field :friend_id, Ecto.UUID
    field :patron_id, Ecto.UUID
    field :tip_percentage, :float
    field :win_amount_cents, :integer

    timestamps()
  end
end
