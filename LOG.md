# Project Log

This log captures decisions and steps taken, in chronological order. Each entry includes context, actions, and outcomes so progress is traceable across sessions.

---

## 2026-01-06: Baseline capture and repo validation

- Context: Document current state of the image and validate against the intended design goals.
- Actions:
  - Audited `recipes/recipe.yml` and `files/system/*`.
  - Compared repo state with the stated project description.
  - Recorded gaps, matches, and suggested next steps.
- Output:
  - Created `AVALIACAO.md` with a detailed comparison and recommendations.

## 2026-01-06: Homebrew preinstall (Bazzite-style)

- Context: Need Homebrew preinstalled in the image rather than manual user install.
- Reference research:
  - Bazzite copies Homebrew from `ghcr.io/ublue-os/brew` into the image and enables setup timers.
  - WayBlue provides manual install via `just` but does not preinstall.
- Decision:
  - Follow Bazzite approach using `ghcr.io/ublue-os/brew`.
- Actions:
  - Added `containerfile` snippet to copy `/system_files` from `ghcr.io/ublue-os/brew:latest`.
  - Enabled `brew-setup.service`, `brew-update.timer`, `brew-upgrade.timer`.
  - Updated Homebrew PATH helper to use `/var/home/linuxbrew/.linuxbrew`.
- Files changed:
  - `recipes/recipe.yml`
  - `files/system/etc/profile.d/30-linuxbrew-path.sh`
- Expected outcome:
  - Homebrew tarball is present in the image and extracted on first boot.
  - Brew update/upgrade timers are enabled.

## 2026-01-06: Remove `iso.log`

- Context: Clean up repo by removing a stray log file.
- Action: Deleted `iso.log` and committed the removal.

## 2026-01-06: Translate `AVALIACAO.md` to English

- Context: Keep documentation in English for wider reuse.
- Action: Replaced `AVALIACAO.md` content with English translation.

## 2026-01-06: Remove `ujust` wrapper

- Context: Re-evaluate whether `ujust` is needed; prefer minimal host and simple scripts if required later.
- Action: Removed the `ujust` wrapper from the image.
- File changed:
  - `files/system/usr/bin/ujust`

## 2026-01-06: Document ujust reevaluation note

- Context: Keep a visible reminder in project docs about revisiting ujust later.
- Action: Added a short reminder section in `README.md`.
- File changed:
  - `README.md`

## 2026-01-06: Distrobox baseline (light integration)

- Context: `kinoite-main` does not include Distrobox; prefer a light setup vs full Bazzite integration.
- Actions:
  - Added `distrobox` to host packages.
  - Added a minimal `/etc/distrobox/distrobox.ini` with Fedora/Arch toolbox + vanilla images.
  - Added DistroShelf Flatpak for container management UI.
- Files changed:
  - `recipes/recipe.yml`
  - `files/system/etc/distrobox/distrobox.ini`

## 2026-01-06: Xbox controller support (Bluetooth only)

- Context: Add minimal, Bazzite-aligned Bluetooth support without tuning.
- Actions:
  - Added `atim/xpadneo` COPR (Fedora 43 builds available).
  - Added `xpadneo-kmod` package to avoid file conflicts with `xpadneo-kmod-common`.
- Files changed:
  - `recipes/recipe.yml`

## 2026-01-06: Temporarily remove xpadneo for build debugging

- Context: DNF transaction failed with a sysusers conflict; isolate whether xpadneo is involved.
- Action: Removed `xpadneo-kmod` and the xpadneo COPR from the recipe.
- Files changed:
  - `recipes/recipe.yml`

## 2026-01-06: Fix DistroShelf Flatpak ID

- Context: Use the correct Flathub app ID for DistroShelf.
- Action: Replaced the incorrect Flatpak ID with `com.ranfdev.DistroShelf`.
- Files changed:
  - `recipes/recipe.yml`

## 2026-01-06: Audio tools (minimal)

- Context: Keep audio stable for gaming/Hi-Fi while supporting DAW routing.
- Actions:
  - Added `pavucontrol` and `qpwgraph` packages.
  - Documented the light audio approach in the README.
- Files changed:
  - `recipes/recipe.yml`
  - `README.md`

## 2026-01-06: Flatpak remotes (light)

- Context: Keep a single, predictable Flatpak source aligned with the project goals.
- Actions:
  - Added a one-time systemd unit to enable Flathub and disable Fedora remotes.
  - Documented the remotes policy in the README.
- Files changed:
  - `files/system/usr/lib/systemd/system/flatpak-remote-cleanup.service`
  - `recipes/recipe.yml`
  - `README.md`

---

## Open items / next checks

- Verify Homebrew availability after first boot:
  - `brew --version` should work once `brew-setup.service` completes.
- Confirm whether the Fedora Flatpak remote should be explicitly removed.
- Decide on keyd mapping (pure `Caps Lock -> Esc` vs `overload(control, esc)`).
- Decide whether to keep `starship` and `micro` on the host.
- Implement Xbox controller support (xpadneo + udev/firmware).
- Add alternate Wayland session (ScrollWM + DankMaterialShell) without affecting KDE.
