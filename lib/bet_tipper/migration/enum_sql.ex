defmodule BetTipper.Migration.EnumSQL do
  @moduledoc """
  An group of functions to aide in creating, updating or deleting an enum type within an ecto
  migration file.
  """

  @doc """
  Generates a SQL statement to create an enum type by name and a set of values

  ## Examples

      iex> EnumSQL.create_type("my_enum", ["one", "two", "three"])
      "CREATE TYPE my_enum AS ENUM ('one', 'two', 'three');"
  """
  @spec create_type(String.t(), list(String.t())) :: String.t()
  def create_type(name, values) do
    serialize_enum_values = fn values ->
      Enum.map_join(values, ", ", fn value -> "'#{value}'" end)
    end

    "CREATE TYPE #{name} AS ENUM (#{serialize_enum_values.(values)});"
  end

  @doc """
  Generates a SQL statement to drop an existing enum type from the database

  ## Examples

      iex> EnumSQL.drop_type("my_enum")
      "DROP TYPE my_enum;"
  """
  @spec drop_type(String.t()) :: String.t()
  def drop_type(name) do
    "DROP TYPE #{name};"
  end

  @doc """
  Generates a SQL statement to alter an existing enum name

  ## Examples

      iex> EnumSQL.rename_type("old_enum", "new_enum")
      "ALTER TYPE old_enum RENAME TO new_enum;"
  """
  @spec rename_type(String.t(), String.t()) :: String.t()
  def rename_type(name, new_name) do
    "ALTER TYPE #{name} RENAME TO #{new_name};"
  end

  @doc """
  Generates a SQL statement to add value to an existing enum

  ## Examples

      iex> EnumSQL.add_value("my_enum", "example")
      "ALTER TYPE my_enum ADD VALUE 'example';"
  """
  @spec add_value(String.t(), String.t()) :: String.t()
  def add_value(name, value) do
    "ALTER TYPE #{name} ADD VALUE '#{value}';"
  end
end
