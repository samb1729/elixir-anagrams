defmodule Anagrams do
  use Application
  alias Anagrams.{File, Registry, Worker, WordAgent}

  @length_range 2..9

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    word_agent = worker(WordAgent, [fn -> File.load_words end, [name: WordAgent]])
    workers = Enum.map(@length_range, fn n ->
      name = Registry.worker_name(n)
      worker(Worker, [%{length: n}, [name: name]], id: n)
    end)

    worker_names = @length_range |> Enum.map(&Registry.worker_name/1)
    registry = worker(Registry, [worker_names, [name: Registry]])

    children = [word_agent, registry] ++ workers

    opts = [strategy: :one_for_one, name: Anagrams.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
