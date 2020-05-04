defmodule SerialKiller.Application do
  use Application

  def start(_type, _args),
    do: Supervisor.start_link(children(), opts())

  defp children do
    db_opts = Application.get_env(:serial_killer, :db)
    port = Application.get_env(:serial_killer, :port)

    [
      {Postgrex, Keyword.put(db_opts, :name, SerialKiller.DB)},
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: SerialKiller.Router,
        options: [port: port]
      )
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: SerialKiller.Supervisor
    ]
  end
end
