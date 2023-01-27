defmodule PostgrexTypes do

Postgrex.Types.define(Venue.PostgresTypes,
              [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
              json: Poison)
end