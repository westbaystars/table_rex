defmodule TableRex.Column do
  @moduledoc """
  Defines a struct that represents a column's metadata

  The align field can be one of :left, :center or :right.

  Default string width calcuation to use Unicode.
  """
  alias Unicode.EastAsianWidth, as: Width

  defstruct align: :left, padding: 1, color: nil, width_calc: &TableRex.Column.string_width/1

  @type t :: %__MODULE__{}

  def string_width(string) do
    width = string
    |> String.to_charlist()
    |> Enum.map(&Width.east_asian_width_category(&1))
    |> Enum.reduce(0, fn width, acc -> if(width == :w, do: acc + 2, else: acc + 1) end)

    #IO.inspect("#{string} -> #{width}")
    width
  end
end
