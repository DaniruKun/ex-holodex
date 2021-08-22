defmodule HolodexTest do
  use ExUnit.Case
  doctest Holodex

  test "greets the world" do
    assert Holodex.hello() == :world
  end
end
