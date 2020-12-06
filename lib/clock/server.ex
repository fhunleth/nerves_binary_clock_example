defmodule Clock.Server do
  use GenServer
  alias Clock.{LED, Core}

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
    {:noreply, clock |> Core.tick() |> set_leds}
  end

  # Support fns for callbacks
  # frank, what's the best way to configure this? 
  # needs a default for :host, and a configuration for the mix target
  def default_pins, do: %{0 => 26, 1 => 13, 2 => 6, 3 => 5, 4 => 16, 5 => 12}
  def default_time, do: Time.utc_now().second
  def default_send_ticks, do: :timer.send_interval(200, :tick)

  def default_options do
    {default_pins(), default_time(), &default_send_ticks/0}
  end

  # Support for for hardware
  def open_gpio_pins(pins) do
    0..5
    |> Enum.map(fn bit ->
      {bit, LED.open(pins[bit])}
    end)
    |> Map.new()
  end

  def set_leds(clock) do
    Enum.each(Core.status(clock), &toggle/1)
    clock
  end

  defp toggle({led, true}), do: LED.on(led)
  defp toggle({led, false}), do: LED.off(led)
end
