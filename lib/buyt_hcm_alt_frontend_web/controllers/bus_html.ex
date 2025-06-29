defmodule BuytHcmAltFrontendWeb.BusHTML do
  use BuytHcmAltFrontendWeb, :html
  # use BuytHcmAltFrontendWeb, :controller
  embed_templates "bus_proxy_html/*"

  # attr :routes

  # def show_routes(assigns) do
  #   ~H"""
  #   <section>
  #   <div {@routes}>
  #   <.routes_section />
  #   </div>
  #   </section>
  #   """
  # end

  def routes_section(assigns) do
    ~H"""
    <section>
      <div :for={route <- @routes}>
        <.route_details journey={route}/>
      </div>
    </section>
    """
  end

  def route_details(assigns) do
    # TODO: naming consistencies
    ~H"""
    <h2>Using route(s): {@journey.routes |> inspect()}</h2>
    <p>
      Total cost: {@journey.total_cost} <br>
      Total distance: {@journey.total_distance}
    </p>
    """
  end
end
