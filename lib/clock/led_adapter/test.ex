# Frank, do you think we need a protocol here?
defmodule Clock.LEDAdapter.Test do
  defstruct pin: 0, lit: false, history: []

  # constructor
  def open(pin) do
    %__MODULE__{pin: pin, lit: false, history: [:open]}
  end

  # reducer
  def on(led) do
    %{led | lit: true, history: [:on | led.history]}
  end

  # reducer
  def off(led) do
    %{led | lit: false, history: [:off | led.history]}
  end
end
