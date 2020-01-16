defmodule MusicalChairsTest do
  use Periodical.RepoCase

  alias Periodical.Jobs
  alias Scraper.MusicalChairs

  describe "perform" do
    setup do
      MusicalChairs.perform
    end

    test "scrape musicalchairs site and save positions into db" do
      assert Jobs.get_jobs_count > 25

      %{link: link, deadline: deadline} = Jobs.get_jobs_for("clarinet") |> List.first
      assert link =~ "musicalchairs"
      assert deadline != nil
    end
  end
end
