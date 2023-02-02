defmodule BetTipper.Repo do
  use Ecto.Repo,
    otp_app: :bet_tipper,
    adapter: Ecto.Adapters.Postgres
end
