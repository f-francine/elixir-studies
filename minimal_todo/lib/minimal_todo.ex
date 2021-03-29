defmodule MinimalTodo do
  @moduledoc """
  Documentation for `MinimalTodo`.
  """
  def start do
    IO.gets("Hi there! Please, inform your .csv file to be loaded: ")
    |> String.trim()
    |> read()
    |> parse()
    |> get_command()
  end

  def get_command(data) do
    menu = """
    Choose an option:
    [R]ead todos    [A]dd todos    [D]elete todos
    [L]oad file     [S]ave file    [Q]uit
    """

    command =IO.gets(menu)
    |> String.trim()
    |> String.downcase()

    case command do
      "r" -> show_todos(data)
      "d" -> delete_todos(data)
      "q" -> IO.puts("Goodbye! :)")
       _  -> IO.puts("\nOops! Invalid option\n")
             get_command(data)
    end
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

  def show_todos(data, next_command? \\ true) do
    items = Map.keys(data)
    IO.puts("You have the following TODOs:\n")
    Enum.each(items, fn item -> IO.puts(item) end)
    IO.puts("\n")
    if (next_command?) do
      get_command(data)
    end
  end

  def delete_todos(data) do
    show_todos(data, false)

    todo = IO.gets("Witch todo would you like to delete? ")
    |> String.trim()
    if(Map.has_key?(data, todo)) do
      new_map = Map.drop(data, [todo])
      IO.puts(~s(#{todo} has been deleted\n))
      get_command(new_map)
    else
      IO.puts(~s(There is no todo named #{todo}))
      show_todos(data, false)
      get_command(data)

  end
end
end
