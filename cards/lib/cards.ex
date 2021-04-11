defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  def create_deck() do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Clubs", "Diamonts", "Hearts", "Spades"]

    for value <- values, suit <- suits do
        "#{value} of #{suit}"
    end
  end

  def create_hand(hand_size) do
    {hand, _tail} = deal(create_deck(), hand_size)
    hand
  end

  @doc """
    Divides a deck into a hand.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples
      iex> import Cards
      iex> deck = create_deck
      iex> {hand, remainder} = deal(deck, 2)
      iex> hand
      ["Three of Clubs", "Five of Hearts"]
  """
  def deal(deck, hand_size) do
    Enum.shuffle(deck)
    |> Enum.split(hand_size)
  end

  def load(filename) do
    {status, content} = File.read(filename)

    case status do
    :ok -> :erlang.binary_to_term(content)
    :error -> "Sorry, I couldn't find the file you inform :("
    end
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck) # Converts 'deck' into a binary content
    File.write(filename, binary)
  end


end
