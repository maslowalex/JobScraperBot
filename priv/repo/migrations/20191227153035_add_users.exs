defmodule Periodical.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :chat_id, :integer, null: false
      add :active,  :boolean, default: true
    end

    create unique_index(:users, :chat_id)
  end
end
