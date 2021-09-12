defmodule Holodex.Model.Channel do
  @moduledoc false

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
          banner: String.t() | nil,
          twitter: String.t() | nil,
          video_count: String.t() | nil,
          subscriber_count: String.t() | nil,
          view_count: String.t() | nil,
          clip_count: String.t() | nil,
          lang: String.t() | nil,
          published_at: String.t() | nil,
          inactive: boolean() | nil,
          description: String.t() | nil
        }
end
