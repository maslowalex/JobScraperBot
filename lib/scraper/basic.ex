defmodule Scraper.Basic do
  @type instrument ::
                :clarinet |
                :flute |
                :oboe |
                :tuba

  @callback perform :: [{:ok | :error, 200 | integer()}]
  @callback do_sync(instrument()) :: {:ok, :success} | {:error, integer()}
end
