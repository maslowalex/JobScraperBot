defmodule Telegram.Bot.Message do
  use ExGram.Bot, name: :periodical

  alias Periodical.{Jobs, Dates}

  @avaliable_instruments ["clarinet", "oboe", "flute", "tuba"]

  def reply_for(msg, context) when msg in @avaliable_instruments do
    jobs = Jobs.get_jobs_for(msg)
    chat_id = extract_user_from_context(context)

    answer(context, "Here some jobs for #{msg}, that I've found on musicalchairs.com")
    jobs
    |> Enum.each(fn (job) ->
      ExGram.send_message(chat_id, msg_text(:instrument, job))
    end)
  end

  def reply_for(_text, context) do
    answer(context, "Don't know what you mean.")
  end

  defp msg_text(:instrument, job) do
    """
    Position: #{job[:position]}
    Location: #{job[:location]}
    Link: #{job[:link]}
    Deadline: #{job[:deadline]} (#{Dates.difference_in_words(job[:deadline])})
    """
  end

  defp extract_user_from_context(context) do
    %ExGram.Cnt{
      update: %ExGram.Model.Update{
        message: %{
          from: from
        }
      }
    } = context

    from[:id]
  end
end
