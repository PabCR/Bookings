defmodule ApiDisplay.API.Caller do
  @moduledoc """
  Documentation for `Caller`.
  """
  def get_bookings(url_domain) do
    base_url = System.get_env("TEST_API_URL")
    url = "#{base_url}#{url_domain}"
    token = System.get_env("TEST_API_TOKEN")
    headers = [{"Authorization", "Bearer #{token}"}]

    case HTTPoison.request(:post, url, "", headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body |> Jason.decode!()}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:not_found, "Not found"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
