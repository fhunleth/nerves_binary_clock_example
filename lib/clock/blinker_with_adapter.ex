defmodule Clock.BlinkerWithAdapter do
  
  def sleep(wait) do
    Process.sleep(wait)
  end
  
  def blink(led, wait) do
    adapter().on(led)
    sleep(wait)
    adapter().off(led)
    sleep(wait)
  end
  
  def blink_times(led, times, wait) do
      fn -> blink(led, wait) end
      |> Stream.repeatedly
      |> Enum.take(times)
  end
  
  def adapter do
    Application.get_env(:clock, :led_adapter)
  end
end