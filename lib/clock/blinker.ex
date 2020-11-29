defmodule Clock.Blinker do
  alias Clock.LED
  
  def sleep(wait) do
    LED.message("Sleep: #{wait}")
    Process.sleep(wait)
  end
  
  def blink(led, wait) do
    LED.on(led)
    sleep(wait)
    LED.off(led)
    sleep(wait)
  end
  
  def blink_times(led, times, wait) do
      fn -> blink(led, wait) end
      |> Stream.repeatedly
      |> Enum.take(times)
  end
end