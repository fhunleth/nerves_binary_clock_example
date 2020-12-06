defmodule Clock.LEDAdapter.Dev do
  @behaviour Clock.LEDAdapter

  defstruct pin: 0, lit: false

  # constructor
  @impl Clock.LEDAdapter
  def open(pin) do
    IO.puts("Opening: #{pin}")
    %__MODULE__{pin: pin, lit: false}
  end

  # reducer with side effect
  @impl Clock.LEDAdapter
  def on(led) do
    IO.puts("On: #{led.pin}")
    %{led | lit: true}
  end

  # reducer with side effect
  @impl Clock.LEDAdapter
  def off(led) do
    IO.puts("Off: #{led.pin}")
    %{led | lit: false}
  end
end
