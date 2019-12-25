defmodule Scraper.MusicalChairs do
  @url "https://www.musicalchairs.info"
  @endpoint "jobs"
  @instruments ["clarinet", "flute", "oboe"]

  def perform do
    @instruments
    |> Enum.each(fn instrument -> do_sync(instrument) end)
  end

  defp do_sync(instrument) do
    request = HTTPoison.get!("#{@url}/#{instrument}/#{@endpoint}")
    case request.status_code do
      200 ->
        filter_banners(request.body)
        |> format_rows()
        |> Periodical.Repo.save_job(instrument)
      _ ->
        "Invalid instrument"
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

  defp generate_row(element) do
    [{find_name(element), find_position(element), find_link(element)}]
  end

  defp find_name(item) do
    [{_, _, name}] = Floki.find(item, ".post_item_name")

    List.first(name)
  end

  defp find_position(item) do
    [{_, _, position}] = Floki.find(item, ".post_item_info")

    List.first(position)
  end

  defp find_link(item) do
    Floki.find(item, ".preview")
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> List.first
  end
end
