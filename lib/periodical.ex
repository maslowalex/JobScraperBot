defmodule Periodical do
  def getTitlesAndLinks(instrument) do
    request = HTTPoison.get!("https://www.musicalchairs.info/#{instrument}/jobs")
    case request.status_code do
      200 ->
        Floki.find(request.body, ".preview")
        |> Enum.reduce([], fn x, acc ->
          acc ++ [{find_name(x), find_position(x), find_link(x)}]
        end)
        |> insert_to_repo(instrument)
      _ ->
        "Invalid instrument"
    end
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

  defp insert_to_repo(list, instrument) do
    list
    |> Enum.each(fn row -> save_row(row, instrument) end)
  end

  defp save_row({name, position, link} = _item, instrument) do
    params = %{location: name, link: link, position: position, instrument: instrument}
    job = Periodical.Jobs.changeset(%Periodical.Jobs{}, params)

    Periodical.Repo.insert(job)
  end
end
