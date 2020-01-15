defmodule CommandTest do
  use Periodical.RepoCase
  alias Telegram.Bot
  import Telegram.Context

  describe "start" do
    setup do
      %ExGram.Cnt{
        answers: [
          response: %ExGram.Responses.Answer{
            text: text
          }
        ],
        update: %ExGram.Model.Update{
          message: %{
            from: from
          }
        }
      } = Bot.handle({:command, "start", ""}, common_context("start"))

      [text: text, from: from]
    end

    test "it responds with welcome message", context do
      assert context[:text] =~ "Welcome to Musical jobs bot!"
    end

    test "it saves users chat_id and name to DB, when called first time", context do
      assert Periodical.User.count == 1

      user = Periodical.User.get_all() |> List.first()
      assert user.chat_id == context[:from][:id]
    end

    test "it don't save user info twice" do
      Bot.handle({:command, "start", ""}, common_context("start"))

      assert Periodical.User.count == 1
    end
  end
end
