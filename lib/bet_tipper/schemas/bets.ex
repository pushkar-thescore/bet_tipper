defmodule BetTipper.Bets do
  @moduledoc "Bet context"

  alias BetTipper.Repo
  alias BetTipper.Schemas.Bet

  def create(attrs) do
    %Bet{}
    |> Bet.changeset(attrs)
    |> Repo.insert()
  end
end
