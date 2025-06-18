defmodule BuytHcmAltFrontendWeb.BusServiceUtility do
  @doc """
  Uses the adapter pattern to abstract over the specific bus services, encapsulate over them.
  """

  @type coords :: {latitude :: float, longtitude :: float}

  # Define the response template/contracts for the adapters
  @callback get_routes_raw(from_coords :: coords, to_coords :: coords, maxHops :: integer) :: any

  # Public functions that wraps around the adapter modules
  @spec get_routes_raw(from_coords :: coords, to_coords :: coords, maxHops :: integer) :: any
  def get_routes_raw({fro_lat, fro_lon}, {to_lat, to_lon}, maxHops) do
    adapter().get_routes_raw({fro_lat, fro_lon}, {to_lat, to_lon}, maxHops)
  end

  # Inject (?) the adapter specified in the config
  defp adapter() do
    Application.get_env(:buyt_hcm_alt_frontend, :bus_site_adapter)
  end
end
