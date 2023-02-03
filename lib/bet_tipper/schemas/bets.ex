defmodule BetTipper.Bets do
  @moduledoc "Bet context"

  alias BetTipper.Repo
  alias BetTipper.Schemas.Bet

  def list_for_user(patron_id) do
    Bet
    |> Bet.by_patron_id(patron_id)
    |> Repo.all()
  end

  def list_free_bets_for_user(patron_id) do
    Bet
    |> Bet.by_type(:free_bet)
    |> Bet.by_patron_id(patron_id)
    |> Repo.all()
  end

  def create(attrs) do
    %Bet{}
    |> Bet.changeset(attrs)
    |> Repo.insert()
  end
end
