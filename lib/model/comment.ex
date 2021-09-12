defmodule Holodex.Model.Comment do
  @moduledoc false

  @typedoc """
  `Comment` resource type definition.
  """
  @type t() :: %{
          comment_key: String.t(),
          video_id: String.t(),
          message: String.t()
        }
end
