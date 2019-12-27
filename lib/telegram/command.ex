defmodule Telegram.Bot.Command do
  use ExGram.Bot, name: :periodical

  def reply_for("start", context) do
    context |> extract_user_from_context |> save_user

    answer(context, "Welcome to Musical jobs bot!")
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
