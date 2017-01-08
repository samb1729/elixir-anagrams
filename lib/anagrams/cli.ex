defmodule Anagrams.CLI do
  alias Anagrams.Registry

  def loop do
    read_input()
    |> get_anagrams
    |> print_anagrams

    loop()
  end

  def read_input do
    IO.gets("Enter character list: ")
    |> String.downcase
    |> String.to_charlist
    |> Enum.filter(fn (char) ->
      ?a <= char && char <= ?z
    end)
    |> Kernel.to_string
  end

  def get_anagrams(letters) do
    letters
    |> Registry.get_anagrams
  end

  def print_anagrams(anagrams) do
    anagrams
    |> Enum.map(&IO.puts/1)
  end
end
