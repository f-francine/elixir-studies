defmodule MinimalTodo do
  @moduledoc """
  Documentation for `MinimalTodo`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> MinimalTodo.hello()
      :world

  """
  def read(filename) do
    case File.read(filename) do
      {:ok, body} -> body
      {:error, _reason} -> IO.puts ~s(Could not open file "#{filename}\n")

    end
  end

  def parse(body) do
    [header | lines] = String.split(body, ~r{(\r\n|\r\n)})
    titles = tl String.split(header, ",")
    parse_lines(lines, titles)
  end

  def parse_lines(lines, titles) do
    Enum.reduce(lines, %{}, fn line, built ->
      [name | fields] = String.split(line, ",")
      if(Enum.count(fields) == Enum.count(titles)) do
        line_data = Enum.zip(titles, fields)
        |> Enum.into(%{})
        Map.merge(built, %{name => line_data})
      else
        built
      end
    end)
  end
end
