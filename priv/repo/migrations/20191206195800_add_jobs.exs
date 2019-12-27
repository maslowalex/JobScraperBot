defmodule Periodical.Repo.Migrations.AddJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :location,   :string, null: false
      add :link,       :string, null: false
      add :position,   :string, null: false
      add :instrument, :string, null: false
      add :source,     :string, null: false
    end

    create unique_index(:jobs, [:link])
  end
end
