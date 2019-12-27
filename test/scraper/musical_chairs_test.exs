defmodule MusicalChairsTest do
  use Periodical.RepoCase

  alias Periodical.Jobs
  alias Scraper.MusicalChairs

  describe "perform" do
    setup do
      MusicalChairs.perform()
    end

    test "scrape musicalchairs site and save positions into db" do
      assert Jobs.get_jobs_count > 25

      %{link: link} = Jobs.get_jobs_for("clarinet") |> List.first
      assert link =~ "musicalchairs"
    end
  end
end
