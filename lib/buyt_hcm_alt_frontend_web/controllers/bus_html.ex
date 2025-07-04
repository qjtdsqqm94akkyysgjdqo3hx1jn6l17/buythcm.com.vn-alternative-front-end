defmodule BuytHcmAltFrontendWeb.BusHTML do
  use BuytHcmAltFrontendWeb, :html
  use BuytHcmAltFrontendWeb, :controller
  use Phoenix.Component
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
    <section class="results">
      <header>
      Possible routes:
      </header>
      <div>
        <.route_details journey={hd(@routes)} open={true} />
      </div>
      <div :for={route <- tl(@routes)}>
        <.route_details journey={route}/>
      </div>
    </section>
    """
  end

  attr :open, :boolean, default: false
  attr :journey, BuytHcmAltFrontendWeb.Structs.Journey, required: true
  def route_details(assigns) do
    import BuytHcmAltFrontendWeb.ListUtilities, only: [to_sentence: 2]
    # TODO: naming consistencies
    ~H"""
    <details { if @open, do: [open: true], else: [] } >
      <summary>
        <h2>Using route(s): {to_sentence(@journey.routes, [])}</h2>
        <p>
          Total cost: {@journey.total_cost} <br>
          Total distance: {@journey.total_distance}
        </p>
      </summary>
      <%= for leg <- @journey.legs do %>
      <h3>{leg.type}</h3>
      <ul class="connected-list">
        <%= for stop <- leg.stops do %>
          <li>{stop}</li>
        <% end %>
      </ul>
      <% end %>
    </details>
    <hr/>

    """
  end
end
