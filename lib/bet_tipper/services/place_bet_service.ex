defmodule BetTipper.Services.PlaceBetService do
  @moduledoc """
  A service which accepts a map of attributes to place a bet
  and optionally award a free bet to the referred friend if the bet outcome is a win.
  """

  alias Ecto.Multi
  alias BetTipper.Bets
  alias BetTipper.Repo
  alias BetTipper.Schemas.User
  alias BetTipper.Users

  # @spec run(Ecto.UUID.t(), Promotion.t(), Promotions.Core.Promotions.update_attrs()) ::
  # {:ok, Promotion.t()} | {:error, Ecto.Changeset.t()}
  def run(%{} = attrs) do
    result =
      Multi.new()
      |> Multi.put(:attrs, attrs)
      |> Multi.run(:friend_id, &get_friend_id/2)
      |> Multi.run(:created_bet, &create_bet/2)
      |> Multi.run(:free_bet, &maybe_grant_free_bet_to_friend/2)
      |> Repo.transaction()

    case result do
      {:ok, _} -> {:ok, :ok}
      {:error, _, %Ecto.Changeset{} = changeset, _} -> {:error, changeset}
    end
  end

  defp get_friend_id(_, %{attrs: %{tip_percentage: _, friend_contact: email}}) do
    case Users.get_id_by_email(email) do
      %User{id: friend_id} ->
        {:ok, friend_id}

      _ ->
        {:ok, nil}
    end
  end

  defp get_friend_id(_, _) do
    {:ok, nil}
  end

  defp create_bet(_, %{attrs: attrs, friend_id: friend_id}) do
    IO.inspect(attrs)

    attrs =
      if friend_id && attrs.tip_percentage do
        Map.merge(attrs, %{bet_type: :shareable, friend_id: friend_id})
      else
        Map.merge(attrs, %{bet_type: :regular, friend_id: nil, tip_percentage: nil})
      end

    Bets.create(attrs)
  end

  defp maybe_grant_free_bet_to_friend(_, %{friend_id: nil}) do
    {:ok, nil}
  end

  defp maybe_grant_free_bet_to_friend(_, %{
         attrs: %{tip_percentage: tip_percentage, win_amount_cents: win_amount_cents},
         friend_id: friend_id
       })
       when win_amount_cents > 0 and tip_percentage > 0.0 do
    bet_amount_cents = round(tip_percentage * win_amount_cents / 100)

    Bets.create(%{
      patron_id: friend_id,
      bet_amount_cents: bet_amount_cents,
      bet_type: :free_bet,
      free_bet_awarded_at: Timex.now(),
      free_bet_expires_at: Timex.shift(Timex.now(), days: 5)
    })
  end

  defp maybe_grant_free_bet_to_friend(_, _) do
    {:ok, nil}
  end
end
