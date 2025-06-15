defmodule BuytHcmAltFrontendWeb.GreetHTML do
  use BuytHcmAltFrontendWeb, :html

  def index(assigns) do
    ~H"""
    <center>
      <h1>
        Oh hi!
      </h1>
      <figure>
        <img src={"/images/deploy-parrot.gif"} alt="deploy parrot">
        <figcaption>
          Oh yeah baby.
        </figcaption>
      </figure>
    </center>
    """
  end
end
