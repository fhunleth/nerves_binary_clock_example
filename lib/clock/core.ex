defmodule Clock.Core do
  # LEDs in the form %{0..5 => ref}
  defstruct [:time, leds: %{}]

  # constructor
  def new(leds, time \\ Time.utc_now().second) do
    %__MODULE__{time: time, leds: leds}
  end

  # reducer
  def tick(clock) do
    %__MODULE__{clock | time: rem(clock.time + 1, 64)}
  end

  # converter
  def status(clock) do
    for bit <- 0..5,
        into: %{} do
      gpio_write_value = on?(clock.time, bit)
      {clock.leds[bit], gpio_write_value}
    end
  end

  defp on?(time, bit) do
    :math.pow(2, bit)
    |> round
    |> Bitwise.band(time)
    |> Kernel.>(0)
  end
end
