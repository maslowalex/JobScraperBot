defmodule PeriodicalTest do
  use Periodical.RepoCase

  describe "getTitlesAndLinks/1" do
    test "scrape and save positions into db" do
      assert Periodical.getTitlesAndLinks("clarinet") == :ok
    end

    test "responds with error message when instrument not exists" do
      assert Periodical.getTitlesAndLinks("duduk") == "Invalid instrument"
    end
  end
end
