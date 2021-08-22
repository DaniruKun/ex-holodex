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

  @type client_resp :: HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()
  @type channel_opts() ::
          %{
            lang: binary() | nil,
            limit: 0..50 | nil,
            offset: integer() | nil,
            order: binary() | nil,
            org: binary() | nil,
            sort: binary() | nil,
            type: binary() | nil
          }
          | %{}

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
      body
    end
  end

  ### Public API

  @doc """
  Get all channels from Holodex, optionally with given parameters.

  Raises on error.
  """
  @spec listChannels!(channel_opts()) :: client_resp()
  def listChannels!(opts \\ %{}) do
    with url <- build_channels_url(opts) do
      Holodex.Api.Client.get!(url).body
    end
  end

  @doc """
  Get all channels from Holodex, optionally with given parameters.
  
  Returns a tuple containing the response body or an error.
  """
  @spec listChannels(channel_opts()) :: {:ok, list()} | {:error, HTTPoison.Error.t()}
  def listChannels(opts \\ %{}) do
    with url <- build_channels_url(opts),
         {:ok, response} <- Holodex.Api.Client.get(url) do
      {:ok, response.body}
    end
  end

  defp build_channels_url(opts) do
    query = URI.encode_query(opts)

    "/channels"
    |> URI.parse()
    |> Map.put(:query, query)
    |> URI.to_string()
  end
end
