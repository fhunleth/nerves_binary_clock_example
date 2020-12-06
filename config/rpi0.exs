import Config

config :clock,
  led_adapter: Clock.LEDAdapter.Embedded,
  pins: %{0 => 26, 1 => 13, 2 => 6, 3 => 5, 4 => 16, 5 => 12}
