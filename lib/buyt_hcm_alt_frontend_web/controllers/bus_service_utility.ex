defmodule BuytHcmAltFrontendWeb.BusServiceUtility do
  @moduledoc """
  Uses the adapter pattern to abstract over the specific bus services, encapsulate over them.
  """

  # @type coords :: {latitude :: float, longtitude :: float}
  #
  alias BuytHcmAltFrontendWeb.Types

  # Define the response template/contracts for the adapters
  @callback get_routes_raw(
              from_coords :: Types.coord(),
              to_coords :: Types.coord(),
              maxHops :: integer()
            ) :: any()

  @callback get_routes!(
              from_coords :: Types.coord(),
              to_coords :: Types.coord(),
              maxHops :: integer()
            ) :: [Types.journey()]
  @callback get_routes(
              from_coords :: Types.coord(),
              to_coords :: Types.coord(),
              maxHops :: integer()
            ) :: {:ok, [Types.journey()]} | {:error, msg :: any()}

  # Public functions that wraps around the adapter modules
  @spec get_routes_raw(
          from_coords :: Types.coord(),
          to_coords :: Types.coord(),
          maxHops :: integer()
        ) :: any()
  def get_routes_raw({fro_lat, fro_lon}, {to_lat, to_lon}, maxHops) do
    adapter().get_routes_raw({fro_lat, fro_lon}, {to_lat, to_lon}, maxHops)
  end

  @spec get_routes!(
          from_coords :: Types.coord(),
          to_coords :: Types.coord(),
          maxHops :: integer()
        ) :: [Types.journey()]
  def get_routes!({fro_lat, fro_lon}, {to_lat, to_lon}, maxHops) do
    adapter().get_routes!({fro_lat, fro_lon}, {to_lat, to_lon}, maxHops)
  end

  @spec get_routes(
          from_coords :: Types.coord(),
          to_coords :: Types.coord(),
          maxHops :: integer()
        ) :: {:ok, [Types.journey()]} | {:error, msg :: any()}
  def get_routes({fro_lat, fro_lon}, {to_lat, to_lon}, maxHops) do
    adapter().get_routes({fro_lat, fro_lon}, {to_lat, to_lon}, maxHops)
  end

  # Inject (?) the adapter specified in the config
  defp adapter() do
    Application.get_env(:buyt_hcm_alt_frontend, :bus_site_adapter)
  end
end
