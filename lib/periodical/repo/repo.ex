defmodule Periodical.Repo do
  use Ecto.Repo,
    otp_app: :periodical,
    adapter: Ecto.Adapters.Postgres
end
