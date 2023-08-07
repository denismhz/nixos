
{ config, pkgs, ... }:
{
  home.username = "denis";
  home.homeDirectory = "/home/denis";

  home.stateVersion = "23.05";

  xdg.enable = true;

  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "Dracula";
  qt.style.package = pkgs.dracula-theme;

  programs.wofi.enable = true;

  programs.waybar.enable = true;
  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";
  gtk.theme.package = pkgs.dracula-theme;
  gtk.theme.name = "Dracula";
  gtk.iconTheme.package = pkgs.dracula-icon-theme;
  gtk.iconTheme.name = "Dracula";

  fonts.fontconfig.enable = true;

  programs.alacritty.enable = true;

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = ''
	########################################################################################
	AUTOGENERATED HYPR CONFIG.
	PLEASE USE THE CONFIG PROVIDED IN THE GIT REPO /examples/hypr.conf AND EDIT IT,
	OR EDIT THIS ONE ACCORDING TO THE WIKI INSTRUCTIONS.
	########################################################################################

	#
	# Please note not all available settings / options are set here.
	# For a full list, see the wiki
	#

		# See https://wiki.hyprland.org/Configuring/Monitors/
	monitor=,preferred,auto,auto


	# See https://wiki.hyprland.org/Configuring/Keywords/ for more

	# Execute your favorite apps at launch
	exec-once = waybar

	# Source a file (multi-file configs)
	# source = ~/.config/hypr/myColors.conf

	# Some default env vars.

	animations {
	    enabled = yes

	    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

	    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

	    animation = windows, 1, 7, myBezier
	    animation = windowsOut, 1, 7, default, popin 80%
	    animation = border, 1, 10, default
	    animation = borderangle, 1, 8, default
	    animation = fade, 1, 7, default
	    animation = workspaces, 1, 6, default
	}

	dwindle {
	    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
	    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
	    preserve_split = yes # you probably want this
	}

	master {
	    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
	    new_is_master = true
	}

	gestures {
	    # See https://wiki.hyprland.org/Configuring/Variables/ for more
	    workspace_swipe = off
	}

	# Example per-device config
	# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
	device:epic-mouse-v1 {
	    sensitivity = -0.5
	}

	input {
		kb_layout = de
	}

	# Example windowrule v1
	# windowrule = float, ^(kitty)$
	# Example windowrule v2
	# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
	# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


	# See https://wiki.hyprland.org/Configuring/Keywords/ for more
	$mainMod = ALT

	# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
	bind = $mainMod, ENTER, exec, alacritty
	bind = $mainMod, C, killactive, 
	bind = $mainMod, M, exit, 
	bind = $mainMod, N, exec, dolphin
	bind = $mainMod, V, togglefloating, 
	bind = $mainMod, D, exec, wofi --show drun
	bind = $mainMod, P, pseudo, # dwindle
	bind = $mainMod, J, togglesplit, # dwindle

	# Move focus with mainMod + arrow keys
	bind = $mainMod, left, movefocus, l
	bind = $mainMod, right, movefocus, r
	bind = $mainMod, up, movefocus, u
	bind = $mainMod, down, movefocus, d

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
	bind = $mainMod, 0, workspace, 10

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
	bind = $mainMod SHIFT, 0, movetoworkspace, 10

	# Scroll through existing workspaces with mainMod + scroll
	bind = $mainMod, mouse_down, workspace, e+1
	bind = $mainMod, mouse_up, workspace, e-1

	# Move/resize windows with mainMod + LMB/RMB and dragging
	bindm = $mainMod, mouse:272, movewindow
	bindm = $mainMod, mouse:273, resizewindow'';

  programs.home-manager.enable = true;
}
