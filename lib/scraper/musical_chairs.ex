defmodule Scraper.MusicalChairs do
  @url "https://www.musicalchairs.info"
  @endpoint "jobs"
  @instruments ["clarinet", "flute", "oboe", "tuba"]
  @source "musicalchairs"

  alias Periodical.Dates
  require Logger

  def perform do
    @instruments
    |> Task.async_stream(&do_sync/1)
    |> Enum.to_list()
  end

  def do_sync(instrument) do
    request = HTTPoison.get!("#{@url}/#{instrument}/#{@endpoint}")
    case request.status_code do
      200 ->
        filter_banners(request.body)
        |> format_rows()
        |> Periodical.Jobs.save_job(instrument, @source)
      404 ->
        Logger.error("Page for '#{instrument}' do not exists on this site. Check @instruments in #{__MODULE__}.")
      code ->
        Logger.warn("Fail to scrape page for #{instrument}. Response code: #{code}")
    end
  end

  defp filter_banners(body) do
    Floki.find(body, ".preview")
    |> Enum.reject(fn x -> Floki.find(x, ".rev-container") != [] end)
  end

  defp format_rows(filtered_list) do
    Enum.reduce(filtered_list, [], fn x, acc ->
      acc ++ generate_row(x)
    end)
  end

  defp generate_row(el) do
    [{name(el), position(el), link(el), deadline(el)}]
  end

  defp name(item) do
    [{_, _, name}] = Floki.find(item, ".post_item_name")

    List.first(name)
  end

  defp position(item) do
    [{_, _, position}] = Floki.find(item, ".post_item_info")

    List.first(position)
  end

  defp link(item) do
    Floki.find(item, ".preview")
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> List.first
  end

  defp deadline(item) do
    try do
      [
        {
          _, _,
          [
            _,
            {_, _, [deadline_string]}
          ]
        }
      ] = Floki.find(item, ".post_item_closingdate")

      Dates.convert_to_datetime(deadline_string)

      rescue
        MatchError ->
          Dates.convert_to_datetime("n/a")
    end
  end
end
