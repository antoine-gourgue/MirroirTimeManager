defmodule Theme01.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Theme01Web.Telemetry,
      Theme01.Repo,
      {DNSCluster, query: Application.get_env(:theme01, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Theme01.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Theme01.Finch},
      # Start a worker by calling: Theme01.Worker.start_link(arg)
      # {Theme01.Worker, arg},
      # Start to serve requests, typically the last entry
      Theme01Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Theme01.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Theme01Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
