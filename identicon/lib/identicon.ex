defmodule Identicon do

  alias Identicon.Image
  def main(input) do
    input
    |> hash_input()
    |> pick_color()
    |> build_grid()
    |> filter_odd_squares()
    |> build_pixel_map()
    |> draw_image()
    |> save_image(input)
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  def draw_image(%Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn({x, y}) ->
      :egd.filledRectangle(image, x, y, fill)
    end)

    :egd.render(image)
  end

  def build_pixel_map(%Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn({_code, index}) ->
        horizontal = rem(index, 5) * 50
        vertical = div(index, 5) * 50

        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}

        {top_left, bottom_right}
      end)

      %Image{image | pixel_map: pixel_map}
  end

  def filter_odd_squares(%Image{grid: grid} = image) do
    grid = Enum.filter(grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end)

    %Image{image | grid: grid}
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
