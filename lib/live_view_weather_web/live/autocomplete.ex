defmodule AutocompleteResult do
  defstruct [:name, :coordinates]
end

defmodule LiveViewWeatherWeb.Autocomplete do
  use Phoenix.LiveView

  def render(assigns) do
    LiveViewWeatherWeb.PageView.render("autocomplete.html", assigns)
  end

  # def default_recommendation() do
  #   default = [%AutocompleteResult{name: "Boston, Ma", coordinates: [42.35866165161133, -71.0567398071289]}]

  #   default.coordinates
  # end

  def mount(_session, socket) do
    {:ok, assign(socket, q: nil, recommendations: [])}
  end

  def handle_event("autocomplete", value, socket) do
    q = String.trim(value["q"])
    {:noreply, assign(socket, recommendations: fetch_autocomplete(q))}
  end

  def handle_event("get_weather", value, socket) do
    IO.inspect(value, label: "Testing")
    {:noreply, assign(socket, recommendations: fetch_weather(value))}
  end

  def fetch_weather(value) do
    IO.inspect(value, label: "WOOOORD")
  end

  defp fetch_autocomplete(q) do
    case bing_cities(q) do
      # Possibly where we can create other call
      {:ok, cities} -> Enum.map(cities, fn city -> city.name  end)
      {:error, _message} -> []
    end
  end

  def bing_cities(q) do
    token = System.get_env("BING_API_KEY")
    url = URI.encode("http://dev.virtualearth.net/REST/v1/Locations?query=#{q}&key=#{token}")

    # Note to cache results from API call here
    with {:ok, resp} <- HTTPoison.get(url),
      # resp <- IO.inspect(resp, label: "RESP"),
      {:ok, decoded} <- Jason.decode(resp.body),
      {:ok, cities} <- extract_resource_sets(decoded) do
      {:ok, cities}
    else
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
      {:error, %Jason.DecodeError{data: data}} -> {:error, data}
      {:error, :no_results} -> {:error, "no_results"}
      message -> IO.inspect(message, label: "messsage")
    end
  end

  def extract_resource_sets(%{"resourceSets" => resource_sets}) do
    extracted_data = Enum.flat_map(resource_sets, &extract_resources_from_resource_set/1)
    case extracted_data do
      [] -> {:error, :no_results}
      _ -> {:ok, extracted_data}
    end
  end
  def extract_resource_sets(_params), do: []

  def extract_resources_from_resource_set(%{"resources" => resources}) do
    Enum.map(resources, &get_autocomplete_result/1)
  end
  def extract_resources_from_resource_set(_params), do: []

  def get_autocomplete_result(%{"name" => name, "point" => %{"coordinates" => coordinates}}) do
    %AutocompleteResult{name: name, coordinates: coordinates}
  end
  def get_autocomplete_result(_params), do: []
end
