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

## 2026-01-06: Xbox controller support via ublue akmods (Bluetooth only)

- Context: Align with ublue-os/main approach for maximum compatibility.
- Actions:
  - Copy akmods RPMs from `ghcr.io/ublue-os/akmods:main-43`.
  - Install `ublue-os-akmods-addons` and `xpadneo` kmod RPMs directly.
- Files changed:
  - `recipes/recipe.yml`

## 2026-01-06: Gaming QoL (light)

- Context: Improve controller/device permissions without adding heavy hardware stacks.
- Actions:
  - Added `steam-devices`.
  - Documented the light gaming QoL approach in the README.
- Files changed:
  - `recipes/recipe.yml`
  - `README.md`

## 2026-01-06: Defer xpadneo (use kernel xpad)

- Context: Akmods images do not currently ship xpadneo; avoid fragile packaging.
- Actions:
  - Removed the akmods-based xpadneo install steps.
  - Added a README note to revisit xpadneo if Bluetooth support is insufficient.
- Files changed:
  - `recipes/recipe.yml`
  - `README.md`

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

## 2026-01-06: Flatpak update timers (light)

- Context: Enable automatic Flatpak updates without extra tooling.
- Actions:
  - Added a one-time systemd unit to enable system and user Flatpak update timers.
  - Noted the timers in the README.
- Files changed:
  - `files/system/usr/lib/systemd/system/flatpak-update-timers.service`
  - `recipes/recipe.yml`
  - `README.md`

## 2026-01-06: rpm-ostree updates (check-only)

- Context: Notify about updates without auto-applying them.
- Actions:
  - Enabled `rpm-ostreed-automatic.timer`.
  - Set `AutomaticUpdatePolicy=check`.
  - Documented the policy in the README.
- Files changed:
  - `files/system/etc/rpm-ostreed.conf.d/10-automatic-updates.conf`
  - `recipes/recipe.yml`
  - `README.md`

## 2026-01-06: README refresh

- Context: Replace template text with the current image goals, scope, and contents.
- Actions:
  - Updated the README to describe base image, included packages/flatpaks, update policy, and notes.
  - Added an explicit nod to the uBlue ecosystem (Bazzite/WayBlue).
- Files changed:
  - `README.md`

## 2026-01-06: Add ScrollWM keymap cheatsheet

- Context: Provide a self-contained reference for Scroll's default bindings.
- Actions:
  - Added a keymap cheatsheet based on Scroll's upstream `config.in`.
  - Linked the cheatsheet from the README.
  - Added a plain-English summary of the keymaps.
- Files changed:
  - `SCROLL_KEYMAPS.md`
  - `README.md`
  - `LOG.md`

## 2026-01-06: Remap Scroll movement keys to vim-style hjkl

- Context: Prefer vim-style navigation over arrow keys in Scroll.
- Actions:
  - Added a Scroll config to `/etc/skel` that remaps movement to `h/j/k/l`.
  - Documented the remap in the README and keymap cheatsheet.
- Files changed:
  - `files/system/etc/skel/.config/scroll/config`
  - `README.md`
  - `SCROLL_KEYMAPS.md`
  - `LOG.md`

## 2026-01-06: Scroll mod/launcher defaults (Alt + DMS spotlight)

- Context: Align Scroll defaults with DMS and preferred modifiers.
- Actions:
  - Switched the Scroll modifier to `Alt` (`Mod1`).
  - Mapped `Alt+Space` to toggle the DMS spotlight launcher.
  - Set the default terminal to `konsole`.
  - Updated README and keymap cheatsheet to reflect the new defaults.
- Files changed:
  - `files/system/etc/skel/.config/scroll/config`
  - `SCROLL_KEYMAPS.md`
  - `README.md`
  - `LOG.md`

## 2026-01-06: Start DMS from the Scroll session config

- Context: Ensure DMS starts reliably after Scroll is up, and hide Scroll's bar.
- Actions:
  - Added `/etc/scroll/scroll-dms.conf` for the combined session.
  - Start DMS from that config and set the bar to invisible.
  - Updated the session wrapper to use the DMS config.
  - Documented the new config in the README.
