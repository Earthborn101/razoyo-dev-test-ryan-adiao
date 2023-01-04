defmodule Razoyo.API.Cars do
  @moduledoc """
  The cars api context.
  """

  @url "https://dev-test-frontend-werpwe2p3q-uc.a.run.app/cars"

  @doc """
  Fetch list of cars

  ## Examples

    iex> list_cars(%{})
    %{
      makes: ["Honda", "Toyota", "Ford"],
      cars: [%{"make" => "Honda"}],
      token: "sampleToken"
    }
  """
  def list_cars(filter) do
    {:ok, response} = HTTPoison.get(set_filter_url(@url, filter), [], [])
    {:ok, body} = Poison.decode(response.body)
    {_, token} = fetch_token(response.headers)

    %{
      makes: body["allMakes"],
      cars: body["cars"],
      token: token
    }
  end

  defp set_filter_url(url, %{make: make}) do
    "#{url}?make=#{make}"
  end

  defp set_filter_url(url, _), do: url

  defp fetch_token(headers) do
    Enum.filter(headers, fn {header, _} -> header == "your-token" end)
    |> List.first()
  end

  @doc """
  Fetch car info

  ## Examples

    iex> get_car("1", "sample_token")
    %{"id" => "1", "make" => "Honda"}
  """
  def get_car(id, token) do
    {:ok, response} =
      HTTPoison.get(
        "#{@url}/#{id}",
        [Authorization: "#{token}", "Content-Type": "application/json"],
        []
      )

    {:ok, body} = Poison.decode(response.body)

    body
  end

  defp set_filter_url(url, %{make: make}) do
    "#{url}?make=#{make}"
  end

  defp set_filter_url(url, _), do: url

  defp fetch_token(headers) do
    Enum.filter(headers, fn {header, _} -> header == "your-token" end)
    |> List.first()
  end
end
