defmodule Anagrams.File do
  @words_file Application.get_env(:anagrams, :words_file)

  def load_words(file \\ @words_file) do
    open_file(file)
    |> Stream.map(&String.trim/1)
    |> Enum.to_list
  end

  def open_file(file) do
    File.stream!(file)
  end
end
