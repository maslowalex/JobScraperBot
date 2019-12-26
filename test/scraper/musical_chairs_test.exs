defmodule MusicalChairs do
  use Periodical.RepoCase

  alias Scraper.MusicalChairs
  alias Periodical.{Jobs, Repo}

  describe "perform" do
    setup do
      MusicalChairs.perform()
      Process.sleep(1_000)
    end

    test "scrape musicalchairs site and save positions into db" do
      assert Repo.get_jobs_count > 25
    end
  end
end
