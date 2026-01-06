# Changes From Base Images

This document lists the changes layered on top of Fedora's Atomic base images.
It is split into two parts:

1) ublue-os/main (the common base used by kinoite-main and silverblue-main)
2) fedora-custom (this repo)

Sources used:
- uBlue main clone at `/tmp/ublue-os-main`
- fedora-custom recipes in `recipes/` and files in `files/system/`

## 1) ublue-os/main additions (on top of Fedora base)

Base image in ublue-os/main:
- `quay.io/fedora-ostree-desktops/${SOURCE_IMAGE}:${FEDORA_MAJOR_VERSION}`
  - Explanation: This is the upstream Fedora Atomic base that uBlue modifies.

### System files overlaid
- `/usr/lib/dracut/dracut.conf.d/10-compression.conf` sets `compress="zstd"`.
  - Explanation: Forces zstd compression for initramfs to improve size/speed balance.
- `/usr/lib/systemd/system/flatpak-add-flathub-repos.service` replaces Fedora's Flatpak setup service.
  - Explanation: Adds Flathub as the default and disables Fedora remotes by default.
- `/usr/lib/tmpfiles.d/coredump.conf` sets coredump retention to 5 days.
  - Explanation: Reduces disk usage by cleaning older coredumps faster.
- `/usr/share/dnf/plugins/copr.vendor.conf` sets `distribution = fedora` for dnf5 COPR.
  - Explanation: Ensures COPR repos resolve to Fedora chroots instead of image IDs.

### Core package additions
Added from `/tmp/ublue-os-main/packages.json` (all images):
- Audio/video/media: `fdk-aac`, `ffmpeg`, `ffmpeg-libs`, `ffmpegthumbnailer`, `libavcodec`, `libfdk-aac`, `libheif`, `heif-pixbuf-loader`.
  - Explanation: Enables media playback, encoding, and thumbnails.
- Fonts: `google-noto-sans-balinese-fonts`, `google-noto-sans-cjk-fonts`, `google-noto-sans-javanese-fonts`, `google-noto-sans-sundanese-fonts`.
  - Explanation: Broad international font coverage.
- Hardware/graphics: `intel-vaapi-driver`, `libva-utils`, `libcamera*`, `pipewire-plugin-libcamera`, `pipewire-libs-extra`.
  - Explanation: Hardware video acceleration and camera support.
- System tooling: `distrobox`, `flatpak-spawn`, `fuse`, `grub2-tools-extra`, `nvme-cli`, `smartmontools`, `wireguard-tools`, `zstd`.
  - Explanation: Container/tooling, system utilities, and compression tools.
- Diagnostics/ops: `htop`, `lshw`, `net-tools`, `powerstat`, `tcpdump`, `tmux`, `traceroute`, `vim`, `xhost`, `xorg-x11-xauth`.
  - Explanation: Common admin and debugging utilities.
- Input/security: `pam-u2f`, `pam_yubico`, `pamu2fcfg`, `yubikey-manager`.
  - Explanation: U2F/YubiKey auth support.
- Other hardware rules: `openrgb-udev-rules`, `oversteer-udev`, `solaar-udev`, `libratbag-ratbagd`.
  - Explanation: Device rules for RGB, wheel, Logitech, and ratbag devices.

Variant-specific additions:
- Silverblue: `adw-gtk3-theme`, `gvfs-nfs`, `ibus-unikey`, `ibus-mozc`.
  - Explanation: GNOME theme compatibility and input methods.
- Kinoite: `fcitx5-*`, `kcm-fcitx5`, `kate`, `ksshaskpass`, `icoutils`.
  - Explanation: KDE input methods and tools.

Fedora 42 additions:
- `android-udev-rules`, `mesa-libxatracker`.
  - Explanation: Android device access and tracker-related Mesa support.

### Package removals
From `/tmp/ublue-os-main/packages.json`:
- All images: `google-noto-sans-cjk-vf-fonts`, `default-fonts-cjk-sans`, `fedora-third-party`.
  - Explanation: Avoid conflicting font packages and disable Fedora's third-party repo by default.
- Silverblue: `totem-video-thumbnailer`, `gnome-software-rpm-ostree`.
  - Explanation: Reduce GNOME Software rpm-ostree integration where undesired.
- Kinoite: `ffmpegthumbnailer`, `plasma-discover-rpm-ostree`.
  - Explanation: Avoid conflicting thumbnailer and rpm-ostree Discover plugin.

### Repo and package policy changes
- Enables COPR repos `ublue-os/packages` and `ublue-os/staging` during build.
  - Explanation: Pulls uBlue maintained packages and staged updates.
- Enables Negativo17 `fedora-multimedia` repo and sets priority 90.
  - Explanation: Uses multimedia stack with better codec support, higher priority than Fedora.
- Swaps `OpenCL-ICD-Loader` to `ocl-icd`.
  - Explanation: Works around an upstream packaging bug.
- Replaces `/usr/etc/containers/policy.json` with uBlue policy.
  - Explanation: Ensures container signature policy matches uBlue expectations.

### Kernel and graphics stack changes
- Removes stock kernel packages and installs signed kernel RPMs from akmods.
  - Explanation: Ensures signed kernel with versionlock for stability.
- Versionlocks kernel packages and Mesa-related overrides from Negativo17.
  - Explanation: Prevents accidental updates that can break graphics stack.
- Optional NVIDIA path (when enabled): installs NVIDIA driver stack and enables `ublue-nvctk-cdi.service`.
  - Explanation: Provides NVIDIA support and container toolkit integration.

### Flatpak and update behavior
- Removes Fedora Flatpak repo package and adds Flathub repo file.
  - Explanation: Standardizes on Flathub as the primary system Flatpak source.
