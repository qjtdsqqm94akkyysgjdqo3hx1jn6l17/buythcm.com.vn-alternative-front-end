defmodule BuytHcmAltFrontendWeb.Structs.Leg do
  @moduledoc """
  Basically a segment of the journey. can be either over a bus trip or by foot.
  """
  alias BuytHcmAltFrontendWeb.Types

  @enforce_keys [:type, :distance, :from_name, :from_coord, :to_name, :to_coord]
  defstruct [
    :type,
    :distance,
    :from_name,
    :from_coord,
    :to_name,
    :to_coord,
    :fare,
    :route,
    :path,
    :stops
  ]

  @type t :: %__MODULE__{
          type: :bus | :walk,
          distance: non_neg_integer(),
          from_name: String.t(),
          from_coord: Types.coord(),
          to_name: String.t(),
          to_coord: Types.coord(),
          fare: non_neg_integer() | nil,
          route: String.t() | nil,
          path: list(Types.coord()),
          stops: list(String.t())
        }
end
