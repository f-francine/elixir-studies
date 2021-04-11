defmodule PaymentsApi.Repo do
  use Ecto.Repo,
    otp_app: :payments_api,
    adapter: Ecto.Adapters.Postgres
end
