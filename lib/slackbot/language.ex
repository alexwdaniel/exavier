defmodule Exavier.Slackbot.Language do
  def handle_hello(message, slack, state) do
    "Hello, #{message.user}."
    |> Slack.send_message(message.channel, slack)
    {:ok, state}
  end

  def handle_whats_up(message, slack, state) do
    "Nothing much, just doin' bot stuff."
    |> Slack.send_message(message.channel, slack)
    {:ok, state}
  end

  def handle_name_query(message, slack, %{name: name} = state) do
    "It's #{name}"
    |> Slack.send_message(message.channel, slack)
    {:ok, state}
  end
  def handle_name_query(message, slack, state) do
    "Sorry, you haven't told me your name yet."
    |> Slack.send_message(message.channel, slack)
    {:ok, state}
  end

  def handle_name_definition(message, slack, state, name) do
    "Nice to meet you, #{name}."
    |> Slack.send_message(message.channel, slack)
    {:ok, Map.merge(state, %{name: name})}
  end
end
