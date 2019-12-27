defmodule Telegram.Context do
  def common_context(message_text) do
    %ExGram.Cnt{
      answers: [],
      bot_info: %ExGram.Model.User{
        first_name: "elixir_test",
        id: 870508772,
        is_bot: true,
        language_code: nil,
        last_name: nil,
        username: "elix_bot"
      },
      commands: [],
      extra: %{},
      halted: false,
      message: nil,
      middleware_halted: false,
      middlewares: [],
      name: :periodical,
      regex: [],
      responses: [],
      update: %ExGram.Model.Update{
        callback_query: nil,
        channel_post: nil,
        chosen_inline_result: nil,
        edited_channel_post: nil,
        edited_message: nil,
        inline_query: nil,
        message: %{
          chat: %{
            first_name: "Anonymous",
            id: 987654321,
            last_name: "Anno",
            type: "private",
            username: "anonymous_anno"
          },
          date: 1577464529,
          entities: [%{length: 5, offset: 0, type: "bot_command"}],
          from: %{
            first_name: "Anonymous",
            id: 987654321,
            is_bot: false,
            language_code: "en",
            last_name: "Anno",
            username: "anonymous_anno"
          },
          message_id: 174,
          text: message_text
        },
        poll: nil,
        pre_checkout_query: nil,
        shipping_query: nil,
        update_id: 774595114
      }
    }
  end
end
