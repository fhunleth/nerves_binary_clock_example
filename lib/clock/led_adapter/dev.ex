# Frank, do you think we need a protocol here?
defmodule Clock.LEDAdapter.Dev do
  defstruct [pin: 0, lit: false]
  require Logger
  
  # constructor 
  def open(pin) do
    # in iex: RingLogger.attach
    # note about where IO.inspect goes. 
    Logger.info("Opening: #{pin}")
    %__MODULE__{pin: pin, lit: false}
  end
  
  # reducer with side effect
  def on(led) do
    Logger.info("On: #{led.pin}")
    %{led| lit: true}
  end
  
  # reducer with side effect
  def off(led) do
    Logger.info("Off: #{led.pin}")
    %{led| lit: false}
  end
end