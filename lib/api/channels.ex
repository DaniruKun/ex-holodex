defmodule Holodex.Api.Channels do
  @moduledoc """
  Holodex `Channel` resource API module.

  Includes client functions for interacting with the `Channel` resource.
  """

  alias Holodex.Api.Client
  alias Holodex.Model.Channel

  @type opts() ::
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

  @doc """
  Get all channels from Holodex, optionally with given parameters.

  Raises an exception in case of failure.
  """
  @spec list_channels!(opts()) :: [Channel.t()] | no_return()
  def list_channels!(opts \\ %{}) do
    with url <- build_channels_url(opts),
         response <- Client.get!(url) do
      Poison.decode!(response.body, %{as: [%Channel{}]})
    end
  end

  @doc """
  Get all channels from Holodex, optionally with given parameters.

  Returns a tuple containing the response body or an error.
  """
  @spec list_channels(opts()) ::
          {:ok, [Channel.t()]} | {:error, HTTPoison.Error.t()} | {:error, Exception.t()}
  def list_channels(opts \\ %{}) do
    with url <- build_channels_url(opts),
         {:ok, response} <- Client.get(url),
         {:ok, decoded} <- Poison.decode(response.body, %{as: [%Channel{}], keys: :atoms!}) do
      {:ok, decoded}
    end
  end

  @doc """
  Get info about a particular channel by its Youtube channel ID.

  Raises an exception in case of failure.
  """
  @spec get_channel!(String.t()) :: Channel.t() | no_return()
  def get_channel!(channel_id) do
    with response <- Client.get!("/channels/#{channel_id}") do
      Poison.decode!(response.body, %{as: %Channel{}})
    end
  end

  @doc """
  Get info about a particular channel by its Youtube channel ID.

  Returns a tuple containing the channel info or an error.
  """
  @spec get_channel(String.t()) ::
          {:ok, Channel.t()} | {:error, HTTPoison.Error.t()} | {:error, Exception.t()}
  def get_channel(channel_id) do
    with {:ok, response} <- Client.get("/channels/#{channel_id}"),
         {:ok, decoded} <- Poison.decode(response.body, %{as: %Channel{}, keys: :atoms!}) do
      {:ok, decoded}
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
