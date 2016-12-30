defmodule Anagrams.Word do
  defstruct chars: '', value: 1

  def from_string(str) do
    String.to_charlist(str)
    |> word_from_charlist
  end

  defp word_from_charlist(chars) do
    %__MODULE__{chars: chars, value: value_from_chars(chars)}
  end

  defp value_from_chars(chars) do
    chars
    |> Enum.map(&prime_for_char/1)
    |> Enum.reduce(1, &(&1 * &2))
  end

  @primes [2, 3, 5, 7, 11, 13, 17, 19,
           23, 29, 31, 37, 41, 43, 47,
           53, 59, 61, 67, 71, 73, 79,
           83, 89, 97, 101]

  defp prime_for_char(char) do
    @primes
    |> Enum.at(char - ?a)
  end
end
