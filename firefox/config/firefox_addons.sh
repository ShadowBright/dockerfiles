#!/bin/bash

reg_firefox_addon() {

    url="https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/mozilla/mozilla-extension-manager"

    if [ ! -f mozilla-extension-manager ]; then
        echo "fetching file remotely..."

        wget --header='Accept-Encoding:none' -O mozilla-extension-manager ${url}

    fi

    sed -i 's/sudo//g' mozilla-extension-manager
    chmod +x mozilla-extension-manager

    ./mozilla-extension-manager --system --install "$1"
}

install_firefox_addons() {

    spFile="/etc/firefox/syspref.js"

    if [ -f ${spFile} ]; then
        rm ${spFile} then
    fi

    touch ${spFile}
    chmod +x ${spFile}

    echo 'pref("general.config.obscure_value", 0);' | tee -a /etc/firefox/syspref.js
    echo 'pref("general.config.filename", "firefox.cfg");'  | tee -a /etc/firefox/syspref.js

    cfgFile="/usr/lib/firefox/firefox.cfg"

    if [ -f ${cfgFile} ]; then
        rem ${cfgFile}
    fi

    touch ${cfgFile}
    chmod +x ${cfgFile}

    echo 'pref("browser.rights.3.shown", true);' | tee -a ${cfgFile}
    echo 'pref("extensions.autoDisableScopes", 0);'  | tee -a ${cfgFile}
    echo 'pref("extensions.enabledScopes", 15);' | tee -a ${cfgFile}
    echo 'pref("browser.startup.page", 1);' | tee -a ${cfgFile}
    echo 'pref("browser.startup.homepage", "http://www.google.com");' | tee -a ${cfgFile}
    echo 'pref("browser.shell.checkDefaultBrowser", false);' | tee -a ${cfgFile}
    echo 'pref("browser.search.defaultenginename", "Google");' | tee -a ${cfgFile}
    echo 'clearPref("extensions.lastAppVersion");' | tee -a ${cfgFile}
    echo 'lockPref("xpinstall.signatures.required", false);' | tee -a ${cfgFile}
    echo 'lockPref("plugins.hide_infobar_for_outdated_plugin", true);' | tee -a ${cfgFile}
    echo 'clearPref("plugins.update.url");' | tee -a ${cfgFile}

    #ublock-origin
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/607454/addon-607454-latest.xpi

    #disconnect
    #reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/464050/addon-464050-latest.xpi

    #ghostery
    #reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/9609/addon-9609-latest.xpi

    #user agent switcher
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/user-agent-switcher-revived/addon-11413026-latest.xpi

    #https-everywhere
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/229918/addon-229918-latest.xpi

    #noscript
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/722/addon-722-latest.xpi

    # neat url
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/neat-url/addon-6259307-latest.xpi

    # all tab helper
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/525044/addon-525044-latest.xpi

    # privacy settings
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/privacy-settings/addon-627512-latest.xpi

    # Google search link fix
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/google-search-link-fix/addon-351740-latest.xpi

    # clear flash cookies
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/file/781384/clear_flash_cookies-1.0.1-an+fx-linux.xpi

    #Decentraleyes
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/addon-521554-latest.xpi

    #canvas blocker
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/canvasblocker/addon-534930-latest.xpi
}



if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_firefox_addons
fi
