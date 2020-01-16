use Mix.Config

config :periodical, Periodical.Repo,
  database: "periodical_repo",
  username: "postgres",
  password: "postgres",
  url: System.get_env("DATABASE_URL"),
  pool: Ecto.Adapters.SQL.Sandbox

config :periodical, ecto_repos: [Periodical.Repo]
