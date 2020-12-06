defmodule Clock.LEDAdapter do
  @type pin :: non_neg_integer()
  @type led_state() :: any()

  @callback open(pin()) :: led_state()
  @callback on(led_state()) :: led_state()
  @callback off(led_state()) :: led_state()

  def open(adapter, pin), do: {adapter, adapter.open(pin)}
  def on({adapter, led}), do: {adapter, adapter.on(led)}
  def off({adapter, led}), do: {adapter, adapter.off(led)}
end
