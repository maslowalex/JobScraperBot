defmodule MusicalChairs do
  use Periodical.RepoCase, async: true

  alias Scraper.MusicalChairs
  alias Periodical.{Repo, Jobs}

  describe "getTitlesAndLinks/1" do
    setup  do
      MusicalChairs.perform()
    end

    test "scrape and save positions into db" do
      assert Repo.get_jobs_count > 25
    end
  end
end
