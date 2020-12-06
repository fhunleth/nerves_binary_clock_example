defmodule Clock.Server do
  use GenServer
  alias Clock.BlinkerWithAdapter, as: Blinker
  alias Clock.Core
  
  # GenServer API
  def start_link(initial_state \\ default_options()) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end
  
  def tick() do
    send(__MODULE__, :tick)
  end
  
  # GenServer callbacks
  @impl true
  def init({pins, time, send_ticks_fn}) do
    send_ticks_fn.()
    {:ok, Core.new(open_gpio_pins(pins), time)}
  end
    
  @impl true
  def handle_info(:tick, clock) do    
    {:noreply, clock |> Core.tick |> set_leds}
  end
  
  def default_options do
    {
      Application.get_env(:clock, :pins), 
      Time.utc_now().second, 
      fn -> :timer.send_interval(1000, :tick) end
    }
  end
      
  # Support for for hardware
  def open_gpio_pins(pins) do
    0..5
    |> Enum.map(fn bit -> 
      {bit, Blinker.adapter.open(pins[bit])} 
    end)
    |> Map.new
  end
  
  def set_leds(clock) do
    Enum.each(Core.status(clock), &toggle/1)
    clock
  end
  defp toggle({led, true}), do: Blinker.adapter.on(led)
  defp toggle({led, false}), do: Blinker.adapter.off(led)
end
