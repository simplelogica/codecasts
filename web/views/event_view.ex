defmodule Codecasts.EventView do
  use Codecasts.Web, :view

  @event_place_names %{
    madrid: "Madrid",
    oviedo: "Oviedo",
    online: "Online"
  }

  def get_event_place_name(event_place) do
    @event_place_names
    |> Map.get(event_place)
  end
end
