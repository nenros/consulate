defmodule ConsulateTest do
  use ExUnit.Case
  doctest Consulate

  test "greets the world" do
    assert Consulate.hello() == :world
  end
end
