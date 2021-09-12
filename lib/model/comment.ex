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

  @spec build(%{
          (comment_key :: String.t()) => String.t(),
          (video_id :: String.t()) => String.t(),
          (message :: String.t()) => String.t()
        }) :: __MODULE__.t()
  def build(map) do
    %__MODULE__{
      comment_key: map["comment_key"],
      video_id: map["video_id"],
      message: map["message"]
    }
  end
end
