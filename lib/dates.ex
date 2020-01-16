defmodule Periodical.Dates do
  @months_abbr [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ]

  def convert_to_datetime(date_string) do
    date_string
    |> String.split
    |> Enum.map(fn date_unit ->
      case Integer.parse(date_unit) do
        {result, _} -> result
        :error -> month_abbr_to_num(date_unit)
      end
    end)
    |> date_from_list()
  end

  def difference_in_words(date) do
    diff_in_days = Date.diff(date, Date.utc_today())

    case diff_in_days > 31 do
      true -> "in about #{trunc(diff_in_days / 31)} month(s)"
      _ -> "in #{diff_in_days} days"
    end
  end

  defp date_from_list([day, month, year] = _date_list) do
    {:ok, date} = Date.new(year, month, day)

    date
  end

  defp date_from_list([date] = _date_list) when date == nil do
    raise "Invalid date #{date}"
  end

  defp date_from_list([date] = _date_list), do: date

  defp month_abbr_to_num(abbr) when abbr in @months_abbr do
    Enum.find_index(@months_abbr, fn m -> m == abbr end) + 1
  end

  defp month_abbr_to_num(wrong_abbr) when wrong_abbr == "n/a", do: ~D[2029-12-31]

  defp month_abbr_to_num(wrong_abbr) do
    raise "Unexpected month abbr #{wrong_abbr}."
  end
end
