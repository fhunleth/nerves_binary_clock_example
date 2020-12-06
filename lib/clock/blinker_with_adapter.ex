defmodule Clock.BlinkerWithAdapter do
  alias Clock.LEDAdapter

  def open(pin) do
    adapter = Application.get_env(:clock, :led_adapter)
    LEDAdapter.open(adapter, pin)
  end

  def sleep(led, wait) do
    Process.sleep(wait)
    led
  end

  def blink(led, wait) do
    led
    |> LEDAdapter.on()
    |> sleep(wait)
    |> LEDAdapter.off()
    |> sleep(wait)
  end

  def blink_times(led, 0, _wait) do
    led
  end

  def blink_times(led, times, wait) do
    # Bruce - I didn't know the elegant way of doing this with Streams like the original code.

    led
    |> blink(wait)
    |> blink_times(times - 1, wait)
  end
end
