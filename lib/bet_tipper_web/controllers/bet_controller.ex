defmodule BetTipperWeb.BetController do
  use BetTipperWeb, :controller

  alias BetTipper.Bets
  alias BetTipper.Schemas.Bet

  action_fallback BetTipperWeb.FallbackController

  def index(conn, %{"patron_id" => patron_id}) do
    render(conn, "index.json", bets: Bets.list_for_user(patron_id))
  end

  def free_bets(conn, %{"patron_id" => patron_id}) do
    render(conn, "index.json", bets: Bets.list_free_bets_for_user(patron_id))
  end

  # def create(conn, %{"bet" => bet_params}) do
  #   with {:ok, %Bet{} = bet} <- Bets.create_bet(bet_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", Routes.bet_path(conn, :show, bet))
  #     |> render("show.json", bet: bet)
  #   end
  # end

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
end
