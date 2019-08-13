# [LiveViewWeather](https://live-view-weather.herokuapp.com/)

## Contributors
- [Matt Levy](https://github.com/milevy1)
- [Melvin Cedeno](https://github.com/TheCraftedGem)

## Setup ENV Variables

Sign up for an API key at the following sites:
- [Bing Maps](https://docs.microsoft.com/en-us/bingmaps/rest-services/locations/find-a-location-by-query)
- [DarkSky](https://darksky.net/dev) 

1. Create `.env` file in the root of your project with this syntax for your keys:

```
export BING_API_KEY="insert-key-here"
export DARK_SKY_API_KEY="insert-key-here"
```

2. In your terminal run `source .env`

## To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
