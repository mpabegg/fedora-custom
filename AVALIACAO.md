# Project Evaluation (repo vs description)

This document consolidates the current repo state, validates the provided description, and captures gaps/suggestions. The goal is to preserve context if the conversation is resumed later.

## 1) Declared scope (summary)

- Base: Fedora KDE Atomic (rpm-ostree), Wayland default, KDE stock.
- Minimal host: base system + QoL. Development and tooling in Distrobox.
- Updates via rpm-ostree with functional rollback.
- System-wide Flatpaks via BlueBuild with Flathub and Fedora remote removed.
- Host services: 1Password (GUI + CLI) and keyd (Caps Lock -> Escape).
- Shell/CLI QoL via `/etc/profile.d`:
  - UTF-8 locale, EDITOR/VISUAL, neutral aliases, simple prompt.
  - Homebrew PATH configured (brew not installed by the system).
  - `ujust` like Bazzite.
  - Welcome banner removed.
- Test methodology: clean Fedora Atomic VM, direct rebase, no `/var` inheritance, BlueBuild pipeline healthy.
- Out of scope (by design): NVIDIA, gamescope/SteamOS, aggressive tuning, advanced audio tweaks.
- Next goals:
  - xpadneo + udev/firmware.
  - Alternative Wayland session (ScrollWM + DankMaterialShell) while keeping KDE default.
  - ISO generation optional after UX/hardware stabilizes.

## 2) Current repo state (what is implemented)

### 2.1 Structure

- `recipes/recipe.yml`: image definition, base, modules.
- `files/system/*`: files copied into the image.
- `files/scripts/example.sh`: example script (unused).
- `cosign.pub`: public key for signature verification.
- `README.md`: still BlueBuild template.

### 2.2 Image base

- Base defined in `recipes/recipe.yml`:
  - `base-image: ghcr.io/ublue-os/kinoite-main`
  - `image-version: latest`
- Implication: KDE Atomic aligned with uBlue `kinoite-main`.

### 2.3 BlueBuild modules configured (execution order)

1) **files**
   - Copies `files/system/*` to `/` in the image.

2) **containerfile**
   - Copies `/system_files` from `ghcr.io/ublue-os/brew:latest` into the image.

3) **dnf**
   - COPRs: `atim/starship`, `alternateved/keyd`.
   - Packages installed:
     - `micro`
     - `starship`
     - `keyd`
     - `1password`
     - `1password-cli`

4) **default-flatpaks** (system)
   - Flathub added (system scope).
   - Flatpaks installed:
     - `com.brave.Browser`
     - `app.zen_browser.zen`
     - `com.valvesoftware.Steam`
     - `com.vysp3r.ProtonPlus`
     - `org.videolan.VLC`
     - `com.github.tchx84.Flatseal`

5) **systemd**
   - Enabled units:
     - `keyd.service`
     - `brew-setup.service`
     - `brew-update.timer`
     - `brew-upgrade.timer`

6) **signing**
   - Signing config for signed images.

### 2.4 Host files (files/system)

#### `/etc/profile.d` (shell QoL)

- `files/system/etc/profile.d/10-locale-utf8.sh`
  - Sets `LANG=C.UTF-8` when `LANG` is empty.

- `files/system/etc/profile.d/20-editor-visual.sh`
  - Chooses editor in order: `nvim`, `vim`, `vi`, `nano`.
  - Sets `EDITOR` and `VISUAL` if unset.

- `files/system/etc/profile.d/30-linuxbrew-path.sh`
  - If `/var/home/linuxbrew/.linuxbrew` exists, prepends `bin` and `sbin` to `PATH`.
  - Does not install brew; only PATH handling.

- `files/system/etc/profile.d/40-host-aliases.sh`
  - Simple aliases: `ll`, `la`, `l`, `..`, `...`.

- `files/system/etc/profile.d/50-host-prompt.sh`
  - Simple Bash prompt: `\u@\h:\w\$`.

