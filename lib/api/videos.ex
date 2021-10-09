defmodule Holodex.Api.Videos do
  @moduledoc """
  Holodex `Videos` resource API module.

  Includes client functions for interacting with the `Video` resource.
  """

  alias Holodex.Api.Client
  alias Holodex.Model.{Channel, Comment, Video}

  @type opts() ::
          %{
            channel_id: String.t() | nil,
            id: String.t() | nil,
            include: list(binary()) | String.t() | nil,
            lang: String.t() | nil,
            limit: pos_integer() | nil,
            max_upcoming_hours: number() | nil,
            mentioned_channel_id: String.t() | nil,
            offset: integer() | nil,
            order: String.t() | nil,
            org: String.t() | nil,
            paginated: String.t() | nil,
            sort: String.t() | nil,
            status: String.t() | nil,
            topic: String.t() | nil,
            type: String.t() | nil
          }
          | %{}

  @type single_opts() ::
          %{
            c: String.t() | nil,
            lang: String.t() | nil
          }
          | %{}

  @list_of_videos_p [
    %Video{
      clips: [%Video{}],
      sources: [%Video{}],
      refers: [%Video{}],
      simulcasts: [%Video{}],
      mentions: [%Channel{}]
    }
  ]

  @single_video_p %Video{
    clips: [%Video{}],
    sources: [%Video{}],
    refers: [%Video{}],
    simulcasts: [%Video{}],
    mentions: [%Channel{}],
    comments: [%Comment{}],
    recommendations: [%Video{}]
  }

  defdelegate fetch(video_id), to: __MODULE__, as: :video_info
  defdelegate fetch(video_id, opts), to: __MODULE__, as: :video_info
  defdelegate fetch!(video_id), to: __MODULE__, as: :video_info!
  defdelegate fetch!(video_id, opts), to: __MODULE__, as: :video_info!

  @doc """
  Query videos from Holodex, optionally with given parameters.

  Raises an exception in case of failure.
  """
  @spec list_videos!(opts()) :: [Video.t()] | no_return()
  def list_videos!(opts \\ %{}) do
    with url <- build_videos_url(opts),
         body <- Client.get!(url).body do
      Poison.decode!(body, %{as: @list_of_videos_p})
    end
  end

  @doc """
  Query videos from  Holodex, optionally with given parameters.

  Returns a tuple containing  the response body or an error.
  """
  @spec list_videos(opts()) ::
          {:ok, [Video.t()]} | {:error, HTTPoison.Error.t()} | {:error, Exception.t()}
  def list_videos(opts \\ %{}) do
    with url <- build_videos_url(opts),
         {:ok, response} <- Client.get(url),
         {:ok, decoded} <- Poison.decode(response.body, %{as: @list_of_videos_p}) do
      {:ok, decoded}
    end
  end

  @doc """
  Returns a single `Video`, optionally with comments and recommendations.

  Raises an exception in case of failure.
  """
  @spec video_info!(String.t(), single_opts()) :: Video.t()
  def video_info!(video_id, opts \\ %{}) do
    with url <- build_videos_url(opts, "/videos/#{video_id}"),
         response <- Client.get!(url) do
      Poison.decode!(response.body, %{as: @single_video_p})
    end
  end

  @doc """
  Returns a single `Video` in a tuple, optionally with  comments and recommendation.
  """
  @spec video_info(String.t(), single_opts()) ::
          {:ok, Video.t()} | {:error, HTTPoison.Error.t()} | {:error, Exception.t()}
  def video_info(video_id, opts \\ %{}) do
    with url <- build_videos_url(opts, "/videos/#{video_id}"),
         {:ok, response} <- Client.get(url),
         {:ok, decoded} <- Poison.decode(response.body, %{as: @single_video_p}) do
      {:ok, decoded}
    end
  end

  defp build_videos_url(opts, path \\ "/videos") do
    query =
      if Map.has_key?(opts, :include) && is_list(opts[:include]) do
        Map.merge(opts, %{include: Enum.join(opts[:include], ",")})
      else
        opts
      end
      |> URI.encode_query()

    path
    |> URI.parse()
    |> Map.put(:query, query)
    |> URI.to_string()
  end
end
