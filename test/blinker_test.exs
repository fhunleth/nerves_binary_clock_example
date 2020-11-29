defmodule LEDTest do
  use ExUnit.Case
  alias Clock.LED

  test "Turns lights on and off" do
    26
    |> LED.open
    |> LED.off()
    |> assert_led_value(0)
    |> LED.on()
    |> assert_led_value(1)
    |> LED.off()
    |> assert_led_value(0)
  end
  
  def assert_led_value(led, actual) do
    expected = Circuits.GPIO.read(led)
    assert expected == actual
    led
  end
  
end
