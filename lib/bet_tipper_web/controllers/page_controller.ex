defmodule BetTipperWeb.PageController do
  use BetTipperWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
