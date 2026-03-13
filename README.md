# ZMK Firmware Config

Personal [ZMK](https://zmk.dev/) firmware configuration for my keyboards.

## Keyboards

| Keyboard | Type | Board | Notes |
|----------|------|-------|-------|
| Arch36 | Split, 36-key | nice_nano | Custom shield (defined in `boards/shields/arch36/`) |
| Waterfowl | Split, 36-key + 4 encoders | nice_nano | Upstream shield |
| Corneish Zen | Split, 36-key, e-ink display | Integrated | Upstream board |
| BT60 | 60%, single piece | Integrated | Upstream board |

The three 36-key split keyboards share a common Miryoku-style base layout
(`config/common/base_36.keymap`) with home row mods, layer-taps on thumbs,
and 8 layers (DEFAULT, MEDIA, NAV, MOUSE, SYM, NUM, FUN, GAME).

## Project Structure

```
config/
  common/               # Shared across all 36-key keyboards
    base_36.keymap      # Common Miryoku layout (8 layers)
    combos.dtsi         # Bracket pairs, caps_word, game toggle
    encoders.dtsi       # Encoder behaviors (volume, zoom, scroll)
    home_row_mods.dtsi  # Hold-tap behavior definition
    layers.h            # Layer index definitions
  <keyboard>.keymap     # Per-keyboard keymap (includes common or standalone)
  <keyboard>.conf       # Per-keyboard Kconfig
  west.yml              # ZMK manifest (tracks zmk main branch)
boards/shields/arch36/  # Custom shield hardware definition
build.yaml              # Build matrix for CI and local builds
build                   # Local build script (wraps act)
.github/workflows/      # CI workflow (upstream reusable)
```

## Building

### CI

Firmware is built automatically on push via GitHub Actions using
[ZMK's reusable workflow](https://github.com/zmkfirmware/zmk/blob/main/.github/workflows/build-user-config.yml).
Artifacts are uploaded as a `firmware` bundle.

### Local

Local builds use [act](https://github.com/nektos/act) to run the same
GitHub Action locally. Requires act and a container runtime (Docker or Podman).

```sh
./build
```

Firmware files are output to `firmware/`:

```
firmware/arch36_left-nice_nano.uf2
firmware/arch36_right-nice_nano.uf2
firmware/waterfowl_left-nice_nano.uf2
firmware/waterfowl_right-nice_nano.uf2
firmware/bt60.uf2
firmware/corneish_zen_left.uf2
firmware/corneish_zen_right.uf2
```

## Other Keyboards

The `via/` directory contains configuration for the W70 keyboard, which uses
[VIA](https://usevia.app/) instead of ZMK. See `via/README.md` for details.

## Flashing

Copy the `.uf2` file to the keyboard's USB mass storage device:

1. Put the keyboard into bootloader mode (double-tap reset button)
2. Copy the `.uf2` file to the mounted drive
3. The keyboard reboots automatically

For split keyboards, flash both halves.
