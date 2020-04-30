defmodule SerialKiller.Application do
  use Application

  def start(_type, _args),
    do: Supervisor.start_link(children(), opts())

  defp children do
    [
      {Postgrex, Keyword.put(Application.get_env(:serial_killer, :db), :name, DB)},
      SerialKiller.Endpoint
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: SerialKiller.Supervisor
    ]
  end
end
