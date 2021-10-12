# Holodex

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Holodex](#holodex)
    - [Installation](#installation)
    - [Configuration](#configuration)
    - [Usage](#usage)
    - [Examples](#examples)

<!-- markdown-toc end -->


[![Elixir CI](https://github.com/DaniruKun/ex-holodex/actions/workflows/ci.yml/badge.svg)](https://github.com/DaniruKun/ex-holodex/actions/workflows/ci.yml)
[![Hex pm](https://img.shields.io/hexpm/v/holodex.svg)](https://hex.pm/packages/holodex)

An Elixir client library for the [Holodex API](https://holodex.stoplight.io).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `holodex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:holodex, "~> 0.1.0"}
  ]
end
```

## Configuration

In `config/config.exs`, configure your API token:

```elixir
config :holodex,
  api_token: "your-token-here"
```

## Usage

[API Docs](https://hexdocs.pm/holodex/)

Interactions with the API are split by the resource name as a "child" of the [Holodex.Api](./lib/api) namespace.

For example, to fetch information about `channels`, you would use functions from the [Holodex.Api.Channels](./lib/api/channels.ex) module.

They will return Elixir structs of the corresponding models defined in [Holodex.Models](./lib/model).

## Examples

Fetch information about a single channel

```elixir
iex(2)> Holodex.Api.Channels.get_channel! "UCyl1z3jo3XHR1riLFKG5UAg"
%Holodex.Model.Channel{
  banner: "https://yt3.ggpht.com/-7bdk5QyCEcy8DcCAwxFqjA3VX1WnMJKFg6mhVCqnL6z4S0boWQ1JkIgyCGXN8amRnYdQNkn",
  clip_count: 4180,
  description: "She heard strange rumors surrounding Hololive online: talking foxes, magical squirrels, superhuman dogs, and more. Soon after beginning her investigation on Hololive, and just out of interest, she decided to become an idol herself! She loves to pass her time training her reflexes with FPS games, and challenging herself with puzzle games.\nIt's elementary, right?\n\nFor Inquiries\nCover Corp: http://cover-corp.com/\nOfficial Twitter: https://twitter.com/hololive_En",
  english_name: "Watson Amelia",
  id: "UCyl1z3jo3XHR1riLFKG5UAg",
  inactive: false,
  lang: nil,
  name: "Watson Amelia Ch. hololive-EN",
  org: "Hololive",
  photo: "https://yt3.ggpht.com/ytc/AKedOLTvS-8gomaJywaEKp3hnCmY92vQ9uKpy8rMAx3a=s800-c-k-c0x00ffffff-no-rj",
  published_at: "2020-07-16T06:24:42.283Z",
  suborg: "h English (Myth)",
  subscriber_count: "1470000",
  twitter: "watsonameliaen",
  type: "vtuber",
  video_count: "394",
  view_count: "90537151"
}
```

List videos using a filter:

```elixir
iex> Holodex.Api.Videos.list_videos!(%{channel_id: "UCmbs8T6MWqUHP1tIQvSgKrg", status: "past"})
[
  %Holodex.Model.Video{
    available_at: "2021-08-26T04:00:28.000Z",
    channel: %Holodex.Model.Channel{
      banner: nil,
      clip_count: nil,
      comments_crawled_at: nil,
      crawled_at: nil,
      created_at: nil,
      description: nil,
      english_name: "Ouro Kronii",
      id: "UCmbs8T6MWqUHP1tIQvSgKrg",
      inactive: nil,
      lang: nil,
      name: "Ouro Kronii Ch. hololive-EN",
      org: "Hololive",
      photo: "https://yt3.ggpht.com/6670YE31bbAtAi7m_UL-KWZBdL5wvmfHlLtcS4HxsBZBQNqmAk7Y-iiIOjawO_0HYXpS4HfC=s800-c-k-c0x00ffffff-no-rj",
      published_at: nil,
      suborg: nil,
      subscriber_count: nil,
      thumbnail: nil,
      top_topics: nil,
      twitter: nil,
      type: "vtuber",
      updated_at: nil,
      video_count: nil,
      view_count: nil,
      ...
    },
    channel_id: nil,
    clips: nil,
    comments: nil,
    description: nil,
    duration: 9276,
    end_actual: nil,
    id: "fVSA8ctBj0I",
    live_tl_count: %Holodex.Model.Video.LiveTLCount{
      en: nil,
      es: 27,
      ja: nil,
      ko: 14,
      ru: nil
    },
    live_viewers: nil,
    mentions: nil,
    published_at: "2021-08-26T06:54:03.000Z",
    recommendations: nil,
    refers: nil,
    simulcasts: nil,
    songcount: nil,
    songs: nil,
    sources: nil,
    start_actual: nil,
    start_scheduled: nil,
    status: "past",
    title: "【Frostpunk】Get To Work | #1",
    topic_id: nil,
    type: "stream"
  },
  ...
]
```
