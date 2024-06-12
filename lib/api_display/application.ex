defmodule ApiDisplay.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ApiDisplayWeb.Telemetry,
      ApiDisplay.Repo,
      {DNSCluster, query: Application.get_env(:api_display, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ApiDisplay.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ApiDisplay.Finch},
      # Start a worker by calling: ApiDisplay.Worker.start_link(arg)
      # {ApiDisplay.Worker, arg},
      # Start to serve requests, typically the last entry
      ApiDisplayWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ApiDisplay.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ApiDisplayWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
