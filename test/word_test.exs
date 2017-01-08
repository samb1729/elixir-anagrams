defmodule WordTest do
  use ExUnit.Case, async: true
  alias Anagrams.Word

  test "default word has no chars" do
    assert %Anagrams.Word{}.chars == ''
  end

  test "default word has value 1" do
    assert %Anagrams.Word{}.value == 1
  end

  test "convert string to chars" do
    assert Word.from_string("abcxyz").chars == 'abcxyz'
  end

  test "convert back to string" do
    assert ("abcxyz" |> Word.from_string |> Word.to_string) == "abcxyz"
  end

  test "calculate prime-factored value from chars" do
    assert Word.from_string("abcxyz").value == 2 * 3 * 5 * 89 * 97 * 101
  end

  test "handling of duplicated characters" do
    assert Word.from_string("aaabbb").value == 2 * 2 * 2 * 3 * 3 * 3
  end

  test "handling of unordered characters" do
    assert Word.from_string("abccba").value == 2 * 3 * 5 * 5 * 3 * 2
  end

  test "word can be created from letters" do
    letters = "abchelloxyztst"
    hello = "hello"
    test = "test"

    assert Word.is_anagram?(hello, letters)
    assert Word.is_anagram?(test, letters)
  end

  test "word cannot be created from letters" do
    letters = "abchelloxyztst"
    helloo = "helloo"
    testt = "testt"

    assert Word.is_anagram?(helloo, letters) == false
    assert Word.is_anagram?(testt, letters) == false
  end
end
