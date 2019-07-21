#!/usr/bin/env bash

# Description:
# ------------
# tbd
#
# lastmod: 2019-07-21T11:56:42+02:00
# Change History:
# ---------------
#   - 2019-07-21: added keyboard shortcuts
#   - 2019-07-20: prtinf corrections
#   - 2019-07-19:
#     - bug-fix for plank: disables xfwm shadows under dock windows
#     - styling corrections
#     - placeholder for keyboard shortcuts and LightDM+Greeter

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"

##########################################
# xfce4 General Settings
##########################################
# set xfce4 theme
xfconf-query --channel xsettings --property /Net/ThemeName --set "Equilux"
# set xfce4 icon theme
xfconf-query --channel xsettings --property /Net/IconThemeName --set "Papirus-Dark"
# set default font
xfconf-query --channel xsettings --property /Gtk/FontName --set "Roboto Mono Regular 10"
# set default monospace font
xfconf-query --channel xsettings --property /Gtk/MonospaceFontName --set "Roboto Mono Regular 10"


##########################################
# xfwm4 Window Manager Settings
##########################################
# set xfwm4 window manager theme
xfconf-query --channel xfwm4 --property /general/theme --set "Equilux"
# set xfwm4 window manager title font
xfconf-query --channel xfwm4 --property /general/title_font --set "Roboto Mono Regular 10"


##########################################
# Desktop Settings
##########################################
# hide desktop icons
xfconf-query --channel xfce4-desktop --property /desktop-icons/style --set 0
#xfconf-query --channel xfce4-desktop --property /backdrop/screen0/


##########################################
# Panel & Menu Configuration
##########################################
# link seems to be overwritten after logout, but file content stays the same
# ln -sf  "$(pwd)"/dotfiles/config/xfce4/panel/whiskermenu-8.rc ~/.config/xfce4/panel/whiskermenu-8.rc
# set panel position to top (p=6), no idea what x/y does
xfconf-query --channel xfce4-panel --property /panels/panel-0/position --set "p=6;x=400;y=14"


##########################################
# Thunar Configuration
##########################################
# show hidden files
xfconf-query --channel thunar --property /last-show-hidden --set true
# set default view to 'details'
xfconf-query --channel thunar --property /default-view --set "ThunarDetailsView"
# sort by type
xfconf-query --channel thunar --property /last-sort-column --set "THUNAR_COLUMN_TYPE"
# sort in ascending order
xfconf-query --channel thunar --property /last-sort-order --set "GTK_SORT_ASCENDING"
# sort folder first
xfconf-query --channel thunar --property /misc-folders-first --set true
# column to show and order
xfconf-query --channel thunar --property /last-details-view-column-order --set "THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE,THUNAR_COLUMN_DATE_MODIFIED"
# visible colummns in details view
xfconf-query --channel thunar --property /last-details-view-visible-columns --set "THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_NAME,THUNAR_COLUMN_OWNER,THUNAR_COLUMN_PERMISSIONS,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE"
# set date stle YYYY-MM-DD
xfconf-query --channel thunar --property /misc-date-style --set "THUNAR_DATE_STYLE_YYYYMMDD"

#
xfconf-query --channel thunar --create --property /misc-thumbnail-mode --type string --set "THUNAR_THUMBNAIL_MODE_ONLY_LOCAL"
xfconf-query --channel thunar --create --property /misc-thumbnail-draw-frames --type bool --set false
xfconf-query --channel thunar --create --property /last-menubar-visible --type bool --set true
xfconf-query --channel thunar --create --property /misc-file-size-binary --type bool --set true


##########################################
# Plank Configuration
# ----------------------------------------
# - see also https://wiki.archlinux.org/index.php/Plank
##########################################
cat ./dotfiles/config/plank/plank.ini | dconf load /
if [[ -d  ~/.config/plank ]]; then rm -rf ~/.config/plank; fi
ln -sf "$(pwd)"/dotfiles/config/plank ~/.config/plank
# fix "horizontal line bug" in xfce
# https://arcolinux.com/how-to-remove-the-shadow-around-the-plank-on-xfce/
xfconf-query --channel xfwm4 --property /general/show_dock_shadow --set "false"


##########################################
# Autostart Entries
##########################################
cp "$(pwd)"/dotfiles/config/autostart/Nextcloud-client.desktop ~/.config/autostart/Nextcloud-client.desktop
cp "$(pwd)"/dotfiles/config/autostart/plank.desktop ~/.config/autostart/plank.desktop

##########################################
# Keyboard Shortcuts
##########################################
# Open xfce4-Terminal: super + t
xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/commands/custom/<Super>t" --set "xfce4-terminal"
# Lock: super + l
xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/commands/custom/<Super>l" --set "xflock4"
# tile window lower left quarter: alt + super + left
xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Alt><Super>Left" --set "tile_down_left_key"
# tile window lower right quarter: alt + super + right
xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Alt><Super>Right" --set "tile_down_right_key"
# tile window lower half: super + down
xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Super>Down" --set "tile_down_key"
# tile window left half: super + left
xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Super>Left" --set "tile_left_key"
# tile window right half: super + right
xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Super>Right" --set "tile_right_key"
# tile window upper half: super + up
xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Super>Up" --set "tile_up_key"
# tile window upper left quarter: ctrl + super + left
xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Primary><Super>Left" --set "tile_up_left_key"
# tile window upper right quarter: ctrl + super + right
xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Primary><Super>Right" --set "tile_up_right_key"
# take screenshot with flameshot: print
xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/commands/custom/Print" --set "flameshot gui"
# show desktop: super + d
xfconf-query --channel xfce4-keyboard-shortcuts --create --property "/xfwm4/custom/<Super>d" --set "show_desktop_key"


##########################################
# LightDM and Greeter
##########################################
# tbd
