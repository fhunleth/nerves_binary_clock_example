defmodule Clock.LEDAdapter.Embedded do
  @behaviour Clock.LEDAdapter
  alias Circuits.GPIO

  # constructor
  @impl Clock.LEDAdapter
  def open(pin) do
    {:ok, led} = GPIO.open(pin, :output)
    led
  end

  # reducer with side effect
  @impl Clock.LEDAdapter
  def on(led) do
    GPIO.write(led, 1)
    led
  end

  # reducer with side effect
  @impl Clock.LEDAdapter
  def off(led) do
    GPIO.write(led, 0)
    led
  end
end
