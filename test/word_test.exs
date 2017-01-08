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

  test "word can be created from character list" do
    charlist = Word.from_string("abchelloxyztst")
    hello = Word.from_string("hello")
    test = Word.from_string("test")

    assert Word.is_anagram?(hello, charlist)
    assert Word.is_anagram?(test, charlist)
  end

  test "word cannot be created from character list" do
    charlist = Word.from_string("abchelloxyztst")
    helloo = Word.from_string("helloo")
    testt = Word.from_string("testt")

    assert Word.is_anagram?(helloo, charlist) == false
    assert Word.is_anagram?(testt, charlist) == false
  end
end
