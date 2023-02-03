defmodule BetTipper.Enums.BetType do
  @moduledoc """
  A common set of values to be used with PostgreSQL enum `bet_type`

  ## Examples

      schema "my_table" do
        field :type, Ecto.Enum, values: BetTipper.Enums.BetType.values()
      end
  """

  @bet_types [
    :regular,
    :shareable,
    :free_bet
  ]

  @type t ::
          :regular
          | :shareable
          | :free_bet

  @doc """
  Returns all possible `bet_types` enum values

  ## Examples

      iex> BetType.values()
      [
        :regular,
        :shareable,
        :free_bet
      ]
  """
  @spec values() :: list(t())
  def values, do: @bet_types
end
