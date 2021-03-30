defmodule Cards do
  def create_deck() do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Clubs", "Diamonts", "Heatrs", "Spades"]

    cards = for value <- values, suit <- suits do
        "#{value} of #{suit}"
    end
  end
end