- Enables `rpm-ostreed-automatic.timer`, `flatpak-system-update.timer`, and `flatpak-user-update.timer`.
  - Explanation: Turns on update timers by default.

### Other system adjustments
- Installs `cosign` from GitHub releases.
  - Explanation: Supports image signature verification.
- Adds CoreOS rescue generator to force emergency shell when needed.
  - Explanation: Improves rescue and recovery behavior.
- Updates staged rpm-ostree config via `/usr/share/ublue-os/update-services`.
  - Explanation: Enables staged updates policy.
- Adds linuxbrew path to sudo secure_path.
  - Explanation: Allows `sudo` to find Homebrew binaries if installed.
- Cleanup steps remove `/usr/etc`, rebuild `/boot`, and clean `/var` and `/tmp`.
  - Explanation: Ensures bootc/ostree compatibility and a clean image state.

## 2) fedora-custom additions (this repo)

Base images in fedora-custom recipes:
- KDE: `ghcr.io/ublue-os/kinoite-main:latest` (`recipes/kinoite.yml`)
- GNOME: `ghcr.io/ublue-os/silverblue-main:latest` (`recipes/silverblue.yml`)
  - Explanation: Both are uBlue "main" variants; customizations are layered on top.

### Files copied into the image
`recipes/modules.yml` copies `files/system/*` to `/`.

- `/etc/distrobox/distrobox.ini`
  - Explanation: Predefines curated Fedora/Arch toolbox and vanilla images.
- `/etc/keyd/default.conf`
  - Explanation: Remaps Caps to Ctrl/Esc and 102nd key to Shift layer.
- `/etc/profile.d/10-locale-utf8.sh`
  - Explanation: Ensures `LANG=C.UTF-8` when unset.
- `/etc/profile.d/20-editor-visual.sh`
  - Explanation: Sets `EDITOR`/`VISUAL` to a sensible default (nvim/vim/vi/nano).
- `/etc/profile.d/30-linuxbrew-path.sh`
  - Explanation: Adds Homebrew path if `/var/home/linuxbrew/.linuxbrew` exists.
- `/etc/profile.d/40-host-aliases.sh`
  - Explanation: Adds common shell aliases (ll, la, l, .., ...).
- `/etc/profile.d/50-host-prompt.sh`
  - Explanation: Simple readable Bash prompt for interactive shells.
- `/etc/profile.d/90-welcome-banner.sh`
  - Explanation: Prints a small welcome banner on interactive shells.
- `/etc/rpm-ostreed.conf.d/10-automatic-updates.conf`
  - Explanation: Sets rpm-ostree automatic updates to "check".
- `/etc/yum.repos.d/1password.repo`
  - Explanation: Adds 1Password stable RPM repo for host installation.
- `/usr/share/xdg-desktop-portal/scroll-portals.conf`
  - Explanation: Prefers wlroots portals for screencast/screenshot; disables inhibit portal.
- `/usr/lib/systemd/system/flatpak-remote-cleanup.service`
  - Explanation: Ensures Flathub enabled and Fedora remotes removed (one-time).
- `/usr/lib/systemd/system/flatpak-update-timers.service`
  - Explanation: Enables Flatpak system/user update timers (one-time).

### Additional files from another image
- Copies `/system_files` from `ghcr.io/ublue-os/brew:latest`.
  - Explanation: Brings Homebrew setup assets into the image.

### DNF package additions
From `recipes/modules.yml`:
- COPR repos: `atim/starship`, `alternateved/keyd`, `scottames/ghostty`.
  - Explanation: Provides starship, keyd, and Ghostty packages.
- Packages: `micro`, `starship`, `keyd`, `ghostty`, `1password`, `1password-cli`, `distrobox`, `pavucontrol`, `qpwgraph`, `steam-devices`.
  - Explanation: Terminal tools, keyboard daemon, password manager, audio tools, Steam udev rules.
- COPR repos: `scrollwm/packages`, `avengemedia/dms`, `avengemedia/danklinux`.
  - Explanation: Provides Scroll/DMS stack and related tooling.
- Packages: `scroll`, `dms`, `quickshell`, `dgop`, `accountsservice`, `fira-code-fonts`, `rsms-inter-fonts`, `material-symbols-fonts`, `cliphist`, `wl-clipboard`, `matugen`, `qt6ct`, `danksearch`, `xdg-desktop-portal-wlr`.
  - Explanation: Wayland desktop components, fonts, clipboard tools, theming, portal backend.

### Flatpak additions
System scope from `recipes/modules.yml`:
- `com.brave.Browser`, `app.zen_browser.zen`.
  - Explanation: Browsers.
- `com.valvesoftware.Steam`, `com.vysp3r.ProtonPlus`.
  - Explanation: Gaming client and Proton management.
- `org.videolan.VLC`.
  - Explanation: Media player.
- `com.github.tchx84.Flatseal`.
  - Explanation: Flatpak permission manager.
- `com.ranfdev.DistroShelf`.
  - Explanation: GUI for Distrobox management.

### Enabled systemd units
From `recipes/modules.yml`:
- `keyd.service`.
  - Explanation: Enables keyd for keyboard remapping.
- `brew-setup.service`, `brew-update.timer`, `brew-upgrade.timer`.
  - Explanation: Initializes and updates Homebrew.
- `flatpak-remote-cleanup.service`, `flatpak-update-timers.service`.
  - Explanation: One-time setup and timer enablement for Flatpak.
- `rpm-ostreed-automatic.timer`.
  - Explanation: Enables rpm-ostree automatic checks.

### Signing
- `type: signing` in `recipes/modules.yml`.
  - Explanation: Adds policy and files required for signed image support.
