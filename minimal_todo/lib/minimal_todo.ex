defmodule MinimalTodo do
  @moduledoc """
  Documentation for `MinimalTodo`.
  """
  def start do
    filename = IO.gets("Hi there! Please, inform your .csv file to be loaded: ")
    |> String.trim()
    read(filename)
  end

  def read(filename) do
    case File.read(filename) do
      {:ok, body}       -> body
      {:error, reason}  -> IO.puts ~s(Could not open file "#{filename}\n")
                           IO.puts ~s("#{:file.format_error reason}"\n)
                           start()
    end
  end

  def parse(body) do
    [header | lines] = String.split(body, ~r{(\r\n|\r|\n)})
    titles = String.split(header, ",")
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
