defmodule Anagrams.Registry do
  alias Anagrams.Worker

  @name __MODULE__

  # Agent

  def start_link(workers, options \\ []) do
    Agent.start_link(fn -> workers end, options)
  end

  def get_workers(agent \\ @name) do
    Agent.get(agent, fn (state) -> state end)
  end

  def get_anagrams(agent \\ @name, letters) do
    get_workers(agent)
    |> Enum.map(fn (worker) ->
      Task.async(fn ->
        Worker.get_anagrams(worker, letters)
      end)
    end)
    |> Enum.flat_map(&Task.await/1)
  end

  # Helpers

  def worker_name(length) do
    :"worker#{length}"
  end
end
