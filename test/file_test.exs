defmodule FileTest do
  use ExUnit.Case, async: true
  import Anagrams.File

  test "default words_file" do
    assert Application.get_env(:anagrams, :words_file) == "words.txt"
  end

  test "opens file stream" do
    f = "test.txt"
    assert open_file(f).path == f
  end

  test "loads default words" do
    assert is_list(load_words)
  end

  test "loads test.txt words" do
    assert load_words("test.txt") == ~w(a list of words)
  end
end
