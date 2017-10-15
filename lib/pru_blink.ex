defmodule PruBlink do
    use Application
    require Pru
    require Logger

    def start(_type, _args) do
        Logger.info "Init pin overlay"
        Pru.init_pins
        Logger.info "Set P8_11 pin to pruout"
        Pru.pin_out 'P8_11'
        {:ok, self()}
    end
end
