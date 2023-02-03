defmodule BetTipper.Repo.Migrations.CreateBetOutcomeEnum do
  use BetTipper.Migration

  @enum_name "bet_outcome"
  @enum_values ["win", "loss"]

  def up do
    @enum_name
    |> EnumSQL.create_type(@enum_values)
    |> execute()
  end

  def down do
    @enum_name
    |> EnumSQL.drop_type()
    |> execute()
  end
end
