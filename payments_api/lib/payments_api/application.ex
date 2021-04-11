defmodule PaymentsApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the PubSub system
      {Phoenix.PubSub, name: PaymentsApi.PubSub},

      # This piece of configuration will start the Ecto process which
      # receives and executes our application's queries. Without it, we
      # wouldn't be able to query the database at all!
      {PaymentsApi.Repo, []},

      # Start the Endpoint (http/https)
      PaymentsApiWeb.Endpoint
      # Start a worker by calling: PaymentsApi.Worker.start_link(arg)
      # {PaymentsApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PaymentsApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PaymentsApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
