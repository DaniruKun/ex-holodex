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

  @impl true
  def process_response_body(body) do
    with {:ok, body} <- Jason.decode(body) do
      case is_map(body) do
        true ->
          keys_to_atoms(body)

        _ ->
          body |> Enum.map(&keys_to_atoms/1)
      end
    end
  end

  defp keys_to_atoms(key_vals) do
    Map.new(key_vals, fn {k, v} -> {String.to_existing_atom(k), v} end)
  end
end
