defmodule Razoyo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      RazoyoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Razoyo.PubSub},
      # Start the Endpoint (http/https)
      RazoyoWeb.Endpoint
      # Start a worker by calling: Razoyo.Worker.start_link(arg)
      # {Razoyo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Razoyo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RazoyoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
