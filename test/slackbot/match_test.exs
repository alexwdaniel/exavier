defmodule Exavier.Slackbot.MatchTest do
  use ExUnit.Case

  defmodule Matcher do
    use Exavier.Slackbot.Match
    match ~r/hello/, :handle_hello
    match ~r/name\s(.*)/, :handle_name

    def handle_hello(_message, _slack, _state), do: {:ok, "hello result"}

    def handle_name(_message, _slack, _state, name), do: {:ok, "#{name} result"}
  end

  test "it calls the matched function" do
    message = %{type: "message", text: "hello message"}
    assert Matcher.handle_message(message, %{}, %{}) == {:ok, "hello result"}
  end

  test "it passes regex captures to the matched function" do
    message = %{type: "message", text: "name testing"}
    assert Matcher.handle_message(message, %{}, %{}) == {:ok, "testing result"}
  end
end
