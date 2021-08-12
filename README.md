# ZMK Configuration

This repo allows building of ZMK firmware using a `Dockerfile` and a `Makefile`.

## Organization of Board Configurations

All configurations for keyboards lives in the `boards/` directory.
For cleanliness, each distinct keyboard has it's own subdirectory, with relevant files located inside.

## Placement of Board Configurations in Docker Image

As ZMK is a bit particular about where configuration files are, based on if it's a pre-existing board, a non-existing board, or a shield, the location of these files are placed into the correct location by the `Dockerfile`.

## Build Scripts

Since each keyboard may invoke `west build` differently, each has it's own `build_${BOARD}` script in the `scripts/` directory.

## Building Firmwawre

To actually build the firmware, simply call `make BOARD=${BOARD}`. This will build the Docker image, and then execute the  correct `build_${BOARD}` script, and output the firmware to a local `build/` directory.
