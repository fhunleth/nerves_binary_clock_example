defmodule ServerTest do
  use ExUnit.Case

  test "ticks" do
    config = %{
      led_adapter: Clock.LEDAdapter.Test,
      pins: %{0 => 0, 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5},
      time: 0,
      send_ticks_fn: fn -> :ok end
    }

    {:ok, server} = start_supervised({Clock.Server, config})

    initial_state = :sys.get_state(server)
    assert initial_state.time == 0

    send(server, :tick)

    next_state = :sys.get_state(server)
    assert next_state.time == 1
  end
end
