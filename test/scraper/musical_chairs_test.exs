defmodule MusicalChairs do
  use Periodical.RepoCase

  alias Scraper.MusicalChairs
  alias Periodical.{Jobs, Repo}

  describe "perform" do
    setup do
      MusicalChairs.perform()
    end

    test "scrape musicalchairs site and save positions into db" do
      assert Repo.get_jobs_count > 25

      %{link: link} = Periodical.Repo.get_jobs_for("clarinet") |> List.first
      assert link =~ "musicalchairs"
    end
  end
end
