defmodule Venue.Repo do
  use Ecto.Repo,
    otp_app: :venue,
    adapter: Ecto.Adapters.Postgres

end
