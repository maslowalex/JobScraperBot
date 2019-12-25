defmodule Periodical.Repo do
  use Ecto.Repo,
    otp_app: :periodical,
    adapter: Ecto.Adapters.Postgres

  alias Periodical.{Jobs, Repo}
  import Ecto.Query, only: [from: 2]

  def save_job(items, instrument) do
    items
    |> Enum.each(fn row -> insert_row(row, instrument) end)
  end

  def get_jobs_count do
    query = from job in "jobs", select: count(job.id)
    Repo.one(query)
  end

  defp insert_row({name, position, link} = _item, instrument) do
    params = %{location: name, link: link, position: position, instrument: instrument}
    job = Jobs.changeset(%Jobs{}, params)

    Repo.insert(job)
  end
end
