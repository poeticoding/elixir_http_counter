defmodule HttpCounterTest do
  use ExUnit.Case
  doctest HttpCounter

  test "greets the world" do
    assert HttpCounter.hello() == :world
  end
end
