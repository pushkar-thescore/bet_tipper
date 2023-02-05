defmodule BetTipperWeb.BetController do
  use BetTipperWeb, :controller

  alias BetTipper.Bets
  alias BetTipper.Schemas.Bet
  alias BetTipper.Services.PlaceBetService

  action_fallback BetTipperWeb.FallbackController

  def index(conn, %{"patron_id" => patron_id}) do
    render(conn, "index.json", bets: Bets.list_for_user(patron_id))
  end

  def free_bets(conn, %{"patron_id" => patron_id}) do
    render(conn, "index.json", bets: Bets.list_free_bets_for_user(patron_id))
  end

  def create(conn, %{"bet" => params, "patron_id" => patron_id}) do
    with bet_params <- validate_create_params(params, patron_id),
         {:ok, %Bet{} = bet} <- PlaceBetService.run(bet_params) do
      conn
      |> put_status(:created)
      #|> put_resp_header("location", Routes.bet_path(conn, :show, bet))
      |> render("show.json", bet: bet)
    end
  end

  def show(conn, %{"id" => id}) do
    bet = Bets.get_bet!(id)
    render(conn, "show.json", bet: bet)
  end

  def update(conn, %{"id" => id, "bet" => bet_params}) do
    bet = Bets.get_bet!(id)

    with {:ok, %Bet{} = bet} <- Bets.update_bet(bet, bet_params) do
      render(conn, "show.json", bet: bet)
    end
  end

  def delete(conn, %{"id" => id}) do
    bet = Bets.get_bet!(id)

    with {:ok, %Bet{}} <- Bets.delete_bet(bet) do
      send_resp(conn, :no_content, "")
    end
  end

  defp validate_create_params(params, patron_id) do
    %{
      bet_amount_cents: to_cents(Map.get(params, "bet_amount")),
      win_amount_cents: to_cents(Map.get(params, "win_amount")),
      patron_id: patron_id,
      friend_contact: Map.get(params, "friend_contact", nil),
      tip_percentage: Map.get(params, "tip_percentage", nil)
    }
  end

  defp to_cents(amount) do
    case Money.parse(amount, :USD) do
      {:ok, data} -> data.amount
      _ -> nil
    end
  end
end
