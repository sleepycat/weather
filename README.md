Weather
=======

This is a toy application I made to get a feel for working with Elixir.

It hits the
[openweathermap.org](http://api.openweathermap.org/data/2.5/weather?units=metric&q=Ottawa) API and returns a map that summarizes the current weather.

```elixir
iex(1)> Weather.in_city "Montreal"
%{city: "Montreal", description: "light rain", high: 4.799, low: 4.799}
```


