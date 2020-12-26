defmodule Elbarber.Repo do
  use Ecto.Repo,
    otp_app: :elbarber,
    adapter: Ecto.Adapters.Postgres
end
