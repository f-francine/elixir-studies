defmodule PaymentsApiWeb.Router do
  use PaymentsApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PaymentsApiWeb do
    pipe_through :api
  end
end
