defmodule LiveViewWeather.Services.BingApi do

  def token do
    System.get_env("BING_API_KEY")
  end

  def get_coords do
    url = "http://dev.virtualearth.net/REST/v1/Locations?key=#{token()}&locality=denver&adminDistrict=colorado"
    # {:ok, response} = HTTPoison.get(url)
    # {:ok, response} = Poison.decode(response.body)
    # IO.inspect(response)
    # data = response["resourceSets"]
    # |> Enum.at(0)

    # data = data["resources"]
    # |> Enum.at(0)

    # data = data["geocodePoints"]
    # |> Enum.at(0)

    # data["coordinates"]

# Cleaner Way To Handle Response, Kernel.get_in function needs atoms as certain args
    with {:ok, resp}    <- HTTPoison.get(url),
         {:ok, decoded} <- Poison.decode(resp.body),
        #  {:ok, decoded} <- Jason.Formatter.minimize(resp.body,),
      coords            <- get_in(decoded, ~w[resourceSets coordinates]) do
      coords
    end
  end



end
