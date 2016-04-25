defmodule Exavier.Slackbot.Bot do
  use Slack
  use Exavier.Slackbot.Match

  match ~r/hello|hi|hey|yo/, [Exavier.Slackbot.Language, :handle_hello]
  match ~r/what.*up/, [Exavier.Slackbot.Language, :handle_whats_up]
  match ~r/what.*my.*name/, [Exavier.Slackbot.Language, :handle_name_query]
  match ~r/name is (.+)/, [Exavier.Slackbot.Language, :handle_name_definition]

  def handle_connect(slack, state) do
    IO.puts "Exavier connected as #{slack.me.name}"
    {:ok, state}
  end

  def handle_message(_message, _slack, state), do: {:ok, state}
end
