defmodule BetTipper.Users do
  @moduledoc "User context"

  alias BetTipper.Repo
  alias BetTipper.Schemas.User

  def get_id_by_email(email) do
    Repo.get_by(User, email: email)
  end
end
