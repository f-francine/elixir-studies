defmodule Cards do
  def create_deck() do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Clubs", "Diamonts", "Heatrs", "Spades"]

    cards = for value <- values, suit <- suits do
        "#{value} of #{suit}"
    end
  end

  def deal(deck, hand_size) do
    Enum.shuffle(deck)
    |> Enum.split(hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck) # Converts 'deck' into a binary content
    File.write(filename, binary)
  end

  def load(filename) do
    {status, content} = File.read(filename)

    case status do
    :ok -> :erlang.binary_to_term(content)
    :error -> "Sorry, I couldn't find the file you inform :("
    end
  end
end
