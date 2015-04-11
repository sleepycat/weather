defmodule FakeHTTPClient do
  @behaviour HTTPClient
  def get _url do
    {:ok, file_content} = File.read("./test/data/weather.json")
    file_content
  end
end

defmodule WeatherTest do
  use ExUnit.Case

  setup do
    {:ok, response_data: File.read!(Path.expand("./test/data/weather.json"))}
  end

  test "returns a map of details for a given city" do
      forecast = Weather.in_city("Ottawa", FakeHTTPClient)
      assert %{high: 3.544, low: 3.544, city: "Ottawa", description: "broken clouds"} = forecast
  end

  test "creates a summary map of a response", context do
    parsed_json =
    Poison.Parser.parse!(context[:response_data])
    assert %{high: _, low: _, city: _, description: _} = Weather.summary_map parsed_json
  end

  test "produces json from a string", context do
    data = Weather.parse_response(context[:response_data])
    weather_id = data["id"]
    assert weather_id = 6094817
  end

end