- `files/system/etc/profile.d/90-welcome-banner.sh`
  - Prints "Welcome to <hostname>" for interactive shells.

#### Other files

- `files/system/usr/bin/ujust`
  - Wrapper: `just -f /usr/share/ublue-os/justfile`.

- `files/system/etc/keyd/default.conf`
  - keyd default config:
    - `capslock = overload(control, esc)`.
    - `102nd = layer(shift)`.

- `files/system/etc/yum.repos.d/1password.repo`
  - Official 1Password repo (stable) with `gpgcheck` and `repo_gpgcheck`.

## 3) Description validation vs repo (matches and gaps)

### 3.1 Matches

- **KDE Atomic base**: consistent with `kinoite-main`.
- **Flatpaks list**: Brave, Zen, Steam, ProtonPlus, VLC, Flatseal are present.
- **1Password**: repo + packages installed on host.
- **keyd**: installed and `keyd.service` enabled.
- **QoL via profile.d**: locale, editor, aliases, and simple prompt are present.
- **ujust**: Bazzite-like wrapper present.

### 3.2 Gaps or divergences

- **Banner removed**: repo has `90-welcome-banner.sh` printing a banner.
- **Keyd mapping**: description says "Caps Lock -> Esc" but config uses `overload(control, esc)` and remaps `102nd`.
- **Starship**: installed via COPR though prompt is configured as simple.
- **Micro**: installed but not mentioned.
- **Flatpak Fedora remote removal**: no explicit step in `recipes/recipe.yml`; only Flathub is added.

## 4) Suggestions and improvements (aligned with Bazzite/WayBlue)

These suggestions align with a clean, predictable host and compatibility goals.

### 4.1 Xbox controller support (Bazzite-like)

- **xpadneo** for Xbox One/Series Bluetooth.
- **Firmware and udev rules** if applicable (likely under `files/system/etc/udev/rules.d/`).
- Optionally **xone** for USB dongle support if needed later.

### 4.2 Alternative Wayland session (ScrollWM + DankMaterialShell)

- Goal: add an extra session without affecting KDE.
- Typical approach:
  - Install required packages via `dnf` (or other modules).
  - Add `.desktop` in `/usr/share/wayland-sessions/` via `files/system`.
  - Keep KDE default (no SDDM changes beyond adding a session).

### 4.3 Distrobox QoL

- If not in the base, consider adding:
  - `distrobox` + `podman`.
  - `ujust` task or script for standard container creation.
- Keeps host clean and pushes tooling into containers, aligned with the goal.

### 4.4 Flatpak hygiene

- If the requirement is to remove the Fedora remote:
  - Add an explicit module or script in `recipes/recipe.yml` to remove it.
- Adjust Flathub priority if needed.

### 4.5 Automatic updates (optional)

- If you want a more "set and forget" behavior:
  - Use `rpm-ostreed-automatic` with a conservative policy (if it does not conflict with manual control).

### 4.6 Documentation

- `README.md` is still the BlueBuild template; update it to reflect:
  - Goals (clean host + Distrobox).
  - Current scope and out-of-scope items.
  - Rebase/rollback instructions and validation steps.
  - Package/Flatpak lists and rationale.

## 5) Items to confirm/decide

- **Banner**: should it be removed? If yes, remove `90-welcome-banner.sh`.
- **Keyd**: do you want pure `Caps Lock -> Esc` or keep `overload(control, esc)`?
- **Starship**: keep or drop from host?
- **Micro**: keep or drop?
- **Remove Fedora remote**: confirm requirement and preferred method.
- **xpadneo**: Bluetooth only or include dongle support (`xone`)?
- **Alternative session**: specific packages/repos for ScrollWM + DankMaterialShell.

## 6) Final notes

- The repo is consistent with the goal (KDE Atomic + lean host + QoL via profile.d).
- There are small mismatches between the description and what is committed.
- Next features can be added incrementally while keeping the system predictable.
