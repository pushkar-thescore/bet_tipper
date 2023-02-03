defmodule BetTipper.Enums.BetOutcome do
  @moduledoc """
  A common set of values to be used with PostgreSQL enum `bet_outcome`

  ## Examples

      schema "my_table" do
        field :type, Ecto.Enum, values: BetTipper.Enums.BetOutcome.values()
      end
  """

  @bet_outcomes [
    :win,
    :loss
  ]

  @type t :: :win | :loss

  @doc """
  Returns all possible `bet_outcomes` enum values

  ## Examples

      iex> BetOutcome.values()
      [
        :win,
        :loss
      ]
  """
  @spec values() :: list(t())
  def values, do: @bet_outcomes
end