- Files changed:
  - `files/system/etc/scroll/scroll-dms.conf`
  - `files/system/usr/bin/scroll-dms-session`
  - `README.md`
  - `LOG.md`

## 2026-01-06: Align Scroll + DMS config with DMS compositor guidance

- Context: Match DMS recommendations for wlroots-based compositors.
- Actions:
  - Start `wl-paste --watch cliphist store` from the Scroll+DMS config.
  - Added DMS IPC keybindings for launcher, clipboard, process list, and settings.
  - Routed audio/brightness media keys through DMS IPC.
  - Set `QT_QPA_PLATFORM=wayland` in the Scroll+DMS session wrapper.
  - Updated README and keymap cheatsheet.
- Files changed:
  - `files/system/etc/scroll/scroll-dms.conf`
  - `files/system/usr/bin/scroll-dms-session`
  - `SCROLL_KEYMAPS.md`
  - `README.md`
  - `LOG.md`

## 2026-01-06: Fix Scroll keybind conflicts with Alt modifier

- Context: Scroll reported config warnings due to Alt-based overlaps.
- Actions:
  - Introduced `$super` (`Mod4`) for secondary combos instead of `Alt`.
  - Updated Scroll+DMS config and skel config to use `$super` for nomode/jump/fullscreen/selection bindings.
  - Adjusted modifier mode to use arrow keys explicitly.
  - Moved `bar mode invisible` inside the Scroll+DMS bar block.
  - Updated keymap cheatsheet to match new bindings.
- Files changed:
  - `files/system/etc/skel/.config/scroll/config`
  - `files/system/etc/scroll/scroll-dms.conf`
  - `SCROLL_KEYMAPS.md`
  - `LOG.md`

## 2026-01-06: Use the default Scroll session with ~/.config integration

- Context: Simplify to a single Scroll session and keep all integration under user config.
- Actions:
  - Removed the custom Scroll+DMS session entry and wrapper.
  - Moved DMS startup, clipboard watcher, DMS IPC binds, and bar hiding into the skel config.
  - Ensure DMS starts with `QT_QPA_PLATFORM=wayland`.
  - Updated README to describe the default-session integration.
- Files changed:
  - `files/system/etc/skel/.config/scroll/config`
  - `files/system/usr/share/wayland-sessions/scroll-dms.desktop`
  - `files/system/usr/bin/scroll-dms-session`
  - `files/system/etc/scroll/scroll-dms.conf`
  - `README.md`
  - `LOG.md`

## 2026-01-06: Add ScrollWM + DMS session (lean full-featured)

- Context: Provide an optional modern WM + shell session alongside KDE.
- Actions:
  - Added ScrollWM and DMS via COPR repos with weak deps disabled.
  - Installed minimal add-ons for core DMS functionality.
  - Added a dedicated session entry and wrapper script.
  - Added Scroll portal config and `xdg-desktop-portal-wlr`.
  - Documented the session in the README.
- Files changed:
  - `recipes/recipe.yml`
  - `files/system/usr/bin/scroll-dms-session`
  - `files/system/usr/share/wayland-sessions/scroll-dms.desktop`
  - `files/system/usr/share/xdg-desktop-portal/scroll-portals.conf`
  - `README.md`

## 2026-01-06: Document VM validation checklist

- Context: Keep a lightweight, repeatable validation flow for clean-VM testing.
- Action: Added a VM validation checklist to the README.
- Files changed:
  - `README.md`

## 2026-01-06: Add feature matrix document

- Context: Provide a consolidated comparison of uBlue Main, Bazzite, WayBlue, and this image.
- Action: Added `FEATURES.md` with a best-effort feature matrix.
- Files changed:
  - `FEATURES.md`

---

## Open items / next checks

- Verify Homebrew availability after first boot:
  - `brew --version` should work once `brew-setup.service` completes.
- Confirm whether the Fedora Flatpak remote should be explicitly removed.
- Decide on keyd mapping (pure `Caps Lock -> Esc` vs `overload(control, esc)`).
- Decide whether to keep `starship` and `micro` on the host.
- Implement Xbox controller support (xpadneo + udev/firmware).
