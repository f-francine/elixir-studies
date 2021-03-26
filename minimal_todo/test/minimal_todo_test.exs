defmodule MinimalTodoTest do
  use ExUnit.Case
  doctest MinimalTodo

  test "greets the world" do
    assert MinimalTodo.hello() == :world
  end
end
