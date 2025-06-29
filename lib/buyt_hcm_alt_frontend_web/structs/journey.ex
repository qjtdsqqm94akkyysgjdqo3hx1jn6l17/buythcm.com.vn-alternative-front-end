defmodule BuytHcmAltFrontendWeb.Structs.Journey do
  defstruct [
    :legs,
    :start_coord,
    :dest_coord,
    :routes,
    :total_distance,
    :total_cost
  ]

  alias BuytHcmAltFrontendWeb.Types

  @type t :: %__MODULE__{
          legs: list(Types.leg()),
          start_coord: Types.coord(),
          dest_coord: Types.coord(),
          total_distance: float(),
          total_cost: non_neg_integer(),
          routes: [String.t()]
        }
end
