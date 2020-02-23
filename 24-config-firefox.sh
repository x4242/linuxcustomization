#!/usr/bin/env bash

# Description:
# ------------
# setup custom firefox profiles
#
# lastmod: 2020-01-18T11:04:49+01:00
# Change History:
# ---------------
#   - 2020-01-18:
#     - added yes/no checks before creating profiles
#     - added printfs for extensions and wget progressbar only (-q --show-progress)
#     - error correction on profile path
#     - added linking of user.js
#   - 2019-07-20: printf corrections

# String definitions for colored printf output
# [ ERROR ] in light red
# [ INFO  ] in light green
# [ INPUT ] in light yellow
STR_ERROR="[ \e[91mERROR\e[0m ]"
STR_INFO="[ \e[92mINFO\e[0m  ]"
STR_INPUT="[ \e[93mINPUT\e[0m ]"


# TODO
# insert check if firefox is running

# remove existing profiles and cache
rm -rf ~/.mozilla
rm -rf ~/.cache/mozilla

##########################################
# Create and configure browsing profile
##########################################
printf "%b Create \'browsing\' profile (y/n)? " "${STR_INPUT}"
read -r yes_no
case $yes_no in
  [Yy]* )
    printf "%b Creating \'browsing\' profile...\n" "${STR_INFO}"
    profile_name="browsing"
    firefox -CreateProfile ${profile_name}
    firefox -P ${profile_name} &
    firefox_pid=$!
    printf "%b Waiting 3 seconds then killing Firefox...\n" "${STR_INFO}"
    sleep 3s
    kill -15 ${firefox_pid}
    profile_path="$(echo ~/.mozilla/firefox/*${profile_name})"

    # Install addons for browsing profile
    printf "%b Downloading \'uBlock Origin\' extension...\n" "${STR_INFO}"
    wget -q --show-progress https://addons.mozilla.org/firefox/downloads/file/3027669/ublock_origin.xpi -O ${profile_path}/extensions/uBlock0@raymondhill.net.xpi
    printf "%b Downloading \'Ghostery\' extension...\n" "${STR_INFO}"
    wget -q --show-progress https://addons.mozilla.org/firefox/downloads/file/2345406/ghostery_privacy_ad_blocker.xpi -O ${profile_path}/extensions/firefox@ghostery.com.xpi
    printf "%b Downloading \'HTTPS Everywhere\' extension...\n" "${STR_INFO}"
    wget -q --show-progress https://addons.mozilla.org/firefox/downloads/file/3015452/https_everywhere.xpi -O ${profile_path}/extensions/https-everywhere@eff.org.xpi
    printf "%b Downloading \'Privacy Badger\' extension...\n" "${STR_INFO}"
    wget -q --show-progress https://addons.mozilla.org/firefox/downloads/file/1688114/privacy_badger.xpi -O ${profile_path}/extensions/jid1-MnnxcxisBPnSXQ@jetpack.xpi
    printf "%b Downloading \'Disconnect\' extension...\n" "${STR_INFO}"
    wget -q --show-progress https://addons.mozilla.org/firefox/downloads/file/621553/disconnect.xpi -O ${profile_path}/extensions/2.0@disconnect.me.xpi

    # link Firefox user.js
    ln -sf "$(pwd)"/dotfiles/firefox/browsing-user.js ${profile_path}/user.js
    printf "%b Done. Don't forget the enable plugins.\n" "${STR_INFO}"
    ;;
esac


##########################################
# Create and configure pentesting profile
##########################################
printf "%b Create \'pentesting\' profile (y/n)? " "${STR_INPUT}"
read -r yes_no
case $yes_no in
  [Yy]* )
    printf "%b Creating \'Browsing\' profile...\n" "${STR_INFO}"

    profile_name="pentesting"
    firefox -CreateProfile ${profile_name}
    firefox -P ${profile_name} &
    firefox_pid=$!
    sleep 3s
    kill -15 ${firefox_pid}

    # Install addons
    profile_path="$(dirname ~/.mozilla/firefox/*${profile_name})"
    extensions_path="${profile_path}/extensions)"
    printf "%b Downloading \'FoxyProxy\' extension...\n" "${STR_INFO}"
    wget -q --show-progress https://addons.mozilla.org/firefox/downloads/file/969185/foxyproxy_standard.xpi  -O ${extensions_path}/foxyproxy@eric.h.jung.xpi

    # Import firefox settings
    cp "$(pwd)"/dotfiles/firefox/pentesting-user.js ${profile_path}/user.js

    # Import burp cert: start burp in headless mode (yes for confirming tos), download cert, import cert into firefox, kill java
    # TODO: insert check if burp is installed
    yes | java -jar -Djava.awt.headless=true /usr/share/burpsuite/burpsuite.jar &
    burp_pid=$!
    sleep 3
    wget -e use_proxy=yes -e http_proxy=127.0.0.1:8080 http://burp/cert -O cacert.der
    cert9db_path=$(find ~/.mozilla/firefox/ -type d -name "*${profile_name}")
    certutil -A -t "TCu,Cu,Tu" -i cacert.der -d sql:${cert9db_path} -n "burpsuite"
    rm cacert.der
    kill ${burp_pid}
    ;;
esac
