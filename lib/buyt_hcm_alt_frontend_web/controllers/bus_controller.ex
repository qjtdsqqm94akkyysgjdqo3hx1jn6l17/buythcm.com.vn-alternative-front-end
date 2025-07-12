defmodule BuytHcmAltFrontendWeb.BusController do
  alias BuytHcmAltFrontendWeb.BusServiceUtility
  use BuytHcmAltFrontendWeb, :controller

  def index(conn, _param) do
    render(conn, :index, routes: nil)
  end

  def get_routes(conn, %{
        "from" => start_coord_str,
        "to" => dest_coord_str,
        "max_trips" => max_legs
      }) do
    parse_coord = fn coord_str ->
      case Regex.named_captures(~r/(?<lat>\d{2}\.\d+)\/(?<lon>\d{0,3}\.\d+)/, coord_str) do
        %{"lat" => lat, "lon" => lon} -> {:ok, {String.to_float(lat), String.to_float(lon)}}
        nil -> {:error, "Can't parse '#{coord_str}'."}
      end
    end

    with {:ok, start_coord} <- parse_coord.(start_coord_str),
         {:ok, dest_coord} <- parse_coord.(dest_coord_str) do
      {:ok, routes} = BusServiceUtility.get_routes(start_coord, dest_coord, max_legs)
      render(conn, :index, routes: routes)
    else
      {:error, message} ->
        put_flash(conn, :error, message)
        |> render(:index, routes: nil)
    end
  end

  def get_routes(
        conn,
        %{
          "from" => _start_coord_str,
          "to" => _dest_coord_str
        } = params
      ) do
    get_routes(conn, params |> Map.put("max_trips", 2))
  end

  def get_routes(conn, _param) do
    conn
    |> put_flash(:error, "...え?")
    |> render(:index, routes: nil)
  end

  # def get_routes(conn, %{
  #       "start_coord" => start_coord,
  #       "dest_coord" => dest_coord
  #     }) do
  # end

  # defp parse_coord(coord, separator) do
  #   prase_float = fn number ->
  #     case Float.parse(number) do
  #       {float, ""} -> float
  #       {float, exccess} -> put_flash()
  #     end   end
  #   String.split(coord, separator)
  #   |> Enum.
  #   case do
  #     [lat, long]
  #   end

  # end
  def get_routes_old(conn, param) do
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
