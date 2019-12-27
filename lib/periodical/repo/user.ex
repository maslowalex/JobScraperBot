defmodule Periodical.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Periodical.Repo

  @required_fields [:chat_id]

  schema "users" do
    field :chat_id, :integer
    field :active,  :boolean
  end

  def changeset(%Periodical.User{} = user, params \\ %{}) do
    cast(user, params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:chat_id)
  end

  alias Periodical.User
  import Ecto.Query, only: [from: 2]

  def save(params \\ %{}) do
    user = User.changeset(%User{}, params)

    Repo.insert(user)
  end

  def get_all() do
    Repo.all(User)
  end

  def count() do
    query = from u in "users", select: count(u.id)

    Repo.one(query)
  end
end
