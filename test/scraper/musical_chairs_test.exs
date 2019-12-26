defmodule MusicalChairs do
  use Periodical.RepoCase

  alias Scraper.MusicalChairs
  alias Periodical.{Jobs, Repo}

  describe "perform" do
    test "scrape musicalchairs site and save positions into db" do
      assert Repo.get_jobs_count == 0
      :ok = MusicalChairs.perform()
      Process.sleep(2_000)
      assert Repo.get_jobs_count > 25
    end
  end
end
