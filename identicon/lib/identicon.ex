defmodule Identicon do

  alias Identicon.Image
  def main(input) do
    input
    |> hash_input()
    |> pick_color()
    |> build_grid()
  end

  def build_grid(%Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row

    row ++ [second, first]
  end

  def pick_color(%Image{hex: [red, green, blue | _tail]} = image) do
    %Image{image | color: {red, green, blue}}
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list()

    %Image{hex: hex}
  end
end
