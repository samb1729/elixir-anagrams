defmodule Anagrams.Word do
  defstruct chars: '', value: 1

  def from_string(str) do
    String.to_charlist(str)
    |> word_from_charlist
  end

  def to_string(word) do
    Kernel.to_string word.chars
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

  def is_anagram?(word, charlist)
  when is_binary(word) do
    is_anagram?(from_string(word), charlist)
  end

  def is_anagram?(word, charlist)
  when is_binary(charlist) do
    is_anagram?(word, from_string(charlist))
  end

  def is_anagram?(word, charlist) do
    rem(charlist.value, word.value) == 0
  end
end
