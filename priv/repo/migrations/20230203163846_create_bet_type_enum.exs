defmodule BetTipper.Repo.Migrations.CreateBetTypeEnum do
  use BetTipper.Migration

  @enum_name "bet_type"
  @enum_values ["regular", "shareable", "free_bet"]

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
