defmodule BuytHcmAltFrontendWeb.BuytchmComVnAdapter do
  @behaviour BuytHcmAltFrontendWeb.BusServiceUtility

  @impl true
  def get_routes_raw({fro_lat, fro_lon}, {to_lat, to_lon}, maxHops) do
    "http://apicms.ebms.vn/pathfinding/getpathbystop/#{fro_lat},#{fro_lon}/#{to_lat},#{to_lon}/#{maxHops}"
    |> Req.get()
  end
end
