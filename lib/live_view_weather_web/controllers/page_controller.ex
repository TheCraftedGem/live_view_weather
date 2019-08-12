defmodule LiveViewWeatherWeb.PageController do
  use LiveViewWeatherWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def test(conn, _params) do
    LiveView.Controller.live_render(conn, LiveViewWeatherWeb.GithubDeployView, session: %{})
  end
end
