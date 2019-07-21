#!/usr/bin/env bash

# Description:
# ------------
# setup custom firefox profiles
#
# lastmod: 2019-07-20T21:42:03+02:00
# Change History:
# ---------------
#   - 2019-07-20: printf corrections

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"

# remove existing profiles and cache
rm -rf ~/.mozilla
rm -rf ~/.cache/mozilla

##########################################
# Create and configure browsing profile
##########################################
profile_name="browsing"
firefox -CreateProfile ${profile_name}
firefox -P ${profile_name} &
firefox_pid=$!
sleep 3s
kill ${firefox_pid}

# Install addons for browsing profile
profile_path="$(dirname ~/.mozilla/firefox/*${profile_name})"
extensions_path="$(dirname ~/.mozilla/firefox/*${profile_name}/extensions)/extensions/)"
wget https://addons.mozilla.org/firefox/downloads/file/3027669/ublock_origin.xpi -O ${extensions_path}uBlock0@raymondhill.net.xpi
wget https://addons.mozilla.org/firefox/downloads/file/2345406/ghostery_privacy_ad_blocker.xpi -O ${extensions_path}firefox@ghostery.com.xpi
wget https://addons.mozilla.org/firefox/downloads/file/3015452/https_everywhere.xpi -O ${extensions_path}https-everywhere@eff.org.xpi
wget https://addons.mozilla.org/firefox/downloads/file/1688114/privacy_badger.xpi -O ${extensions_path}jid1-MnnxcxisBPnSXQ@jetpack.xpi
wget https://addons.mozilla.org/firefox/downloads/file/621553/disconnect.xpi -O ${extensions_path}2.0@disconnect.me.xpi

cp "$(pwd)"/dotfiles/firefox/browsing-user.js ${profile_path}/user.js


##########################################
# Create and configure pentesting profile
##########################################
profile_name="pentesting"
firefox -CreateProfile ${profile_name}
firefox -P ${profile_name} &
firefox_pid=$!
sleep 3s
kill ${firefox_pid}

# Install addons
profile_path="$(dirname ~/.mozilla/firefox/*${profile_name})"
extensions_path="${profile_path}/extensions)/extensions/)"
wget https://addons.mozilla.org/firefox/downloads/file/969185/foxyproxy_standard.xpi  -O ${extensions_path}foxyproxy@eric.h.jung.xpi

# Import firefox settings
cp "$(pwd)"/dotfiles/firefox/pentesting-user.js ${profile_path}/user.js

# Import burp cert: start burp in headless mode (yes for confirming tos), download cert, import cert into firefox, kill java
yes | java -jar -Djava.awt.headless=true /usr/share/burpsuite/burpsuite.jar &
burp_pid=$!
sleep 3
wget -e use_proxy=yes -e http_proxy=127.0.0.1:8080 http://burp/cert -O cacert.der
cert9db_path=$(find ~/.mozilla/firefox/ -type d -name "*${profile_name}")
certutil -A -t "TCu,Cu,Tu" -i cacert.der -d sql:${cert9db_path} -n "burpsuite"
rm cacert.der
kill ${burp_pid}
