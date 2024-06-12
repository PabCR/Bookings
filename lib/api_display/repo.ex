defmodule ApiDisplay.Repo do
  use Ecto.Repo,
    otp_app: :api_display,
    adapter: Ecto.Adapters.Postgres
end
