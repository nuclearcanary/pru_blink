# PruBlink


## Targets

Can only be used on the BeagleBone Black.

## Hardware

  * BeagleBone Black/Green
  * LED
  * 470 ohm Resistor
  * Breadboard (Optional but makes things easier)


## Getting Started
This app has C code that needs a special compiler. Download the latest
[PRU Code Generation Tools v2.1.5](http://software-dl.ti.com/codegen/non-esd/downloads/download.htm#PRU).
Install and make note of the location, we will need that. Export that
location to the PRU_CGT environment variable.
On my Linux system it looks like this.
```
export PRU_CGT=/home/user/ti/ti-cgt-pru_2.1.5
```
On Windows
```
set PRU_CGT=C:/path/to/pru/code/gen/tools/ti-cgt-pru_2.1.5
```

Once that is set up clone the repo.
```
git clone https://github.com/nuclearcanary/pru_blink.git
cd pru_blink
```


### Compile the Nerves app
```
export MIX_TARGET=bbb  # Exports environment variable
mix deps.get           # Install dependencies
mix firmware           # Build firmware
mix firmware.burn      # Burn firmware to SD Card
```
### What just happened?
The `Makefile` in the root called the `Makefile` in `/pru/0`. The way `/pru/0/Makefile` is set up automatically copies the compiled firmware to the proper location.
`/pru/0` gets copied to `/rootfs_overlay/lib/firmware/am335x-pru0-fw`.
`/pru/1` gets copied to `/rootfs_overlay/lib/firmware/am335x-pru1-fw`.

### Wire the BeagleBone
![breadboard view](https://github.com/nuclearcanary/pru_blink/raw/master/assets/breadboard_view.png)

Insert SD Card into BeagleBone and boot. The first boot after burning the firmware takes about 30 seconds to start blinking the LED. Thereafter it will take about 70 seconds.

## TODO
  * Test with Windows, I currently do not own a Windows machine so help would be appreciated!
  * Figure out why the PRU boots in ~30 seconds first boot after burn, but all subsequent boots require ~70 seconds.

## Learn more
  * TI PRU Code Generation Tools: http://software-dl.ti.com/codegen/non-esd/downloads/download.htm#PRU
  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: http://www.nerves-project.org/
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves
