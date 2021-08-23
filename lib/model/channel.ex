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
          org: String.t(),
          suborg: String.t(),
          photo: String.t(),
          banner: String.t(),
          twitter: String.t(),
          video_count: String.t(),
          subscriber_count: String.t(),
          view_count: String.t(),
          clip_count: String.t(),
          lang: String.t(),
          published_at: String.t(),
          inactive: boolean(),
          description: String.t()
        }
end
