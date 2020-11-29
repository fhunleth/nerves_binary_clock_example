defmodule Clock.BlinkerWithAdapter do
  alias Clock.LEDAdapter
  
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
  
  # frank, how do we configure this? Maybe with target.exs and config.exs instead?
  def adapter do
    cond do
      Mix.env() == :test -> LEDAdapter.Test
      Mix.target() == :host -> LEDAdapter.Dev
      true -> LEDAdapter.Embedded
    end
  end
end