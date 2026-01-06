# ScrollWM Default Keymaps

These bindings mirror the upstream Scroll default config (`config.in`).

## Plain English Overview

- `Mod` (Alt) is your main "do stuff" key.
- `Mod+Return` opens the terminal; `Mod+Space` opens the launcher.
- `Mod+h/j/k/l` moves focus; `Mod+Ctrl+h/j/k/l` moves windows.
- `Mod+1..0` switches workspaces; `Mod+Shift+1..0` sends windows to them.
- `Mod+f` is fullscreen; `Mod+Shift+f` toggles floating.
- `Mod+Shift+r` enters resize mode; `Mod+Ctrl+r` enters floating move/resize mode.
- `Mod+t` toggles size for the current window; `Mod+Shift+t` for the active set.
- `Mod+z` cycles scratchpad; `Mod+Shift+z` sends a window there.
- `Mod+Tab` shows overview; `Mod+/` starts jump navigation.
- `Mod+Shift+c` reloads config; `Mod+Shift+x` exits the session.
- `Mod+v` opens clipboard history; `Mod+m` toggles process list; `Mod+Shift+,` toggles settings.

This image remaps movement keys from arrows to vim-style `h/j/k/l`:
- `Left -> h`
- `Down -> j`
- `Up -> k`
- `Right -> l`

Variables used in the defaults:
- `Mod` is `Mod1` (Alt).
- `$super` is `Mod4` (Super/Windows key).
- `$left/$down/$up/$right` are the arrow keys (remapped to `h/j/k/l` in this image).
- `$term` is `konsole`.
- `$menu` is `dms ipc call spotlight toggle`.
- `$filemanager` is not set by default (set it if you want `Mod+e`).

Mouse modifier:
- Hold `Mod` + left mouse button to move windows.
- Hold `Mod` + right mouse button to resize windows.

## Basics

- `Mod+Return`: launch terminal (`$term`).
- `Mod+Backspace`: kill focused window.
- `Mod+Shift+Backspace`: kill unfocused window.
- `Mod+Ctrl+Backspace`: kill all windows.
- `Mod+Space`: launcher (`$menu`).
- `Mod+v`: DMS clipboard toggle.
- `Mod+m`: DMS process list toggle.
- `Mod+Shift+,`: DMS settings toggle.
- `Mod+e`: file manager (`$filemanager`).
- `Mod+Shift+c`: reload config.
- `Mod+Shift+x`: exit Scroll with confirmation.
- `Mod+[` : `set_mode h`.
- `Mod+]` : `set_mode v`.

## Focus and Move

- `Mod+Left/Down/Up/Right`: focus left/down/up/right.
- `Mod+Home/End`: focus beginning/end.
- `Mod+Ctrl+Left/Down/Up/Right`: move left/down/up/right.
- `Mod+Ctrl+Home/End`: move beginning/end.
- `Mod+Super+Left/Down/Up/Right`: move left/down/up/right (nomode).
- `Mod+Super+Home/End`: move beginning/end (nomode).
- `Mod+Shift+Left/Down/Up/Right`: focus output left/down/up/right.

## Workspaces

- `Mod+1..0`: switch to workspace 1..10.
- `Mod+Shift+1..0`: move container to workspace 1..10, then follow.
- `Mod+Ctrl+Shift+Left/Right`: move workspace to output left/right.
- `Mod+Ctrl+1..0`: swap workspaces 1..10.
- `Mod+Ctrl+Shift+1..0`: swap workspace names only (1..10).
- `Mod+Shift+Page_Up/Page_Down`: workspace prev/next.
- `Mod+Page_Up/Page_Down`: workspace prev_on_output/next_on_output.

## Workspace Split Mode (`wssplit`)

