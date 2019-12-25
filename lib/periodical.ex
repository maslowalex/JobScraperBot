defmodule Periodical do
  alias Scraper.MusicalChairs
  @available_scrapers [MusicalChairs]

  def sync_jobs do
    @available_scrapers
    |> Enum.each(fn x -> x.perform end)
  end
end
