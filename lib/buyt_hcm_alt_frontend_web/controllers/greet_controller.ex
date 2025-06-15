defmodule BuytHcmAltFrontendWeb.GreetController do
  use BuytHcmAltFrontendWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
