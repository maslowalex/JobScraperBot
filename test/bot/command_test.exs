defmodule CommandTest do
  use Periodical.RepoCase
  alias Telegram.Bot
  import Telegram.Context

  describe "start" do
    setup do
      %ExGram.Cnt{answers: [
        response: %ExGram.Responses.Answer{
          text: text
        }
      ]} = Bot.handle({:command, "start", ""}, common_context("start"))

      [text: text]
    end

    test "it responds with welcome message", context do
      assert context[:text] == "Welcome to Musical jobs bot!"
    end

    # test "it saves users chat_id and name to DB, when called first time" do

    # end

    # test "it don't try to save user info twice" do

    # end
  end
end
