defmodule Identicon do

  alias Identicon.Image
  def main(input) do
    input
    |> hash_input()
    |> pick_color()
  end

  def pick_color(%Image{hex: [red, green, blue | _tail]} = image) do
    %Image{image | color: {red, green, blue}}

    [red, green, blue]
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list()

    %Image{hex: hex}
  end
end
