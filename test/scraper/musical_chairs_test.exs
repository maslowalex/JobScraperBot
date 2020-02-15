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

      cl_jobs = Jobs.get_jobs_for("clarinet")

      %{link: link, deadline: deadline} = cl_jobs |> List.first
      assert link =~ "musicalchairs"
      assert deadline != nil

      assert Enum.all?(cl_jobs, fn (job) -> Date.compare(job.deadline, Date.utc_today()) end) == true
    end
  end
end
