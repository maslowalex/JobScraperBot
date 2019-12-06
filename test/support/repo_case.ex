defmodule Periodical.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Periodical.Repo

      import Ecto
      import Ecto.Query
      import Periodical.RepoCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Periodical.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Periodical.Repo, {:shared, self()})
    end

    :ok
  end
end
