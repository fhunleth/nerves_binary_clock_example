defmodule Clock.LEDAdapter.Test do
  @behaviour Clock.LEDAdapter
  defstruct pin: 0, lit: false, history: []

  # constructor
  @impl Clock.LEDAdapter
  def open(pin) do
    %__MODULE__{pin: pin, lit: false, history: [:open]}
  end

  # reducer
  @impl Clock.LEDAdapter
  def on(led) do
    %{led | lit: true, history: [:on | led.history]}
  end

  # reducer
  @impl Clock.LEDAdapter
  def off(led) do
    %{led | lit: false, history: [:off | led.history]}
  end
end
