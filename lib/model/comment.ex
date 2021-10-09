defmodule Holodex.Model.Comment do
  @moduledoc false

  defstruct [:comment_key, :video_id, :message]

  @typedoc """
  `Comment` resource type definition.
  """
  @type t() :: %__MODULE__{
          comment_key: String.t(),
          video_id: String.t(),
          message: String.t()
        }
end
