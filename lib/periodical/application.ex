defmodule Periodical.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Periodical.Repo,
      {Periodical.Task, []},
      ExGram,
      {Telegram.Bot, [method: :polling, token: "token"]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Periodical.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
