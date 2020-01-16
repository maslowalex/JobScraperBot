defmodule Periodical.Repo.Migrations.AddDeadlineToJobs do
  use Ecto.Migration

  def change do
    alter table("jobs") do
      add :deadline, :date
    end
  end
end
