#!/usr/bin/env bash
#
# lastmod: 2019-07-08T22:30:53+02:00

##########################################
# xfce4 settings
##########################################
# set xfce4 theme
xfconf-query -c xsettings -p /Net/ThemeName -s "Equilux"
# set xfce4 icon theme
xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus-Dark"
# set default font
xfconf-query -c xsettings -p /Gtk/FontName -s "Roboto Mono Regular 10"
# set default monospace font
xfconf-query -c xsettings -p /Gtk/MonospaceFontName -s "Roboto Mono Regular 10"


##########################################
# xfwm4 window manager settings
##########################################
# set xfwm4 window manager theme
xfconf-query -c xfwm4 -p /general/theme -s "Equilux"
# set xfwm4 window manager title font
xfconf-query -c xfwm4 -p /general/title_font -s "Roboto Mono Regular 10"


##########################################
# desktop settings
##########################################
# hide desktop icons
xfconf-query -c xfce4-desktop -p /desktop-icons/style -s 0
#xfconf-query -c xfce4-desktop -p /backdrop/screen0/

##########################################
# panel settings
##########################################
# set panel position to top (p=6), no idea what x/y does
xfconf-query -c xfce4-panel -p /panels/panel-0/position -s "p=6;x=400;y=14"


##########################################
# thunar config
##########################################
# show hidden files
xfconf-query -c thunar -p /last-show-hidden -s true
# set default view to 'details'
xfconf-query -c thunar -p /default-view -s "ThunarDetailsView"
# sort by type
xfconf-query -c thunar -p /last-sort-column -s "THUNAR_COLUMN_TYPE"
# sort in ascending order
xfconf-query -c thunar -p /last-sort-order -s "GTK_SORT_ASCENDING"
# sort folder first
xfconf-query -c thunar -p /misc-folders-first -s true
# column to show and order
xfconf-query -c thunar -p /last-details-view-column-order -s "THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE,THUNAR_COLUMN_DATE_MODIFIED"
# visible colummns in details view
xfconf-query -c thunar -p /last-details-view-visible-columns -s "THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_NAME,THUNAR_COLUMN_OWNER,THUNAR_COLUMN_PERMISSIONS,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE"
# set date stle YYYY-MM-DD
xfconf-query -c thunar -p /misc-date-style -s "THUNAR_DATE_STYLE_YYYYMMDD"

#
xfconf-query -c thunar --create -p /misc-thumbnail-mode -t string -n "THUNAR_THUMBNAIL_MODE_ONLY_LOCAL"
xfconf-query -c thunar --create -p /misc-thumbnail-draw-frames -t bool -n false
xfconf-query -c thunar --create -p /last-menubar-visible -t bool -n true
xfconf-query -c thunar --create -p /misc-file-size-binary -t bool -n true


##########################################
# config panel
##########################################
# link seems to be overwritten after logout, but file content stays the same
ln -sf  $(pwd)/dotfiles/config/xfce4/panel/whiskermenu-8.rc ~/.config/xfce4/panel/whiskermenu-8.rc


##########################################
# plank config
# ----------------------------------------
# - see also https://wiki.archlinux.org/index.php/Plank
##########################################
cat ./dotfiles/config/plank/plank.ini | dconf load /
if [[ -d  ~/.config/plank ]]; then rm -rf ~/.config/plank; fi
ln -sf $(pwd)/dotfiles/config/plank ~/.config/plank


##########################################
# autostart entries
##########################################
ln -sf  $(pwd)/dotfiles/config/autostart/Nextcloud-client.desktop ~/.config/autostart/Nextcloud-client.desktop
ln -sf  $(pwd)/dotfiles/config/autostart/plank.desktop ~/.config/autostart/plank.desktop
