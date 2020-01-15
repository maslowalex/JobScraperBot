defmodule Telegram.Bot do
  use ExGram.Bot, name: :periodical

  alias Telegram.Bot.{Command, Message}

  def bot, do: :periodical

  def handle({:command, command, _msg}, context) do
    Command.reply_for(command, context)
  end

  def handle({:text, from, %{text: text}}, context) do
    Message.reply_for(text, context)
  end

  def handle({type, _, _}, context) do
    IO.inspect type
    answer(context, "Not recognized")
  end
end
