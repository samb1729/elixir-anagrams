defmodule WorkerTest do
  use ExUnit.Case, async: true
  alias Anagrams.Worker
  alias Anagrams.WordAgent

  setup do
    word_list = ~w{abc defg hello test xyz aaaa qwertyuiop}
    {:ok, agent} = WordAgent.start_link(fn -> word_list end)
    {:ok, worker} = Worker.start_link(%{length: 4, agent: agent})

    {:ok, worker: worker, agent: agent}
  end

  test "uses named WordAgent by default" do
    {:ok, worker} = Worker.start_link(%{length: 123}, [name: :worker1])

    assert Worker.get_agent(worker) == WordAgent
  end

  test "uses alternate agent if passed", %{worker: worker, agent: agent} do
    assert Worker.get_agent(worker) == agent
  end

  test "gets anagrams of correct length", %{worker: worker} do
    assert Worker.get_anagrams(worker, "abc") == ~w{}
    assert Worker.get_anagrams(worker, "abdefg") == ~w{defg}
    assert Worker.get_anagrams(worker, "hellotest") == ~w{test}
  end
end
