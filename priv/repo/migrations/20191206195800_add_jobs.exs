defmodule Periodical.Repo.Migrations.AddJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :location, :string
      add :link, :string
      add :position, :string
      add :instrument, :string
    end

    create unique_index(:jobs, [:link])
  end
end
