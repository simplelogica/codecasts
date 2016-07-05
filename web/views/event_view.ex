defmodule Codecasts.EventView do
  use Codecasts.Web, :view

  @event_place_names %{
    all: gettext("All places"),
    madrid: gettext("Madrid"),
    oviedo: gettext("Oviedo"),
    online: gettext("Online")
  }

  @doc """
  Auxiliar function to get results subtitle based on filter params.
  """
  def get_results_subtitle(conn) do
    IO.inspect(conn.params)
    case conn.params do
      %{"filter" => filters} ->
        query = filters
        |> Map.get("q", "")

        place = filters
        |> Map.get("place", "")

        # If place is all, blank it. If not, convert to atom.
        place = if(place == "all", do: "", else: String.to_atom(place))

        # Pattern match different scenarios.
        case [query, place] do
          ["", ""] ->
            gettext("all events")
          ["", _] ->
            gettext("events in %{place}", place: get_place_name(place))
          [_, ""] ->
            gettext("events with '%{query}'", query: query)
          _ ->
            gettext("events with '%{query}' in %{place}", query: query, place: get_place_name(place))
        end
      _ ->
        # If no filter is received, fallback on this case.
        gettext("all events")
    end
  end

  @doc """
  Auxiliar function to get the atoms of registered places (and :all if
  `include_all` is true).
  """
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

  @doc """
  Auxiliar function to get the list of tuples of refistered places (and :all if
  `include_all` is true) for select boxes.
  """
  def get_places_for_select(include_all \\ false) do
    get_places(include_all)
    |> Enum.map(fn p ->
      {get_place_name(p), p}
    end)
  end

  @doc """
  Auxiliar function to get the human name of a palce given it's atom.
  """
  def get_place_name(event_place) do
    @event_place_names
    |> Map.get(event_place)
  end

  def format_description(text) do
    String.replace(text, "\n", "<br />")
  end
end
