defmodule Exavier.Slackbot.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(Exavier.Slackbot.Bot, [System.get_env("SLACK_API_TOKEN"), %{}])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
