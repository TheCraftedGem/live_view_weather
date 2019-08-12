defmodule LiveViewWeather.Repo do
  use Ecto.Repo,
    otp_app: :live_view_weather,
    adapter: Ecto.Adapters.Postgres
end
