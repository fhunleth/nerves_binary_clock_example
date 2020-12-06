# Frank, do you think we need a protocol here?
defmodule Clock.LEDAdapter.Embedded do
  alias Circuits.GPIO

  # constructor
  def open(pin) do
    {:ok, led} = GPIO.open(pin, :output)
    led
  end

  # reducer with side effect
  def on(led) do
    GPIO.write(led, 1)
    led
  end

  # reducer with side effect
  def off(led) do
    GPIO.write(led, 0)
    led
  end
end
