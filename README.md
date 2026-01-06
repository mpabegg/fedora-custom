# fedora-custom &nbsp; [![bluebuild build badge](https://github.com/mpabegg/fedora-custom/actions/workflows/build.yml/badge.svg)](https://github.com/mpabegg/fedora-custom/actions/workflows/build.yml)

Personal Fedora KDE Atomic image built with BlueBuild. The host stays lean and predictable, while development and tooling live in Distrobox.

Inspired by the uBlue ecosystem, especially Bazzite and WayBlue.

## Goals

- Clean host, minimal layering, predictable updates.
- KDE stock experience (Wayland default).
- Gaming via Flatpak, development via Distrobox.

## What is included

Base
- Fedora KDE Atomic (`kinoite-main`).
- Manual rpm-ostree rebase/rollback supported.

Host packages (RPM)
- `1password` + `1password-cli`
- `keyd` (Caps Lock to Esc via `default.conf`)
- `distrobox`
- `pavucontrol`, `qpwgraph` (audio routing tools)
- `steam-devices` (game device udev rules)

Homebrew
- Preinstalled via `ghcr.io/ublue-os/brew` with setup timers.
- PATH handling in `/etc/profile.d`.

Flatpaks (system)
- Browsers: Brave, Zen Browser
- Gaming: Steam, ProtonPlus
- Media: VLC
- Utilities: Flatseal, DistroShelf

Distrobox presets
- `/etc/distrobox/distrobox.ini` includes Fedora/Arch toolbox plus vanilla Fedora/Arch images.

## Out of scope (intentional)

- NVIDIA
- SteamOS/Deck mode (gamescope-session)
- Aggressive performance tuning
- Advanced audio tuning

## Updates

rpm-ostree
- Automatic checks enabled (`AutomaticUpdatePolicy=check`).
- Updates are notified but not auto-applied.

Flatpak
- Flathub enabled system-wide; Fedora remotes disabled.
- System and user Flatpak update timers enabled.

## Installation

> [!WARNING]
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/mpabegg/fedora-custom:latest
  ```
- Reboot:
  ```
  systemctl reboot
  ```
- Rebase to the signed image:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/mpabegg/fedora-custom:latest
  ```
- Reboot again:
  ```
  systemctl reboot
  ```

The `latest` tag always points to the latest build for the Fedora version specified in `recipes/recipe.yml`.

## ISO

If building on Fedora Atomic, you can generate an offline ISO with the instructions [here](https://blue-build.org/learn/universal-blue/#fresh-install-from-an-iso). These ISOs are large and typically need external hosting.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading `cosign.pub` and running:

```bash
cosign verify --key cosign.pub ghcr.io/mpabegg/fedora-custom
```

## Notes for future changes

ujust
- Removed to keep the host minimal. Reintroduce only if a small, focused set of helpers is needed.

Audio
- PipeWire/WirePlumber defaults are kept for stability and Hi-Fi playback.
- Use `pavucontrol` and `qpwgraph` for routing.

Xbox controllers (Bluetooth)
- Currently relies on kernel `xpad`.
- If Bluetooth support is insufficient, consider `xpadneo` via a COPR.

## ScrollWM + DankMaterialShell (optional session)

An additional Wayland session is provided: **Scroll + DMS**. KDE remains the default.

Included components (lean but full-featured):
- `scroll` compositor (Copr: `scrollwm/packages`)
- `dms` + `quickshell` + `dgop` (Copr: `avengemedia/dms` + `avengemedia/danklinux`)
- Core DMS add-ons: `cliphist`, `wl-clipboard`, `matugen`, `qt6ct`, `danksearch`
- Screen sharing portal: `xdg-desktop-portal-wlr`

This image ships a Scroll config in `/etc/skel` that remaps movement to vim keys (`h/j/k/l`).
It also switches the Scroll modifier to `Alt` and maps `Alt+Space` to the DMS launcher.
The Scroll + DMS session uses `/etc/scroll/scroll-dms.conf` to start DMS and hide Scroll's bar.
See `SCROLL_KEYMAPS.md` for the ScrollWM keybindings.

## VM validation checklist

- Rebase unsigned then signed image; verify rollback works.
- Confirm rpm-ostree check-only behavior (notifications, no auto-apply).
- Confirm Flatpak remotes: Flathub enabled, Fedora disabled.
- Confirm Flatpak update timers are enabled.
- Verify Homebrew works after first boot (`brew --version`).
- Validate keyd behavior matches config.
- Test Distrobox: `distrobox list` and `distrobox assemble` with `/etc/distrobox/distrobox.ini`.
- Launch `pavucontrol` and `qpwgraph`.
- Verify controllers are usable with `steam-devices` rules.
