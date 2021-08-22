defmodule Holodex.Api.Client do
  @moduledoc """
  The main Holodex API client module.
  """
  use HTTPoison.Base

  # @expected_fields ~w(total items)
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
    api_key = "37416592-50cc-437c-83a5-2ab3d08d96d0"
    headers ++ [{"X-APIKEY", api_key}]
  end

  @impl true
  def process_response_body(body) do
    body
    |> Jason.decode!()
  end

  @doc """
  Get all channels from Holodex, optionally with given parameters.
  """
  @spec listChannels!(channel_opts()) :: client_resp()
  def listChannels!(opts \\ %{}) do
    query = URI.encode_query(opts)

    url =
      "/channels"
      |> URI.parse()
      |> Map.put(:query, query)
      |> URI.to_string()

    Holodex.Api.Client.get!(url)
  end
end
