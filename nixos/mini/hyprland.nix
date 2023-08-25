{pkgs,...}:
{

	enable = true;
	extraConfig = ''
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
			       env = GTK_THEME,Dracula
			       env = XDG_SESSION_DESKTOP,Hyprland
			       env = GDK_BACKEND,wayland,x11
			       env = QT_AUTO_SCREEN_SCALE_FACTOR,1
			       env = QT_QPA_PLATFORM,wayland;xcb
			       env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
			       env = QT_QPA_PLATFORMTHEME,qt5ct
			       env = QT_STYLE_OVERRIDE,kvantum

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
# dracula/hyprland
	general {
		col.active_border = rgb(44475a) rgb(bd93f9) 90deg
			col.inactive_border = rgba(44475aaa)
			col.group_border = rgba(282a36dd)
			col.group_border_active = rgb(bd93f9) rgb(44475a) 90deg
# non-gradient alternative
#col.active_border = rgb(bd93f9)
#col.inactive_border = rgba(44475aaa)
#col.group_border = rgba(282a36dd)
#col.group_border_active = rgb(bd93f9)
# darker alternative
#col.active_border = rgb(44475a) # or rgb(6272a4)
#col.inactive_border = rgb(282a36)
#col.group_border = rgb(282a36)
#col.group_border_active = rgb(44475a) # or rgb(6272a4)

	}
	decoration {
		col.shadow = rgba(1E202966)
# suggested shadow setting
#drop_shadow = yes
#shadow_range = 60
#shadow_offset = 1 2
#shadow_render_power = 3
#shadow_scale = 0.97
	}
#windowrulev2 = bordercolor rgb(ff5555),xwayland:1 # check if window is xwayland

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
	       bind = $mainMod, RETURN, exec, alacritty
	       bind = $mainMod, C, killactive, 
		    bind = $mainMod, M, exit, 
		    bind = $mainMod, N, exec, dolphin
			    bind = $mainMod, V, togglefloating, 
		    bind = $mainMod, D, exec, wofi --show drun
			    bind = $mainMod, P, pseudo, # dwindle
			    bind = $mainMod, J, togglesplit, # dwindle
			    bind = $mainMod, W, exec, librewolf
			    bind = $mainMod, T, togglegroup

# Move focus with mainMod + arrow keys
			    bind = $mainMod, left, movefocus, l
			    bind = $mainMod, right, movefocus, r
			    bind = $mainMod, up, movefocus, u
			    bind = $mainMod, down, movefocus, d
			    bind = $mainMod, H, movefocus, l
			    bind = $mainMod, L, movefocus, r
			    bind = $mainMod, K, movefocus, u
			    bind = $mainMod, J, movefocus, d
			    bind = $mainMod, left, changegroupactive, b

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
}
