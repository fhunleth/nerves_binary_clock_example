# Frank, do you think we need a protocol here?
defmodule Clock.LEDAdapter.Dev do
  defstruct pin: 0, lit: false

  # constructor
  def open(pin) do
    IO.puts("Opening: #{pin}")
    %__MODULE__{pin: pin, lit: false}
  end

  # reducer with side effect
  def on(led) do
    IO.puts("On: #{led.pin}")
    %{led | lit: true}
  end

  # reducer with side effect
  def off(led) do
    IO.puts("Off: #{led.pin}")
    %{led | lit: false}
  end
end
