defmodule Mango.Area.ResidenceService do
  require HTTPoison
  @moduledoc false

  def list_areas do
    ["api_key": api_key] = Application.get_env(:mango, Mango.Area.ResidenceService)
    url = "https://battuta.medunes.net/api/city/us/search/?region=oklahoma&key=#{api_key}"
    response = HTTPoison.get url
    case response do
      {:ok, response_struct} ->
        Poison.decode!(response_struct.body)
        |> get_areas_list()
      {:error, _} ->
        ['unable to get area list']
    end
  end

  def get_areas_list(result) do
    Enum.map(result, fn(%{"city"=> city}) ->
      city
    end)
  end
end
