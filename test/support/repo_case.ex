defmodule Periodical.RepoCase do
  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL.Sandbox
  alias Periodical.{Repo, RepoCase}

  using do
    quote do
      import Ecto
      import Ecto.Query
      import RepoCase
    end
  end

  setup tags do
    :ok = Sandbox.checkout(Repo)

    unless tags[:async] do
      Sandbox.mode(Repo, {:shared, self()})
    end

    :ok
  end
end
