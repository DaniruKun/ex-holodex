defmodule Holodex.Api.VideosTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Holodex.Api.Videos
  alias Holodex.Model.{Channel, Comment, Video}

  @kronii_channel_id "UCmbs8T6MWqUHP1tIQvSgKrg"

  setup do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  setup_all do
    HTTPoison.start()
    :ok
  end

  describe "list_videos filtered by channel, status and org" do
    test "list_videos! returns a list of videos matching the query" do
      use_cassette("list_videos_kronii_past") do
        [head | _] =
          result =
          Videos.list_videos!(%{channel_id: @kronii_channel_id, status: "past", org: "Hololive"})

        assert is_list(result)
        assert is_struct(head, Video)
        assert is_struct(head.channel, Channel)
        assert head.channel.name =~ "Kronii"
        assert head.type == "stream"
      end
    end

    test "list_videos returns a list of videos matching the query" do
      use_cassette("list_videos_kronii_past") do
        {:ok, result} =
          Videos.list_videos(%{channel_id: @kronii_channel_id, status: "past", org: "Hololive"})

        [head | _] = result

        assert is_list(result)
        assert is_struct(head, Video)
        assert is_struct(head.channel, Channel)
        assert head.channel.name =~ "Kronii"
        assert head.type == "stream"
      end
    end

    test "list_videos! returns only a single video when id option is passed" do
      use_cassette("list_videos_single") do
        [video] = result = Videos.list_videos!(%{id: "jJNGVn3g3_g"})

        assert is_list(result)
        assert is_struct(video, Video)
        assert is_struct(video.channel, Channel)
        assert video.channel.name =~ "Kiara"
        assert video.type == "stream"
      end
    end

    test "list_videos returns only a single video when id option is passed" do
      use_cassette("list_videos_single") do
        {:ok, result} = Videos.list_videos(%{id: "jJNGVn3g3_g"})

        [video] = result

        assert is_list(result)
        assert is_struct(video, Video)
        assert is_struct(video.channel, Channel)
        assert video.channel.name =~ "Kiara"
        assert video.type == "stream"
      end
    end
  end

  describe "video_info with comments" do
    test "video_info! returns a single video's info with comments when option enabled" do
      use_cassette("video_info_with_comments") do
        result = Videos.video_info!("fMK4GmM4WT8", %{c: 1})

        assert is_struct(result)
        assert is_list(result.comments)

        assert Enum.all?(result.comments, &valid_comment?/1)
      end
    end

    test "video_info returns a single video's info with comments when option enabled" do
      use_cassette("video_info_with_comments") do
        {:ok, result} = Videos.video_info("fMK4GmM4WT8", %{c: 1})

        assert is_struct(result)
        assert is_list(result.comments)

        assert Enum.all?(result.comments, &valid_comment?/1)
      end
    end
  end

  defp valid_comment?(comment) do
    is_struct(comment, Comment) && is_binary(comment.message)
  end
end
