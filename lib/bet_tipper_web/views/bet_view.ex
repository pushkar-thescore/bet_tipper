defmodule BetTipperWeb.BetView do
  use BetTipperWeb, :view
  alias BetTipperWeb.BetView

  def render("index.json", %{bets: bets}) do
    %{data: render_many(bets, BetView, "bet.json")}
  end

  def render("show.json", %{bet: bet}) do
    %{data: render_one(bet, BetView, "bet.json")}
  end

  def render("bet.json", %{bet: bet}) do
    %{
      id: bet.id,
      bet_amount: "$#{round(bet.bet_amount_cents / 100)}",
      bet_type: bet.bet_type,
      patron_id: bet.patron_id,
      friend_id: bet.friend_id,
      awarded_at: bet.free_bet_awarded_at,
      expires_at: bet.free_bet_expires_at
    }
  end
end
