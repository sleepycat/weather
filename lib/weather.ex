defmodule Weather do

  def in_city city_name, http_client \\ HTTP do
    response_body = request(url_for(city_name), http_client)
    response = parse_response(response_body)
    summary_map response
  end

  def summary_map response do
    high = response["main"]["temp_max"]
    low = response["main"]["temp_min"]
    [desc] = response["weather"]
    city = response["name"]
    %{city: city, high: high, low: low, description: desc["description"]}
  end

  def parse_response response_body do
    Poison.Parser.parse!(response_body)
  end

  def request url, http_client do
    http_client.get url
  end

  defp url_for place do
    base_url <> place
  end

  defp base_url do
    "http://api.openweathermap.org/data/2.5/weather?units=metric&q="
  end

end
