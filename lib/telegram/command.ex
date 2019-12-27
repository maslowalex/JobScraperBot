defmodule Telegram.Bot.Command do
  use ExGram.Bot, name: :periodical

  def reply_for("start", context) do
    answer(context, "Welcome to Musical jobs bot!")
  end

  def reply_for(_, context) do
    answer(context, "Don't know even what to say.")
  end
end
