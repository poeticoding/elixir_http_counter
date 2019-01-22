defmodule HttpCounter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def http_port do
    (System.get_env("PORT") || "4000")|> String.to_integer()
  end
  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      Plug.Cowboy.child_spec(scheme: :http, plug: HttpCounter.Router, options: [port: http_port()])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HttpCounter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
