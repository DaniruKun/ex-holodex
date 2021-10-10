defmodule Holodex.Api.Client do
  @moduledoc """
  The main Holodex API client module.

  Wraps the Holodex REST API and provides additional helper client functions.

  Should be used only if the resource APIs are not sufficient, or for extending the library.

  Example:
      iex> Holodex.Api.Client.get!("/channels?org=Hololive").body |> Enum.at(0)
      "[{\"id\":\"UC0TXe_LYZ4scaW2XMyi5_kw\",\"name\":\"AZKi Channel\", ..."

  """
  use HTTPoison.Base

  @api_version "v2"
  @api_base_url "https://holodex.net/api/#{@api_version}"

  @impl true
  def process_request_url(url) do
    @api_base_url <> url
  end

  @impl true
  def process_request_headers(headers) do
    api_key = Holodex.Config.api_token()
    headers ++ [{"X-APIKEY", api_key}]
  end
end
