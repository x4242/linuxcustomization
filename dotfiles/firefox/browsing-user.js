// lastmod: 2020-01-18T10:39:36+01:00

user_pref("browser.download.useDownloadDir", false); // ask where to download files
user_pref("browser.download.manager.addToRecentDocs", false); // disable adding downloads to the system's "recent documents" list
user_pref("browser.newtabpage.enabled", false); // set newtab page to about:blank
user_pref("browser.startup.homepage", "about:blank"); // set home page to about:blank
user_pref("browser.startup.page", 0); // set start page to about:blank
user_pref("browser.urlbar.clickSelectsAll", true); // enable select whole address when clicking on it
user_pref("browser.urlbar.doubleClickSelectsAll", false); // disable select whole address when double-clicking on it

user_pref("signon.rememberSignons", false); // don't remeber logins



user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.cookies", true);
user_pref("privacy.clearOnShutdown.downloads", true);
user_pref("privacy.clearOnShutdown.formdata", true); // Form & Search History
user_pref("privacy.clearOnShutdown.history", true); // Browsing & Download History
user_pref("privacy.clearOnShutdown.offlineApps", true); // Offline Website Data
user_pref("privacy.clearOnShutdown.sessions", true); // Active Logins
user_pref("privacy.clearOnShutdown.siteSettings", true); // Site Preferences

user_pref("privacy.firstparty.isolate", true);
user_pref("privacy.history.custom", true);
user_pref("privacy.resistFingerprinting", true);
user_pref("privacy.trackingprotection.cryptomining.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);

user_pref("privacy.sanitize.sanitizeOnShutdown", true); // enable Firefox to clear items on shutdown

user_pref("geo.enabled", false);

user_pref("media.navigator.enabled", false);
user_pref("media.peerconnection.enabled", false);

user_pref("webgl.disabled", true);
