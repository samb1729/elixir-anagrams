defmodule RegistryTest do
  use ExUnit.Case, async: true
  alias Anagrams.{Registry, WordAgent, Worker}

  setup do
    word_list = ~w{ab bc abc cba}

    {:ok, agent} = WordAgent.start_link(fn -> word_list end)

    workers = Enum.map(2..3, fn (n) ->
      {:ok, worker} = Worker.start_link(%{length: n, agent: agent})
      worker
    end)

    {:ok, registry} = Registry.start_link(workers)

    {:ok, word_list: word_list, workers: workers, registry: registry}
  end

  test "get workers", %{workers: workers, registry: registry} do
    assert Registry.get_workers(registry) == workers
  end

  test "get anagrams", %{word_list: word_list, registry: registry} do
    assert Registry.get_anagrams(registry, "abc") == word_list
  end
end
