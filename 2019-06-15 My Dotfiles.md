---
title: "My Dotfiles"
description: ""
date: 2019-06-15T10:33:24+02:00
lastmod: 2019-06-16T21:21:07+02:00
draft: true
tags: [ "linux", "dotfiles" ]
featuredimg: ""
---


## xfce
add autostart fpr nextcloud & plank


## Firefox
start alsways with -P
create profile "Pentesting"
set `network.captive-portal-service.enabled` to `false` in `about:config` to disable success.txt
Add-ons:
FoxyProxy Standard -> add burp proxy 127.0.0.1:8080

For burp install certificate:
https://support.portswigger.net/customer/portal/articles/1783087-installing-burp-s-ca-certificate-in-firefox

### pentesting user.js
```text
user_pref("network.captive-portal-service.enabled", false);
```


## .tmux.conf
- File location: `~/.tmux.conf`
- to reload config after change while tmus is running: `C-b : source-file ~/.tmux.conf`
- with version 2.9 new \*-style options

### < 2.9
```text
set -g default-terminal "screen-256color"
set -g history-limit 10000
set -s escape-time 0

set-window-option -g monitor-activity on
set-option -g visual-activity on

set -g pane-active-border-fg brightblue

set-option -g status on
set-option -g status-bg brightblue
set-window-option -g window-status-current-bg magenta
set -g status-right "eth0:#(ifconfig eth0 | grep inet[^6] | awk '{print $2}') | tun0:#(ifconfig tun0 2>/dev/null | grep inet[^6] | awk '{print $2}') | %Y-%m-%d %H:%M"
```
