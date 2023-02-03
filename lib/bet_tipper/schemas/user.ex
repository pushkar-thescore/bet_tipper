defmodule BetTipper.Schemas.User do
  @moduledoc """
  Defines a user record.
  """

  use BetTipper.Schema

  alias BetTipper.Schemas.Bet

  schema "users" do
    field :email, :string

    has_many :bets, Bet, foreign_key: :patron_id

    timestamps()
  end
end
