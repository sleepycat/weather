defmodule HTTPClient do
  @moduledoc """
  # HTTPClient
  A decorator to isolate the HTTP library from the rest of the app.
  """
  use Behaviour

  @doc """
  # get
  makes a get request, returns the body
  """
  defcallback get(binary) :: binary
end

defmodule HTTP do
  @behaviour HTTPClient

  def get url do
    {:ok, 200, _headers, client} = :hackney.get url
    {:ok, response_body} = :hackney.body client
    response_body
  end
end
