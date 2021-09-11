defmodule Holodex.Model.Video do
  @moduledoc false

  @typedoc """
  `Video` resource type definition. A map of atom keys and mstly UTF-8 binary values. Can optionally contain a `channel` bare map.
  """
  @type t() :: %{
          id: String.t(),
          title: String.t(),
          type: String.t(),
          topic_id: String.t(),
          published_at: String.t(),
          available_at: String.t(),
          duration: pos_integer(),
          status: String.t(),
          start_scheduled: String.t(),
          start_actual: String.t(),
          end_actual: String.t(),
          live_viewers: pos_integer(),
          description: String.t(),
          songcount: pos_integer(),
          channel_id: String.t(),
          channel:
            %{
              id: String.t(),
              name: String.t(),
              english_name: String.t(),
              type: String.t(),
              photo: String.t()
            }
            | nil
        }
end
