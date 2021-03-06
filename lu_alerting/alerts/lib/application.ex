defmodule Alerts.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      LineUpdates.Registry,
      LineUpdates.LineUpdateProducer,
      StationUpdates.Registry,
      StationUpdates.StationUpdateProducer,
      StatusUpdates.PerpetualUpdater,
      {Task.Supervisor, name: TaskSupervisor}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Alerts.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