- `Mod+Shift+\`: enter `wssplit` mode.
- `1`: split v 0.25; exit.
- `Shift+1`: split h 0.25; exit.
- `2`: split v 0.333333333; exit.
- `Shift+2`: split h 0.333333333; exit.
- `3`: split v 0.5; exit.
- `Shift+3`: split h 0.5; exit.
- `4`: split v 0.66666667; exit.
- `Shift+4`: split h 0.6666667; exit.
- `5`: split v 0.75; exit.
- `Shift+5`: split h 0.75; exit.
- `r`: split reset; exit.
- `Esc`: exit mode.

## Scaling, Overview, Jump

- `Mod+Shift+,`: scale workspace -0.05.
- `Mod+Shift+.`: scale workspace +0.05.
- `Mod+Shift+Ctrl+.`: reset workspace scale.
- `Mod+Shift+MouseWheelUp/Down`: scale workspace -/+ 0.05.
- `Mod+Tab`: overview.
- `Mouse Button 8`: overview.
- `Mod+/`: jump.
- `Mod+Shift+/`: jump container.
- `Mod+Ctrl+/`: jump workspaces.
- `Mod+Super+/`: jump floating.
- `Mod+,`: scale content -0.05.
- `Mod+.`: scale content +0.05.
- `Mod+Ctrl+.`: reset content scale.
- `Mod+MouseWheelUp/Down`: scale content -/+ 0.05.

## Layout and Floating

- `Mod+f`: fullscreen.
- `Mod+Ctrl+f`: fullscreen layout.
- `Mod+Super+f`: fullscreen application.
- `Mod+Ctrl+Super+f`: fullscreen global.
- `Mod+y`: focus mode toggle.
- `Mod+Shift+y`: layout transpose.
- `Mod+Shift+f`: floating toggle.
- `Mod+Shift+Ctrl+a`: sticky toggle.
- `Mod+a`: pin beginning.
- `Mod+Shift+a`: pin end.

## Selection

- `Mod+Insert`: selection toggle.
- `Mod+Ctrl+Insert`: selection reset.
- `Mod+Shift+Insert`: selection move.
- `Mod+Ctrl+Shift+Insert`: selection workspace.
- `Mod+Super+Insert`: selection to_trail.

## Scratchpad

- `Mod+Shift+z`: move to scratchpad.
- `Mod+z`: scratchpad show.
- `Mod+Super+z`: scratchpad jump.
- `Mod+Ctrl+z`: workspace back_and_forth.

## Modifiers Mode (`modifiers`)

- `Mod+\`: enter `modifiers` mode.
- `Right`: `set_mode after`; exit.
- `Left`: `set_mode before`; exit.
- `Home`: `set_mode beginning`; exit.
- `End`: `set_mode end`; exit.
- `Up`: `set_mode focus`; exit.
- `Down`: `set_mode nofocus`; exit.
- `h`: `set_mode center_horiz`; exit.
- `Shift+h`: `set_mode nocenter_horiz`; exit.
- `v`: `set_mode center_vert`; exit.
- `Shift+v`: `set_mode nocenter_vert`; exit.
- `r`: `set_mode reorder_auto`; exit.
- `Shift+r`: `set_mode noreorder_auto`; exit.
- `Esc`: exit mode.

## Resize and Size Cycling

- `Mod+-`: cycle size h prev.
- `Mod+=`: cycle size h next.
- `Mod+Shift+-`: cycle size v prev.
- `Mod+Shift+=`: cycle size v next.

### Set Size H Mode (`setsizeh`)

- `Mod+b`: enter `setsizeh` mode.
- `1`: set_size h 0.125; exit.
- `2`: set_size h 0.1666666667; exit.
- `3`: set_size h 0.25; exit.
- `4`: set_size h 0.333333333; exit.
- `5`: set_size h 0.375; exit.
- `6`: set_size h 0.5; exit.
- `7`: set_size h 0.625; exit.
- `8`: set_size h 0.6666666667; exit.
- `9`: set_size h 0.75; exit.
- `0`: set_size h 0.833333333; exit.
- `-`: set_size h 0.875; exit.
- `=`: set_size h 1.0; exit.
- `Esc`: exit mode.

### Set Size V Mode (`setsizev`)

- `Mod+Shift+b`: enter `setsizev` mode.
- `1`: set_size v 0.125; exit.
- `2`: set_size v 0.1666666667; exit.
- `3`: set_size v 0.25; exit.
- `4`: set_size v 0.333333333; exit.
- `5`: set_size v 0.375; exit.
- `6`: set_size v 0.5; exit.
- `7`: set_size v 0.625; exit.
- `8`: set_size v 0.6666666667; exit.
- `9`: set_size v 0.75; exit.
- `0`: set_size v 0.833333333; exit.
- `-`: set_size v 0.875; exit.
- `=`: set_size v 1.0; exit.
- `Esc`: exit mode.

### Resize Mode (`resize`)

- `Mod+Shift+r`: enter `resize` mode.
- `Left/Down/Up/Right`: resize shrink width/grow height/shrink height/grow width.
- `Shift+Left/Down/Up/Right`: resize shrink right/grow down/shrink down/grow right.
- `Ctrl+Left/Down/Up/Right`: resize grow left/shrink up/grow up/shrink left.
- `Esc`: exit mode.

### Floating Mode (`floating`)

- `Mod+Ctrl+r`: enter `floating` mode.
- `Left/Down/Up/Right`: move 50px.
- `Shift+Left/Down/Up/Right`: resize shrink right/grow down/shrink down/grow right (50px).
- `Ctrl+Left/Down/Up/Right`: resize grow left/shrink up/grow up/shrink left (50px).
- `Esc`: exit mode.

## Toggle Size

- `Mod+t`: toggle_size this 1.0 1.0.
- `Mod+Shift+t`: toggle_size active 1.0 1.0.

### Toggle Size H Mode (`togglesizeh`)

- `Mod+Ctrl+t`: enter `togglesizeh` mode.
- `1`: toggle_size all 0.125 1.0; exit.
- `2`: toggle_size all 0.1666666667 1.0; exit.
- `3`: toggle_size all 0.25 1.0; exit.
- `4`: toggle_size all 0.333333333 1.0; exit.
- `5`: toggle_size all 0.375 1.0; exit.
- `6`: toggle_size all 0.5 1.0; exit.
- `7`: toggle_size all 0.625 1.0; exit.
- `8`: toggle_size all 0.6666666667 1.0; exit.
- `9`: toggle_size all 0.75 1.0; exit.
- `0`: toggle_size all 0.833333333 1.0; exit.
- `-`: toggle_size all 0.875 1.0; exit.
- `=`: toggle_size all 1.0 1.0; exit.
- `r`: toggle_size reset; exit.
- `Esc`: exit mode.

### Toggle Size V Mode (`togglesizev`)

- `Mod+Ctrl+Shift+t`: enter `togglesizev` mode.
- `1`: toggle_size all 1.0 0.125; exit.
- `2`: toggle_size all 1.0 0.1666666667; exit.
- `3`: toggle_size all 1.0 0.25; exit.
- `4`: toggle_size all 1.0 0.333333333; exit.
- `5`: toggle_size all 1.0 0.375; exit.
- `6`: toggle_size all 1.0 0.5; exit.
- `7`: toggle_size all 1.0 0.625; exit.
- `8`: toggle_size all 1.0 0.6666666667; exit.
- `9`: toggle_size all 1.0 0.75; exit.
- `0`: toggle_size all 1.0 0.833333333; exit.
- `-`: toggle_size all 1.0 0.875; exit.
- `=`: toggle_size all 1.0 1.0; exit.
- `r`: toggle_size reset; exit.
- `Esc`: exit mode.

## Align Mode (`align`)

- `Mod+c`: enter `align` mode.
- `c`: align center; exit.
- `m`: align middle; exit.
- `r`: align reset; exit.
- `Left/Right/Up/Down`: align left/right/up/down; exit.
- `Esc`: exit mode.

## Fit Size Mode (`fit_size`)

- `Mod+w`: enter `fit_size` mode.
- `w`: fit_size h visible proportional; exit.
- `Shift+w`: fit_size v visible proportional; exit.
- `Ctrl+w`: fit_size h visible equal; exit.
- `Ctrl+Shift+w`: fit_size v visible equal; exit.
- `Right`: fit_size h toend proportional; exit.
- `Shift+Right`: fit_size v toend proportional; exit.
- `Ctrl+Right`: fit_size h toend equal; exit.
- `Ctrl+Shift+Right`: fit_size v toend equal; exit.
- `Left`: fit_size h tobeg proportional; exit.
- `Shift+Left`: fit_size v tobeg proportional; exit.
- `Ctrl+Left`: fit_size h tobeg equal; exit.
- `Ctrl+Shift+Left`: fit_size v tobeg equal; exit.
- `Up`: fit_size h active proportional; exit.
- `Shift+Up`: fit_size v active proportional; exit.
- `Down`: fit_size h all proportional; exit.
- `Shift+Down`: fit_size v all proportional; exit.
- `Ctrl+Down`: fit_size h all equal; exit.
- `Ctrl+Shift+Down`: fit_size v all equal; exit.
- `Esc`: exit mode.

## Trailmark Mode (`trailmark`)

- `Mod+;`: enter `trailmark` mode.
- `]`: trailmark next.
- `[`: trailmark prev.
- `;`: trailmark toggle; exit.
- `/`: trailmark jump; exit.
- `Esc`: exit mode.

## Trail Mode (`trail`)

- `Mod+Shift+;`: enter `trail` mode.
- `]`: trail next.
- `[`: trail prev.
- `0..9`: trail number 0..9; exit.
- `;`: trail new; exit.
- `d`: trail delete; exit.
- `c`: trail clear; exit.
- `Insert`: trail to_selection; exit.
- `Esc`: exit mode.

## Spaces Mode (`spaces`)

- `Mod+g`: enter `spaces` mode.
- `1..0`: space load 1..0; exit.
- `Shift+1..0`: space save 1..0; exit.
- `Ctrl+1..0`: space restore 1..0; exit.
- `Esc`: exit mode.

## Media and Utility Keys

- `XF86AudioRaiseVolume`: volume +3 (DMS audio).
- `XF86AudioLowerVolume`: volume -3 (DMS audio).
- `XF86AudioMute`: toggle sink mute (DMS audio).
- `XF86AudioMicMute`: toggle source mute (pactl).
- `XF86AudioPlay/Pause`: play-pause (playerctl).
- `XF86AudioPrev`: previous (playerctl).
- `XF86AudioNext`: next (playerctl).
- `XF86AudioStop`: stop (playerctl).
- `XF86MonBrightnessUp`: brightness +5 (DMS brightness).
- `XF86MonBrightnessDown`: brightness -5 (DMS brightness).
- `Print`: screenshot (grim).

## Gestures

- `swipe:4:right`: workspace next.
- `swipe:4:left`: workspace prev.
- `swipe:4:up`: overview.
