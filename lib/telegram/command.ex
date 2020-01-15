defmodule Telegram.Bot.Command do
  use ExGram.Bot, name: :periodical

  def reply_for("start", context) do
    context |> extract_user_from_context |> save_user

    msg = """
    Welcome to Musical jobs bot!
    We glad to see you here. Please select instrument you want to track jobs for.
    """

    answer(context, msg, [reply_markup: start_markup()])
  end

  defp start_markup do
    %ExGram.Model.ReplyKeyboardMarkup{
      keyboard: [start_keys()]
    }
  end

  defp start_keys do
    Enum.map(["clarinet", "oboe", "flute", "tuba"], fn instrument ->
      %ExGram.Model.KeyboardButton{text: instrument}
    end)
  end

  def reply_for(_, context) do
    answer(context, "Don't know even what to say.")
  end

  defp extract_user_from_context(context) do
    %ExGram.Cnt{
      update: %ExGram.Model.Update{
        message: %{
          from: from
        }
      }
    } = context

    %{chat_id: from[:id]}
  end

  defp save_user(user_params) do
    Periodical.User.save(user_params)
  end
end
