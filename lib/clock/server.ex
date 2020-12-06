defmodule Clock.Server do
  use GenServer
  alias Clock.{LEDAdapter, Core}

  # GenServer API
  def start_link(initial_state \\ default_options()) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  # GenServer callbacks
  @impl true
  def init(args) do
    pins = args[:pins]
    time = args[:time] || default_time()
    send_ticks_fn = args[:send_ticks_fn] || (&default_send_ticks/0)
    led_adapter = args[:led_adapter]

    send_ticks_fn.()
    {:ok, Core.new(open_gpio_pins(led_adapter, pins), time)}
  end

  @impl true
  def handle_info(:tick, clock) do
    {:noreply, clock |> Core.tick() |> set_leds()}
  end

  def default_pins, do: %{0 => 26, 1 => 13, 2 => 6, 3 => 5, 4 => 16, 5 => 12}
  def default_time, do: Time.utc_now().second
  def default_send_ticks, do: :timer.send_interval(200, :tick)

  def default_options do
    %{pins: default_pins(), time: default_time(), send_ticks_fn: &default_send_ticks/0}
  end

  # Support for for hardware
  def open_gpio_pins(led_adapter, pins) do
    0..5
    |> Enum.map(fn bit ->
      {bit, LEDAdapter.open(led_adapter, pins[bit])}
    end)
    |> Map.new()
  end

  def set_leds(clock) do
    Enum.each(Core.status(clock), &toggle/1)
    clock
  end

  defp toggle({led, true}), do: LEDAdapter.on(led)
  defp toggle({led, false}), do: LEDAdapter.off(led)
end
