defmodule BuytHcmAltFrontendWeb.Types do
  @moduledoc """
  https://elixirschool.com/en/lessons/advanced/typespec/
  This congregtes all the often reused types in this application
  """
  @type coord :: {latitude :: float, longtitude :: float}
  @type journey :: BuytHcmAltFrontendWeb.Structs.Journey.t()
  @type leg :: BuytHcmAltFrontendWeb.Structs.Leg.t()
end
