defmodule FipeApiTest do
  use ExUnit.Case
  doctest FipeApi

  test "greets the world" do
    assert FipeApi.hello() == :world
  end
end
