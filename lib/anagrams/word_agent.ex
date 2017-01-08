defmodule Anagrams.WordAgent do
  @name __MODULE__

  def start_link do
    start_link(fn -> [] end)
  end

  def start_link(init_func, options \\ []) do
    Agent.start_link(init_func, options)
  end

  def get_word_list(agent \\ @name) do
    Agent.get(agent, fn (state) -> state end)
  end

  def set_word_list(agent \\ @name, word_list) do
    Agent.update(agent, fn (_state) -> word_list end)
  end
end
