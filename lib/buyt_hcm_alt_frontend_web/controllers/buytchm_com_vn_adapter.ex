defmodule BuytHcmAltFrontendWeb.BuytchmComVnAdapter do
  alias BuytHcmAltFrontendWeb.Structs.Journey
  alias BuytHcmAltFrontendWeb.Types
  alias BuytHcmAltFrontendWeb.Structs.Leg
  @behaviour BuytHcmAltFrontendWeb.BusServiceUtility

  @impl true
  def get_routes(from_coords, to_coords, maxHops) do
    {:ok, %Req.Response{status: 200, body: data}} =
      get_routes_raw(from_coords, to_coords, maxHops)

    # data
    try do
      Enum.map(data, fn journey_data -> parse_journey(journey_data) end)
    catch
      err -> {:error, inspect(err)}
    else
      journeys -> {:ok, journeys}
    end
  end

  @impl true
  def get_routes!(from_coords, to_coords, maxHops) do
    {:ok, %Req.Response{status: 200, body: data}} =
      get_routes_raw(from_coords, to_coords, maxHops)

    # data
    Enum.map(data, fn journey_data -> parse_journey(journey_data) end)
  end

  @spec parse_journey(journey_data :: map()) :: Types.journey()
  defp parse_journey(journey_data) do
    # journey_data |> dbg()
    legs = parse_legs(journey_data)

    # itterate through list once for these 3
    {total_distance, total_cost, routes_reverse} =
      legs
      |> Enum.reduce({0, 0, []}, fn
        element, {distance, cost, routes_rev} = _acc ->
          case element.type do
            :bus ->
              {
                if is_number(element.distance) && is_number(distance) do
                  element.distance + distance
                end,
                if is_number(element.fare) && is_number(cost) do
                  element.fare + cost
                end,
                [element.route | routes_rev]
              }

            :walk ->
              {
                if is_number(element.distance) do
                  element.distance + distance
                end,
                cost,
                routes_rev
              }

            _ ->
              raise "WTF is this bro??"
          end
      end)

    %Journey{
      start_coord: hd(legs).from_coord,
      # not ideal, but whatever
      dest_coord: List.last(legs).to_coord,
      routes: Enum.reverse(routes_reverse),
      total_cost: total_cost,
      total_distance: total_distance,
      legs: legs
    }
  end

  @spec parse_legs(journey_data :: map()) :: list(Types.leg())
  defp parse_legs(journey_data) do
    # get a list of stops going pass in the trip & the transitional stops. then break them up per leg.
    import BuytHcmAltFrontendWeb.ListUtilities, only: [chunk_by_breakpoints: 2]

    transitional_stop_names =
      Map.fetch!(journey_data, "detail")
      |> Enum.map(fn leg_details -> Map.fetch!(leg_details, "GetOff") end)

    stop_names =
      Map.fetch!(journey_data, "stops")
      |> Enum.map(fn leg_details -> Map.fetch!(leg_details, "Name") end)

    stops_per_leg = chunk_by_breakpoints(stop_names, transitional_stop_names)

    Map.fetch!(journey_data, "detail")
    |> Enum.zip(stops_per_leg)
    |> Enum.map(fn
      {leg_data, stops_in_leg} ->
        parse_individual_leg(leg_data, stops_in_leg)
    end)
  end

  defp parse_individual_leg(leg_data, stops_in_leg) do
    parse_type = fn
      nil -> :walk
      _route_number -> :bus
    end

    parse_integer = fn
      integer when integer in ["0", 0, 0.0] -> nil
      integer when is_number(integer) -> integer
      integer when is_bitstring(integer) -> String.to_integer(integer)
      _ -> :undefined
    end

    # since the lat and long's names are kinda spontanious, I'll just make function-level parser

    %Leg{
      type: Map.fetch!(leg_data, "RouteNo") |> parse_type.(),
      distance: Map.fetch!(leg_data, "Distance") |> parse_integer.(),
      from_name: Map.fetch!(leg_data, "GetIn"),
      from_coord: leg_data |> parse_coord("GetInLat", "GetInLng"),
      to_name: Map.fetch!(leg_data, "GetOff"),
      to_coord: leg_data |> parse_coord("GetOffLat", "GetOffLng"),
      fare: Map.fetch!(leg_data, "Fare") |> parse_integer.(),
      route: Map.fetch!(leg_data, "RouteNo"),
      path: nil,
      stops: stops_in_leg
    }
  end

  defp parse_coord(leg_data, lat_name, long_name) do
    {
      Map.fetch!(leg_data, lat_name),
      Map.fetch!(leg_data, long_name)
    }
  end

  # defp parse_leg_type(url) do
  #   "\\Assets\\Icon\\" <> icon_name <> ".png" = url

  #   case String.downcase(icon_name) do
  #     "walk" ->
  #       :walk
  #       "bus"
  #   end
  # end

  @impl true
  def get_routes_raw({fro_lat, fro_lon}, {to_lat, to_lon}, maxHops) do
    "http://apicms.ebms.vn/pathfinding/getpathbystop/#{fro_lat},#{fro_lon}/#{to_lat},#{to_lon}/#{maxHops}"
    |> Req.get()
  end
end
