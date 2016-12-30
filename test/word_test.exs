defmodule WordTest do
  use ExUnit.Case, async: true
  import Anagrams.Word

  test "default word has no chars" do
    assert %Anagrams.Word{}.chars == ''
  end

  test "default word has value 1" do
    assert %Anagrams.Word{}.value == 1
  end

  test "convert string to chars" do
    assert from_string("abcxyz").chars == 'abcxyz'
  end

  test "calculate prime-factored value from chars" do
    assert from_string("abcxyz").value == 2 * 3 * 5 * 89 * 97 * 101
  end
end
