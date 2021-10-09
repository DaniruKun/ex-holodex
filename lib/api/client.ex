defmodule Holodex.Api.Client do
  @moduledoc """
  The main Holodex API client module.

  Wraps the Holodex REST API and provides additional helper client functions.
  """
  use HTTPoison.Base

  @api_version "v2"
  @api_base_url "https://holodex.net/api/#{@api_version}"

  # Usage:
  # iex> Client.get!("/channels?org=Hololive").body |> Enum.at(0)

  @impl true
  def process_request_url(url) do
    @api_base_url <> url
  end

  @impl true
  def process_request_headers(headers) do
    # TODO: get from config instead
    api_key = ""
    headers ++ [{"X-APIKEY", api_key}]
  end
end
