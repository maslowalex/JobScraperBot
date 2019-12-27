defmodule Telegram.Bot do
  use ExGram.Bot, name: :periodical

  require Logger
  alias Telegram.Bot.Command

  def bot(), do: :periodical

  def handle({:command, command, _msg}, context) do
    Command.reply_for(command, context)
  end
end
