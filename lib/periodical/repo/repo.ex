defmodule Periodical.Repo do
  use Ecto.Repo,
    otp_app: :periodical,
    adapter: Ecto.Adapters.Postgres

  alias Periodical.{Jobs, Repo}
  import Ecto.Query, only: [from: 2]

  @valid_instruments ["clarinet", "oboe", "flute", "tuba"]

  def save_job(items, instrument, source) do
    items
    |> Enum.each(fn row -> insert_row(row, instrument, source) end)
  end

  def get_jobs_count do
    query = from job in "jobs", select: count(job.id)
    Repo.one(query)
  end

  def get_jobs_for(instrument) when instrument in @valid_instruments do
    query = from job in "jobs",
            where: job.instrument == ^instrument,
            select:  [:link, :position, :location, :source]

    Repo.all(query)
  end

  defp insert_row({name, position, link} = _item, instrument, source) do
    params = %{
      location: name,
      link: link,
      position: position,
      instrument: instrument,
      source: source
    }
    job = Jobs.changeset(%Jobs{}, params)

    Repo.insert(job)
  end
end
