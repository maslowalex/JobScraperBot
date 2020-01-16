defmodule Periodical.Jobs do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:link, :location, :position, :instrument, :source, :deadline]

  schema "jobs" do
    field :location,   :string
    field :link,       :string
    field :position,   :string
    field :instrument, :string
    field :source,     :string
    field :deadline,   :date
  end

  def changeset(%Periodical.Jobs{} = job, params \\ %{}) do
    cast(job, params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:link)
  end

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
            select:  [:link, :position, :location, :source, :deadline]

    Repo.all(query)
  end

  defp insert_row({name, position, link, deadline} = _item, instrument, source) do
    params = %{
      location: name,
      link: link,
      position: position,
      instrument: instrument,
      deadline: deadline,
      source: source
    }

    job = Jobs.changeset(%Jobs{}, params)

    Repo.insert(job)
  end
end
