defmodule ClockTest do
  use ExUnit.Case
  

  test "Doesn't time out" do
    task = Clock.async_blink(1, 2, 1)
    assert Task.await(task) == :ok
  end
  
end
