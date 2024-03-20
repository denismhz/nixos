{
  pkgs,
  inputs,
  ...
}: let
  test = import ../../my-modules {inherit pkgs;};
in {
  # hyprland config should be per user
  # all program configs should be per user
  hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
    #enableNvidiaPatches = true;
    extraConfig = ''
      $mainMod = ALT

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=eDP-1,2560x1600@165,1920x0,1.6
      monitor=HDMI-A-1,1920x1080,0x0,1

      # env = WLR_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1

      # Execute your favorite apps at launch
      # exec-once = eww daemon
      exec-once = hyprpaper
      exec-once = ${test}
      exec-once = mako
      exec-once = ${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1

      windowrule=noborder,^(wofi)$
      windowrule=noanim,^(wofi)$
      windowrule=bordersize 0,^(wofi)$
      windowrule=noshadow,^(wofi)$
      windowrule = float, title:(Telegram)
      windowrule = center,title:(Telegram)
      windowrule = size 50% 50%, title:(Telegram)

      # Some default env vars.
      # Maybe set these in nix?!?!??!??!??!??!??!!?!?!?!?!?!?!?!?!?!!?!?!?!?!?
      env = GTK_THEME,Dracula
      env = XDG_SESSION_DESKTOP,Hyprland
      env = GDK_BACKEND,wayland,x11

      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
      env = QT_QPA_PLATFORM,wayland
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = QT_QPA_PLATFORMTHEME,qt5ct
      env = QT_STYLE_OVERRIDE,kvantum
      env = XDG_SESSION_TYPE,wayland
      env = WLR_NO_HARDWARE_CURSORS,1

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      # Application bindings
      # Toggle keybinds
      bind=$mainMod SHIFT,O,submap,clean
      submap=clean
      bind=$mainMod SHIFT,O,submap,reset
      submap=reset
      # Mediakeys
      bind=,XF86AudioRaiseVolume,exec,pamixer -i 5
      bind=,XF86AudioLowerVolume,exec,pamixer -d 5
      bind=,XF86AudioMute,exec,pamixer -t
      bindl=,XF86AudioPlay, exec, playerctl play-pause
      bindl=,XF86AudioNext, exec, playerctl next
      bindl=,XF86AudioPrev, exec, playerctl previous
      #
      bind=$mainMod SHIFT, E, exec, ${test}
      bind=$mainMod SHIFT, I, exec, ~/.config/eww/dashboard/launch_dashboard
      bind = $mainMod SHIFT, T, exec, telegram-desktop
      bind = $mainMod, RETURN, exec, foot
      bind = $mainMod, O, exec, alacritty
      bind = $mainMod, N, exec, dolphin
      bind = $mainMod, D, exec, wofi --show drun
      bind = $mainMod, W, exec, firefox
      bind = $mainMod, C, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod SHIFT, R, forcerendererreload

      # Layout binding
      bind = $mainMod, SPACE, togglefloating,
      # Enter fullscreen for focused window
      bind = $mainMod, F, fullscreen
      # Alternatively, you can use vim bindings
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d
      # Alternatively, you can use vim bindings
      bind = $mainMod SHIFT, H, movewindow, l
      bind = $mainMod SHIFT, L, movewindow, r
      bind = $mainMod SHIFT, K, movewindow, u
      bind = $mainMod SHIFT, J, movewindow, d
      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 0
      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 0
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod SHIFT, mouse:272, resizewindow

      # Keyboard setup
      input {
        numlock_by_default = true
        kb_layout = de
        follow_mouse = 0
        kb_options = caps:swapescape
      }

      animations {
        enabled=0
        animation=windows,1,4,default,slide
        animation=border,1,5,default
        animation=fade,1,5,default
        animation=workspaces,1,3,default,slidevert
      }

      general {
        col.active_border = rgba(00000000) rgba(00000000) rgba(00000000) rgba(00000000) rgba(00000000) rgba(ffffffff) 270deg
        col.inactive_border = rgba(000000ff)
        gaps_out = 5
        gaps_in = 3
        cursor_inactive_timeout = 5
        no_cursor_warps = true
      }

      misc {
        disable_hyprland_logo = true
        new_window_takes_over_fullscreen = 2
      }
    '';
  };
}
