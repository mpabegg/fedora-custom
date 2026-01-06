# Changes Grouped By Area

This document groups changes by functional area and summarizes the advantages
of each group. It covers both the ublue-os/main base and fedora-custom layers.

## Base and update policy
- Signed kernel + versionlocks (uBlue).
  - Advantage: Predictable boot behavior and fewer breakages from kernel or
    graphics stack updates.
- rpm-ostree automatic update timers enabled (uBlue + fedora-custom).
  - Advantage: System stays current without manual intervention.
- Staged rpm-ostree update config (uBlue).
  - Advantage: Safer updates with less interruption and fewer surprise reboots.
- initramfs generation and zstd compression (uBlue).
  - Advantage: Reliable boot artifacts and faster initramfs operations.

## Package sources and policy
- COPR enablement for uBlue packages and staging (uBlue).
  - Advantage: Access to uBlue-maintained packages and early fixes.
- Negativo17 multimedia repo with higher priority (uBlue).
  - Advantage: Better codec support and newer multimedia stack.
- Additional COPRs for starship, keyd, ghostty, and scroll/DMS (fedora-custom).
  - Advantage: Access to niche or fast-moving packages not in Fedora.
- 1Password RPM repo (fedora-custom).
  - Advantage: Official, up-to-date 1Password packages.

## Flatpak setup and maintenance
- Flathub as default system remote (uBlue + fedora-custom services).
  - Advantage: Wider app availability and consistent Flatpak source.
- Flatpak update timers enabled (uBlue + fedora-custom services).
  - Advantage: Apps stay updated automatically.
- Fedora Flatpak remotes disabled/removed (uBlue + fedora-custom cleanup).
  - Advantage: Avoids duplicate app sources and mixed metadata.

## Security and integrity
- cosign installed (uBlue).
  - Advantage: Enables image signature verification.
- Container policy override (uBlue).
  - Advantage: Ensures container signature rules match uBlue expectations.
- Keyd service enabled (fedora-custom).
  - Advantage: System-wide, consistent key remapping at login.

## Graphics, hardware, and multimedia
- Mesa/libva overrides from Negativo17 (uBlue).
  - Advantage: Better VAAPI support and fewer codec limitations.
- NVIDIA optional stack (uBlue).
  - Advantage: Official driver integration with container toolkit support.
- Udev rules and hardware tooling (uBlue).
  - Advantage: Improves support for RGB devices, wheels, and peripherals.
- Audio and video tools (uBlue).
  - Advantage: Full media playback, thumbnails, and encoding support.

## Desktop environment and input methods
- GNOME and KDE variant package sets (uBlue).
  - Advantage: Better IME support and desktop integration per variant.
- wlroots portal preference (fedora-custom).
  - Advantage: Reliable screen capture/screencast on wlroots compositors.
- Scroll/DMS stack packages (fedora-custom).
  - Advantage: Provides the intended Wayland session and tooling.

## Developer and power-user tooling
- Distrobox installed and configured (uBlue + fedora-custom).
  - Advantage: Clean separation of host OS and dev toolchains.
- Shell defaults and aliases (fedora-custom).
  - Advantage: Consistent, ergonomic shell setup across hosts.
- Text editors and CLI tools (uBlue + fedora-custom).
  - Advantage: Useful tools available on first boot without extra setup.

## Fonts and localization
- Expanded Noto font coverage and CJK fixes (uBlue).
  - Advantage: Better multilingual text rendering and fewer missing glyphs.
- Additional UI fonts (fedora-custom).
  - Advantage: Matches intended UI look and improves typography.

## Homebrew integration
- Brew system files copied in (fedora-custom).
  - Advantage: Enables preconfigured Homebrew setup on first boot.
- Brew path in profile and sudo secure_path (uBlue + fedora-custom).
  - Advantage: Brew tools work consistently for users and sudo.

## Quality-of-life UX
- Welcome banner and prompt tweaks (fedora-custom).
  - Advantage: Clear interactive shell feedback without extra config.
