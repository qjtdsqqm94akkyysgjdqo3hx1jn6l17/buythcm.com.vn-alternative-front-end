defmodule BuytHcmAltFrontendWeb.BusController do
  alias BuytHcmAltFrontendWeb.BusServiceUtility
  use BuytHcmAltFrontendWeb, :controller

  def get_routes(conn, param) do
    routes =
      BusServiceUtility.get_routes(
        {param["start_lat"], param["start_lng"]},
        {param["dest_lat"], param["dest_lng"]},
        param["max_hop"]
      )
      |> dbg()

    render(conn, :index, routes: routes)
  end
end
