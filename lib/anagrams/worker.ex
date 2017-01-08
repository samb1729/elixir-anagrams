defmodule Anagrams.Worker do
  use GenServer
  alias Anagrams.{Word, WordAgent}

  # Client

  def start_link(%{length: _} = params, options \\ []) do
    GenServer.start_link(__MODULE__, params, options)
  end

  def get_agent(worker) do
    GenServer.call(worker, {:get_agent})
  end

  def get_anagrams(worker, letters) do
    GenServer.call(worker, {:get_anagrams, letters})
  end

  # Server

  @default_agent Anagrams.WordAgent

  def init(%{length: _} = params) do
    {:ok, Map.put_new(params, :agent, @default_agent)}
  end

  def handle_call({:get_agent}, _from, %{agent: agent} = state) do
    {:reply, agent, state}
  end

  def handle_call({:get_anagrams, letters}, _from, %{length: length, agent: agent} = state) do
    {:reply, find_anagrams(letters, agent, length), state}
  end

  defp find_anagrams(letters, agent, length) do
    WordAgent.get_word_list(agent)
    |> filter_by_length(length)
    |> filter_anagrams(letters)
  end

  defp filter_by_length(word_list, length) do
    word_list
    |> Enum.filter(fn (str) ->
      String.length(str) == length
    end)
  end

  defp filter_anagrams(word_list, letters) do
    word_list
    |> Enum.filter(fn (word) ->
      Word.is_anagram?(word, letters)
    end)
  end
end
