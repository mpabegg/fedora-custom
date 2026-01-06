# Feature Matrix (uBlue Main, Bazzite, WayBlue vs this image)

This is a best-effort, repo-based comparison. It focuses on documented features and observable implementation details in the upstream repos. Some items are provided indirectly via base images or external repos and may not be visible in those repos.

Legend
- Yes: included in this image
- Partial: similar intent but lighter implementation
- No: not included
- Unknown: not confirmed from the repo inspection

## Core platform

Feature | uBlue Main | Bazzite | WayBlue | This image
---|---|---|---|---
Atomic base (rpm-ostree/bootc) | Yes | Yes | Yes | Yes
KDE Atomic (Kinoite) base | Yes (variants) | Yes (variants) | Yes (variants) | Yes
Wayland default | Yes | Yes | Yes | Yes
Signed images (cosign) | Yes | Yes | Yes | Yes

## Updates

Feature | uBlue Main | Bazzite | WayBlue | This image
---|---|---|---|---
rpm-ostree automatic checks | Unknown | No (disabled) | Yes (enabled in script) | Yes (check-only)
Flatpak update timers | Unknown | Mixed (just + service) | Yes (enable timers) | Yes (timers enabled)
Podman auto-update | Unknown | Yes (in stack) | Yes (enable timers) | No

## Flatpak remotes

Feature | uBlue Main | Bazzite | WayBlue | This image
---|---|---|---|---
Flathub configured | Yes | Yes | Yes | Yes
Fedora Flatpak remotes disabled | Unknown | Yes | Unknown | Yes (one-time unit)
Flatpak manager service | Unknown | Yes (bazzite-flatpak-manager) | No | No

## Distrobox

Feature | uBlue Main | Bazzite | WayBlue | This image
---|---|---|---|---
Distrobox package | Unknown | Yes | Yes | Yes
Distrobox presets (/etc/distrobox/*.ini) | Unknown | Yes (curated + toolboxes) | No | Yes (light)
Distrobox helper workflows (just/scripts) | Unknown | Yes | No | No

## Gaming and controllers

Feature | uBlue Main | Bazzite | WayBlue | This image
---|---|---|---|---
steam-devices udev rules | Unknown | Likely (gaming stack) | Yes | Yes
xpadneo (Bluetooth Xbox) | Historically via akmods | Mentioned in README | No | No (deferred; kernel xpad)
xone (Xbox USB dongle) | Historically via akmods | Yes (README) | No | No
GameControllerDB (SDL) | Unknown | Yes (downloads DB) | No | No
Controller firmware utilities | Unknown | Yes (handheld stack) | No | No

## Audio

Feature | uBlue Main | Bazzite | WayBlue | This image
---|---|---|---|---
PipeWire/WirePlumber stack | Yes | Yes (enhanced) | Yes | Yes (default)
Virtual channels/sinks helpers | Unknown | Yes (ujust) | No | No
Spatial/virtual surround | Unknown | Yes (ujust) | No | No
Low-latency tuning | Unknown | Yes (handheld profiles) | No | No
Audio routing tools | Unknown | Mixed | Mixed | Yes (pavucontrol, qpwgraph)

## Virtualization

Feature | uBlue Main | Bazzite | WayBlue | This image
---|---|---|---|---
virt-manager tooling | Unknown | Yes (ujust) | No | No
VFIO/kvmfr helpers | Unknown | Yes | No | No

## Hardware/udev rules

Feature | uBlue Main | Bazzite | WayBlue | This image
---|---|---|---|---
ublue-os-udev-rules | Unknown | Yes (via packages) | Yes | No
Android udev rules | Unknown | No | Yes | No
Handheld-specific rules | Unknown | Yes | No | No

## Security and identity

Feature | uBlue Main | Bazzite | WayBlue | This image
---|---|---|---|---
1Password (GUI+CLI) | Unknown | No | No | Yes
SSH agent integration | Unknown | No | No | Yes (1Password)

## QoL / Shell

Feature | uBlue Main | Bazzite | WayBlue | This image
---|---|---|---|---
Custom ujust tasks | Unknown | Yes (extensive) | Yes (light) | No
Host prompt/aliases | Unknown | Yes | Yes | Yes
Homebrew preinstall | Unknown | Yes | No (just helper) | Yes

## UI / Sessions

Feature | uBlue Main | Bazzite | WayBlue | This image
---|---|---|---|---
Alt WM sessions | Unknown | Yes (varies) | Yes (varies) | No (planned)
Custom theming | Unknown | Yes | Yes | No

## Notes

- uBlue Main is a base; many higher-level features are added in derivative images (Bazzite/WayBlue). Not all feature presence is visible from the main repo.
- Bazzite includes many handheld- and gaming-specific features not aligned with this image's goals.
- WayBlue is closer to a light, composable base; its Distrobox and update behavior are minimal and align more closely with this image.
