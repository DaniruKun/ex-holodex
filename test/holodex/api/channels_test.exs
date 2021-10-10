defmodule Holodex.Api.ChannelsTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Holodex.Api.Channels
  alias Holodex.Model.Channel

  @amelia_watson_channel_id "UCyl1z3jo3XHR1riLFKG5UAg"

  setup do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  setup_all do
    HTTPoison.start()
    :ok
  end

  describe "list_channels" do
    test "list_channels! with no options returns list of channels" do
      use_cassette("list_channels") do
        [head | _] = result = Channels.list_channels!()
        assert is_list(result)
        assert is_struct(head, Channel)
        assert is_binary(head.name)
      end
    end

    test "list_channels with no options returns list of channels" do
      use_cassette("list_channels") do
        {:ok, result} = Channels.list_channels()
        [head | _] = result
        assert is_list(result)
        assert is_struct(head, Channel)
        assert is_binary(head.name)
      end
    end

    test "list_channels! with limit, org returns expected channels" do
      use_cassette("list_channels_hololive_en_10") do
        [head | _] = result = Channels.list_channels!(%{limit: 10, org: "Hololive", lang: "en"})
        assert is_list(result)
        assert length(result) <= 10
        assert is_struct(head, Channel)
        assert head.org == "Hololive"
      end
    end

    test "list_channels with limit, org returns expected channels" do
      use_cassette("list_channels_hololive_en_10") do
        {:ok, result} = Channels.list_channels(%{limit: 10, org: "Hololive", lang: "en"})
        [head | _] = result
        assert is_list(result)
        assert length(result) <= 10
        assert is_struct(head, Channel)
        assert head.org == "Hololive"
      end
    end
  end

  describe "get_channel" do
    test "get_channel! returns a channel" do
      use_cassette("get_channel") do
        result = Channels.get_channel!(@amelia_watson_channel_id)
        assert is_struct(result, Channel)
        assert result.name =~ "Amelia"
        assert result.org == "Hololive"
        assert result.type == "vtuber"
      end
    end

    test "get_channel returns a channel" do
      use_cassette("get_channel") do
        {:ok, result} = Channels.get_channel(@amelia_watson_channel_id)
        assert is_struct(result, Channel)
        assert result.name =~ "Amelia"
        assert result.org == "Hololive"
        assert result.type == "vtuber"
      end
    end
  end
end
