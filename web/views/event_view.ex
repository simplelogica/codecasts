defmodule Codecasts.EventView do
  use Codecasts.Web, :view

  @event_place_names %{
    all: gettext("All places"),
    madrid: gettext("Madrid"),
    oviedo: gettext("Oviedo"),
    online: gettext("Online")
  }

  def get_places(include_all \\ false) do
    places = EventPlaceEnum.__enum_map__()
    |> Keyword.keys()

    case include_all do
      true ->
        [:all, places]
        |> List.flatten()
      _ ->
        places
    end
  end

  def get_places_for_select(include_all \\ false) do
    get_places(include_all)
    |> Enum.map(fn p ->
      {get_place_name(p), p}
    end)
  end

  def get_place_name(event_place) do
    @event_place_names
    |> Map.get(event_place)
  end

  def get_short_description(event) do
    result = event.description
    |> String.slice(0..100)

    "#{result}..."
  end
end
