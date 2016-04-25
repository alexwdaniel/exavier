defmodule Exavier do
  use Application

  def start(_type, _args) do
    Exavier.Slackbot.Supervisor.start_link
  end
end
