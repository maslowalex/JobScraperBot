defmodule PeriodicalTest do
  use Periodical.RepoCase

  describe "getTitlesAndLinks/1" do
    test "scrape and save positions into db" do
      query = from j in Periodical.Jobs, select: count(j.id)

      {count, _} = Periodical.Repo.all(query) |> to_string() |> Integer.parse()
      assert count > 2
    end

    test "responds with error message when instrument not exists" do
      assert Periodical.getTitlesAndLinks("duduk") == "Invalid instrument"
    end
  end
end
