defmodule BetTipperWeb.BetControllerTest do
  use BetTipperWeb.ConnCase

  import BetTipper.BetsFixtures

  alias BetTipper.Bets.Bet

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bets", %{conn: conn} do
      conn = get(conn, Routes.bet_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bet" do
    test "renders bet when data is valid", %{conn: conn} do
      conn = post(conn, Routes.bet_path(conn, :create), bet: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.bet_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.bet_path(conn, :create), bet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bet" do
    setup [:create_bet]

    test "renders bet when data is valid", %{conn: conn, bet: %Bet{id: id} = bet} do
      conn = put(conn, Routes.bet_path(conn, :update, bet), bet: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.bet_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, bet: bet} do
      conn = put(conn, Routes.bet_path(conn, :update, bet), bet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bet" do
    setup [:create_bet]

    test "deletes chosen bet", %{conn: conn, bet: bet} do
      conn = delete(conn, Routes.bet_path(conn, :delete, bet))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.bet_path(conn, :show, bet))
      end
    end
  end

  defp create_bet(_) do
    bet = bet_fixture()
    %{bet: bet}
  end
end
