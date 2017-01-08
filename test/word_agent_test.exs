defmodule WordAgentTest do
  use ExUnit.Case, async: true
  alias Anagrams.WordAgent

  setup do
    {:ok, agent} = WordAgent.start_link

    {:ok, agent: agent}
  end

  test "starts empty by default", %{agent: agent} do
    assert WordAgent.get_word_list(agent) == []
  end

  test "can start with words" do
    word_list = ~w{a b c}
    {:ok, agent} = WordAgent.start_link(fn -> word_list end)

    assert WordAgent.get_word_list(agent) == word_list
  end

  test "set word list", %{agent: agent} do
    word_list = ~w{a b c}
    WordAgent.set_word_list(agent, word_list)

    assert WordAgent.get_word_list(agent) == word_list
  end

  test "set word list overwrites old list", %{agent: agent} do
    word_list_1 = ~w{a b c}
    word_list_2 = ~w{d e f}
    WordAgent.set_word_list(agent, word_list_1)
    WordAgent.set_word_list(agent, word_list_2)

    assert WordAgent.get_word_list(agent) == word_list_2
  end
end
