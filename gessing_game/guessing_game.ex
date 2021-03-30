defmodule GuessingGame do

  def guess(low, high) when low > high, do: guess(high, low)

  def guess(low, high) do
    answer = IO.gets("Hmm... maybe you're thinking of #{get_middle(low, high)}?\n")

    case String.trim(answer) do
      "bigger" -> bigger(low, high)
      "smaller" -> smaller(low, high)
      "yes" -> "I knew I could guess it! I am a genius :)"
      _ -> IO.puts(~s(You must type "bigger", "smaller" or "yes"))
      guess(low, high)
    end
 end

  def get_middle(low, high) do
    div(low + high, 2)
  end

  def bigger(low, high) do
    new_low = min(high, get_middle(low, high) + 1)
    guess(new_low, high)
  end

  def smaller(low, high) do
    new_high = max(low, get_middle(low, high) - 1)
    guess(low, new_high)
  end
end
