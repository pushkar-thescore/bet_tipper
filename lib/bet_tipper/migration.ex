defmodule BetTipper.Migration do
  @moduledoc """
  Module that gets used for all future migrations.

  It adds hooks for history tables to shadow current tables for auditing purposes.
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Migration

      alias BetTipper.Migration.EnumSQL
    end
  end
end
