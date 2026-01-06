# Cosmic Atomic Feature Checklist

This checklist is used to decide which features should be included when building
from `quay.io/fedora-ostree-desktops/cosmic-atomic:43` (not a uBlue base).

## Base assumptions and parity
- [ ] Identify exact Fedora version and variant metadata for cosmic-atomic.
- [ ] List which uBlue/main changes are desired for parity (kernel, repos, timers).
- [ ] Decide whether to keep or replace Fedora-provided Flatpak remotes.
- [ ] Decide whether to enable automatic updates by default.

## Update and signing policy
- [ ] Signed kernel or versionlock strategy (if any).
- [ ] rpm-ostree update policy (manual/check/staged).
- [ ] Flatpak update timers enabled.
- [ ] Image signing and verification tooling (e.g., cosign).

## Repos and package sources
- [ ] Enable multimedia repo (e.g., Negativo17) or keep Fedora defaults.
- [ ] Enable third-party repos (e.g., 1Password).
- [ ] Enable COPR repos (list each and rationale).
- [ ] Document repo priorities and cleanup steps.

## Flatpak and apps
- [ ] Default Flatpak remote (Flathub/Fedora/both).
- [ ] Flatpak remote cleanup or migration service.
- [ ] System Flatpaks to install by default (list).
- [ ] App update policy (timers on/off).

## Desktop and session behavior
- [ ] COSMIC session integration requirements (portals, session files).
- [ ] Wayland portal backend preference (wlr/gnome/xdg-desktop-portal-gtk).
- [ ] Keybinding/keyboard remap strategy (keyd or COSMIC native).
- [ ] Input method frameworks (ibus/fcitx5) and languages.

## Graphics and multimedia stack
- [ ] Mesa/VAAPI override strategy (Fedora vs external repo).
- [ ] Intel/AMD GPU support requirements.
- [ ] NVIDIA support plan (if any).
- [ ] PipeWire extra codecs and camera support.

## System utilities and CLI
- [ ] Core CLI tools (e.g., fzf, tmux, htop, vim, micro).
- [ ] Diagnostics (lshw, smartmontools, tcpdump, traceroute).
- [ ] Networking tools (wireguard-tools, net-tools).

## Fonts and localization
- [ ] Noto and CJK font coverage.
- [ ] UI font choices (e.g., Inter, Fira Code, Material Symbols).
- [ ] Locale defaults and fallbacks.

## Distrobox and dev workflow
- [ ] Distrobox installed by default.
- [ ] Predefined images in `/etc/distrobox/distrobox.ini`.
- [ ] Homebrew integration (files, PATH, timers).

## Security and policy
- [ ] Container policy configuration.
- [ ] sudo secure_path adjustments.
- [ ] Udev rules for hardware (RGB, gamepads, peripherals).

## QoL and shell defaults
- [ ] Shell prompt defaults.
- [ ] Aliases and editor defaults.
- [ ] Welcome banner (on/off).

## Testing and validation
- [ ] Rebase/rollback test plan.
- [ ] Ensure COSMIC session launches cleanly.
- [ ] Verify portals and screen sharing.
- [ ] Validate update timers and Flatpak remotes.
