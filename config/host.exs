import Config

config :clock,
  led_adapter: Clock.LEDAdapter.Dev,
  pins: %{0 => 0, 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5}
