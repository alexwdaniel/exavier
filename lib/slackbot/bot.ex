defmodule Exavier.Slackbot.Bot do
  use Slack

  def handle_connect(slack, state) do
    IO.puts "Exavier connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_message(_message, _slack, state), do: {:ok, state}
end
