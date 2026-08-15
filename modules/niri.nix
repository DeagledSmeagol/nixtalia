{inputs, ...}: {
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.default = self'.packages.myNiri;
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        xwayland-satellite.path =
          lib.getExe pkgs.xwayland-satellite;

        #spawn-at-startup = [
        #(lib.getExe self'.packages.myNoctalia)
        #];

        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

        input = {
          keyboard.xkb = {
            # You can set rules, model, layout, variant and options.
            # For more information, see xkeyboard-config(7).

            # For example:
            # layout = "us,ru";
            # options = "grp:win_space_toggle,compose:ralt,ctrl:nocaps";
          };

          touchpad = {
            # off = _: { };
            tap = _: {};
            dwt = _: {};
            dwtp = _: {};
            # drag false = _: { };
            # drag-lock = _: { };
            natural-scroll = _: {};
            # accel-speed = "0.2";
            # accel-profile = "flat";
            scroll-method = "two-finger";
            # disabled-on-external-mouse = _: { };

            # In this config, 1 finger = left click, 2 fingers = right click, 3 fingers = middle click
            tap-button-map = "left-right-middle";
            click-method = "clickfinger";
          };

          trackpoint = {
            # off = _: { };
            natural-scroll = _: {};
            # accel-speed = "0.2";
            # accel-profile = "flat";
            # scroll-method = "on-button-down";
            # scroll-button = "273";
            # scroll-button-lock = _: { };
            # middle-emulation = _: { };
          };

          mouse = {
            # off = _: { };
            # natural-scroll = _: { };
            # accel-speed 0.2 = _: { };
            # accel-profile "flat" = _: { };
            # scroll-method "no-scroll" = _: { };
          };

          # Uncomment this to make the mouse warp to the center of newly focused windows.
          # warp-mouse-to-focus = _: { };

          # Focus windows and outputs automatically when moving the mouse into them.
          # Setting max-scroll-amount="0%" makes it work only on windows already fully on     screen.
          # Current setting allows scrolling 1/3 of the screen width
          focus-follows-mouse = _: {
            props.max-scroll-amount = "34%";
            content = _: {};
          };
        };

        # Lid close command
        extraConfig = ''
          switch-events {
            lid-close {
              spawn "${lib.getExe self'.packages.myNoctalia}" "ipc" "call" "lockScreen" "lock"
            }
          }
        '';

        layout = {
          gaps = 15;

          focus-ring.off = _: {};

          border = {
            on = _: {};
            width = 4;
          };
        };

        prefer-no-csd = _: {};

        binds = {
          "Mod+Return" = _: {
            props.hotkey-overlay-title = "Open a Terminal: ghostty";
            content.spawn-sh = "ghostty";
          };

          "Mod+L" = _: {
            props.hotkey-overlay-title = "Lock the Screen";
            content.spawn-sh = lib.getExe self'.packages.myNoctalia + " ipc call lockScreen lock";
          };

          "Mod+D" = _: {
            props.hotkey-overlay-title = "Open Application Menu";
            content.spawn-sh = lib.getExe self'.packages.myNoctalia + " msg launcher toggle";
          };

          # Window Controls

          # Move focus
          "Mod+Q".close-window = _: {};
          "Mod+Left".focus-column-left = _: {};
          "Mod+Down".focus-window-down = _: {};
          "Mod+Up".focus-window-up = _: {};
          "Mod+Right".focus-column-right = _: {};

          # Move Windows/Columns
          "Mod+Shift+Left".move-column-left = _: {};
          "Mod+Shift+Down".move-window-down = _: {};
          "Mod+Shift+Up".move-window-up = _: {};
          "Mod+Shift+Right".move-column-right = _: {};

          # Move to first/last column
          "Mod+Home".focus-column-first = _: {};
          "Mod+End".focus-column-last = _: {};

          # Move Monitor Focus
          "Mod+Ctrl+Left".focus-monitor-left = _: {};
          "Mod+Ctrl+Down".focus-monitor-down = _: {};
          "Mod+Ctrl+Up".focus-monitor-up = _: {};
          "Mod+Ctrl+Right".focus-monitor-right = _: {};

          # Move Columns to monitors
          "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = _: {};
          "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = _: {};
          "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = _: {};
          "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = _: {};

          # Move focus to work space up/down
          "Mod+Page_Down".focus-workspace-down = _: {};
          "Mod+Page_Up".focus-workspace-up = _: {};

          # Move column to work space up/down
          "Mod+Shift+Page_Down".move-column-to-workspace-down = _: {};
          "Mod+Shift+Page_Up".move-column-to-workspace-up = _: {};

          # Move window to work space up/down
          "Mod+Ctrl+Page_Down".move-workspace-down = _: {};
          "Mod+Ctrl+Page_Up".move-workspace-up = _: {};

          # Change workspace/column focus with mouse
          "Mod+WheelScrollDown" = _: {
            props.cooldown-ms = 150;
            content.focus-workspace-down = _: {};
          };

          "Mod+WheelScrollUp" = _: {
            props.cooldown-ms = 150;
            content.focus-workspace-up = _: {};
          };

          "Mod+WheelScrollRight".focus-column-right = _: {};
          "Mod+WheelScrollLeft".focus-column-left = _: {};

          #Move columns with mouse
          "Mod+Shift+WheelScrollDown" = _: {
            props.cooldown-ms = 150;
            content.move-column-to-workspace-down = _: {};
          };

          "Mod+Shift+WheelScrollUp" = _: {
            props.cooldown-ms = 150;
            content.move-column-to-workspace-up = _: {};
          };

          "Mod+Shift+WheelScrollRight".move-column-right = _: {};
          "Mod+Shift+WheelScrollLeft".move-column-left = _: {};

          # Open the Overview
          "Mod+O" = _: {
            props.repeat = false;
            content.toggle-overview = _: {};
          };

          #Move focus to workspace
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          #Move Column to workspace
          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Shift+6".move-column-to-workspace = 6;
          "Mod+Shift+7".move-column-to-workspace = 7;
          "Mod+Shift+8".move-column-to-workspace = 8;
          "Mod+Shift+9".move-column-to-workspace = 9;

          #Move focused window in or out of a column
          "Mod+BracketLeft".consume-or-expel-window-left = _: {};
          "Mod+BracketRight".consume-or-expel-window-right = _: {};
          # Consume one window from the right to the bottom of the focused column.
          "Mod+Comma".consume-window-into-column = _: {};
          # Expel the bottom window from the focused column to the right.
          "Mod+Period".expel-window-from-column = _: {};

          # Cycle through widths set in preset-column-widths.
          "Mod+R".switch-preset-column-width = _: {};
          # Cycling through the presets in reverse order is also possible.
          "Mod+Shift+R".switch-preset-column-width-back = _: {};

          "Mod+Ctrl+Shift+R".switch-preset-window-height = _: {};
          "Mod+Ctrl+R".reset-window-height = _: {};

          "Mod+F".maximize-column = _: {};
          "Mod+Shift+F".fullscreen-window = _: {};
          "Mod+Ctrl+F".expand-column-to-available-width = _: {};

          "Mod+C".center-column = _: {};
          "Mod+Ctrl+C".center-visible-columns = _: {};

          #Floating Window Control
          "Mod+Space".toggle-window-floating = _: {};
          "Mod+Shift+Space".switch-focus-between-floating-and-tiling = _: {};

          # Toggle tabbed column display mode.
          # Windows in this column will appear as vertical tabs,
          # rather than stacked on top of each other.
          "Mod+W".toggle-column-tabbed-display = _: {};

          #Screenshot controls
          "Print".screenshot = _: {};
          "Ctrl+Print".screenshot-screen = _: {};
          "Alt+Print".screenshot-window = _: {};

          "Mod+Escape".show-hotkey-overlay = _: {};

          "Mod+Shift+Escape" = _: {
            props.allow-inhibiting = false;
            content.toggle-keyboard-shortcuts-inhibit = _: {};
          };

          "Mod+Shift+E".quit = _: {};

          #Volume Controls
          "XF86AudioRaiseVolume" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = lib.getExe self'.packages.myNoctalia + " msg volume increase";
          };
          "XF86AudioLowerVolume" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = lib.getExe self'.packages.myNoctalia + " msg volume decrease";
          };
          "XF86AudioMute" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = lib.getExe self'.packages.myNoctalia + " msg volume muteOutput";
          };
          "XF86AudioMicMute" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = lib.getExe self'.packages.myNoctalia + " msg volume muteInput";
          };

          #Brightness Controls
          "XF86MonBrightnessUp" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = lib.getExe self'.packages.myNoctalia + " msg brightness increase";
          };
          "XF86MonBrightnessDown" = _: {
            props.allow-when-locked = true;
            content.spawn-sh = lib.getExe self'.packages.myNoctalia + " msg brightness decrease";
          };

          # Other Function Row Keybinds
          "XF86Display".toggle-overview = _: {};
          "XF86WLAN".spawn-sh = lib.getExe self'.packages.myNoctalia + " msg wifi toggle";
          "XF86Fn_F10".spawn-sh = lib.getExe self'.packages.myNoctalia + " msg settings open";
        };

        window-rules = [
          {
            matches = [{app-id = "^zen$";}];
            open-maximized = true;
          }
          {
            matches = [{app-id = "^krita$";}];
            open-maximized = true;
          }
          {
            geometry-corner-radius = 12;
            clip-to-geometry = true;
          }
        ];
      };
    };
  };
}
