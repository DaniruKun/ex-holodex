defmodule Holodex.Model.Channel do
  @moduledoc false

  defstruct [
    :id,
    :name,
    :english_name,
    :type,
    :org,
    :suborg,
    :photo,
    :thumbnail,
    :banner,
    :twitter,
    :video_count,
    :subscriber_count,
    :comments_crawled_at,
    :updated_at,
    :yt_uploads_id,
    :crawled_at,
    :view_count,
    :clip_count,
    :top_topics,
    :lang,
    :published_at,
    :inactive,
    :created_at,
    :description
  ]

  @typedoc """
  `Channel` resource type definition. A map of atom keys and mostly UTF-8 binary values.
  """
  @type t() :: %{
          id: String.t(),
          name: String.t(),
          english_name: String.t(),
          type: String.t(),
          org: String.t() | nil,
          suborg: String.t() | nil,
          photo: String.t(),
          thumbnail: String.t() | nil,
          banner: String.t() | nil,
          twitter: String.t() | nil,
          video_count: String.t() | nil,
          subscriber_count: String.t() | nil,
          comments_crawled_at: String.t() | nil,
          updated_at: String.t() | nil,
          yt_uploads_id: String.t() | nil,
          crawled_at: String.t() | nil,
          view_count: String.t() | nil,
          clip_count: String.t() | nil,
          top_topics: [String.t()] | [] | nil,
          lang: String.t() | nil,
          published_at: String.t() | nil,
          inactive: boolean() | nil,
          created_at: String.t() | nil,
          description: String.t() | nil
        }
end
