defmodule LEDAdapterTest do
  use ExUnit.Case
  alias Clock.LEDAdapter

  test "Turns lights on and off" do
    LEDAdapter.open(LEDAdapter.Test, 26)
    |> LEDAdapter.off()
    |> assert_lit(false)
    |> LEDAdapter.on()
    |> assert_lit(true)
    |> LEDAdapter.off()
    |> assert_lit(false)
  end

  def assert_lit({LEDAdapter.Test, led_state} = led, expected) do
    assert led_state.lit == expected
    led
  end
end
