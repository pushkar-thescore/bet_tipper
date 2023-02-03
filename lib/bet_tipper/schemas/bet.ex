defmodule BetTipper.Schemas.Bet do
  @moduledoc """
  Defines a bet record and optionally a free bet record in case the free_bet_id field is populated.
  """

  use BetTipper.Schema

  alias __MODULE__
  alias BetTipper.Enums.BetOutcome
  alias BetTipper.Enums.BetType
  alias BetTipper.Schemas.User

  @fields [
    :bet_amount_cents,
    :free_bet_awarded_at,
    :bet_type,
    :bet_outcome,
    :free_bet_expires_at,
    :tip_percentage,
    :win_amount_cents,
    :patron_id,
    :friend_id
  ]
  @required [:bet_amount_cents, :patron_id]

  schema "bets" do
    field :bet_amount_cents, :integer
    field :free_bet_awarded_at, :utc_datetime_usec
    field :bet_type, Ecto.Enum, values: BetType.values()
    field :bet_outcome, Ecto.Enum, values: BetOutcome.values()
    field :free_bet_expires_at, :utc_datetime_usec
    field :tip_percentage, :float
    field :win_amount_cents, :integer

    belongs_to :patron, User, foreign_key: :patron_id
    belongs_to :friend, User, foreign_key: :friend_id

    timestamps()
  end

  def changeset(bet \\ %Bet{}, attrs) do
    bet
    |> cast(attrs, @fields)
    |> validate_required(@required)
  end
end
