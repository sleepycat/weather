defmodule FakeHTTPClient do
  @behaviour HTTPClient
  def get _url do
    {:ok, file_content} = File.read("./test/data/weather.json")
    file_content
  end
end

defmodule WeatherTest do
  use ExUnit.Case

  test "returns a map of details for a given city" do
      forecast = Weather.in_city("Ottawa", FakeHTTPClient)
      assert %{high: 3.544, low: 3.544, city: "Ottawa", description: "broken clouds"} = forecast
  end

  test "creates a summary map of a response" do
    parsed_json =
    Poison.Parser.parse!(File.read!(Path.expand("./test/data/weather.json")))
    assert %{high: _, low: _, city: _, description: _} = Weather.summary_map parsed_json
  end

  test "produces json from a string" do
    raw_json = File.read! Path.expand("./test/data/weather.json")
    data = Weather.parse_response(raw_json)
    weather_id = data["id"]
    assert weather_id = 6094817
  end

end
