defmodule Periodical.Jobs do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:link, :location, :position, :instrument]

  schema "jobs" do
    field :location,   :string
    field :link,       :string
    field :position,   :string
    field :instrument, :string
  end

  def changeset(%Periodical.Jobs{} = job, params \\ %{}) do
    cast(job, params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:link)
  end
end
