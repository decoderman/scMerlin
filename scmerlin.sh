#!/bin/sh

######################################################
##               __  __              _  _           ##
##              |  \/  |            | |(_)          ##
##    ___   ___ | \  / |  ___  _ __ | | _  _ __     ##
##   / __| / __|| |\/| | / _ \| '__|| || || '_ \    ##
##   \__ \| (__ | |  | ||  __/| |   | || || | | |   ##
##   |___/ \___||_|  |_| \___||_|   |_||_||_| |_|   ##
##                                                  ##
##       https://github.com/jackyaz/scMerlin        ##
##                                                  ##
######################################################
# Last Modified: 2025-May-13
#-----------------------------------------------------

##########       Shellcheck directives     ###########
# shellcheck disable=SC2016
# shellcheck disable=SC2018
# shellcheck disable=SC2019
# shellcheck disable=SC2059
# shellcheck disable=SC2034
# shellcheck disable=SC2155
# shellcheck disable=SC3043
######################################################

### Start of script variables ###
readonly SCRIPT_NAME="scMerlin"
readonly SCRIPT_NAME_LOWER="$(echo "$SCRIPT_NAME" | tr 'A-Z' 'a-z' | sed 's/d//')"
readonly SCM_VERSION="v2.5.20"
readonly SCRIPT_VERSION="v2.5.20"
SCRIPT_BRANCH="master"
SCRIPT_REPO="https://raw.githubusercontent.com/decoderman/$SCRIPT_NAME/$SCRIPT_BRANCH"
readonly SCRIPT_DIR="/jffs/addons/$SCRIPT_NAME_LOWER.d"
readonly SCRIPT_WEBPAGE_DIR="$(readlink -f /www/user)"
readonly SCRIPT_WEB_DIR="$SCRIPT_WEBPAGE_DIR/$SCRIPT_NAME_LOWER"
readonly SHARED_DIR="/jffs/addons/shared-jy"
readonly SHARED_REPO="https://raw.githubusercontent.com/decoderman/shared-jy/master"
readonly SHARED_WEB_DIR="$SCRIPT_WEBPAGE_DIR/shared-jy"
readonly TEMP_MENU_TREE="/tmp/menuTree.js"
readonly NTP_WATCHDOG_FILE="$SCRIPT_DIR/.watchdogenabled"
readonly TAIL_TAINTED_FILE="$SCRIPT_DIR/.tailtaintdnsenabled"

##----------------------------------------##
## Modified by Martinski W. [2024-Jun-07] ##
##----------------------------------------##
readonly NTP_READY_CHECK_KEYN="NTP_Ready_Check"
readonly NTP_READY_CHECK_FILE="NTP_Ready_Config"
readonly NTP_READY_CHECK_CONF="$SCRIPT_DIR/$NTP_READY_CHECK_FILE"
isInteractiveMenuMode=false

if [ -z "$(which crontab)" ]
then cronListCmd="cru l"
else cronListCmd="crontab -l"
fi

[ -z "$(nvram get odmpid)" ] && ROUTER_MODEL="$(nvram get productid)" || ROUTER_MODEL="$(nvram get odmpid)"
ROUTER_MODEL="$(echo "$ROUTER_MODEL" | tr 'a-z' 'A-Z')"
### End of script variables ###

### Start of output format variables ###
readonly CRIT="\\e[41m"
readonly ERR="\\e[31m"
readonly WARN="\\e[33m"
readonly PASS="\\e[32m"
readonly BOLD="\\e[1m"
readonly SETTING="${BOLD}\\e[36m"
readonly CLEARFORMAT="\\e[0m"

##-------------------------------------##
## Added by Martinski W. [2024-Apr-28] ##
##-------------------------------------##
readonly CLRct="\e[0m"
readonly REDct="\e[1;31m"
readonly GRNct="\e[1;32m"
readonly YLWct="\e[1;33m"
readonly BOLDUNDERLN="\e[1;4m"

##-------------------------------------##
## Added by Martinski W. [2025-Feb-11] ##
##-------------------------------------##
readonly scriptVersRegExp="v[0-9]{1,2}([.][0-9]{1,2})([.][0-9]{1,2})"
readonly webPageMenuAddons="menuName: \"Addons\","
readonly webPageHelpSupprt="tabName: \"Help & Support\"},"
readonly webPageFileRegExp="user([1-9]|[1-2][0-9])[.]asp"
readonly webPageLineTabExp="\{url: \"$webPageFileRegExp\", tabName: "
readonly webPageSiteMpRegExp="${webPageLineTabExp}\"Sitemap\"\},"
readonly webPageScriptRegExp="${webPageLineTabExp}\"$SCRIPT_NAME\"\},"
readonly BEGIN_MenuAddOnsTag="/\*\*BEGIN:_AddOns_\*\*/"
readonly ENDIN_MenuAddOnsTag="/\*\*ENDIN:_AddOns_\*\*/"

### End of output format variables ###

# Give priority to built-in binaries #
export PATH="/bin:/usr/bin:/sbin:/usr/sbin:$PATH"

##----------------------------------------##
## Modified by Martinski W. [2024-Jun-03] ##
##----------------------------------------##
readonly SUPPORTstr="$(nvram get rc_support)"

Band_24G_Support=false
Band_5G_1_Support=false
Band_5G_2_support=false
Band_6G_1_Support=false
Band_6G_2_Support=false

if echo "$SUPPORTstr" | grep -qo '2.4G '
then Band_24G_Support=true ; fi

if echo "$SUPPORTstr" | grep -qo '5G '
then Band_5G_1_Support=true ; fi

if echo "$SUPPORTstr" | grep -qw 'wifi6e'
then Band_6G_1_Support=true ; fi

##-------------------------------------##
## Added by Martinski W. [2025-Feb-15] ##
##-------------------------------------##
GetWiFiVirtualInterfaceName()
{
   if [ $# -eq 0 ] || [ -z "$1" ] ; then echo "" ; return 1 ; fi
   nvram show 2>/dev/null | grep -E -m1 "^wl[0-3]_ifname=${1}" | awk -F '_' '{print $1}'
}

##----------------------------------------##
## Modified by Martinski W. [2025-Feb-15] ##
##----------------------------------------##
_GetWiFiBandsSupported_()
{
   local wifiIFNameList  wifiIFName  wifiBandInfo  wifiBandName
   local wifi5GHzCount=0  wifi6GHzCount=0  wlvifName  wifiChnList

   case "$ROUTER_MODEL" in
       "GT-BE98" | "GT-AXE16000" | \
       "GT-AX11000" | "GT-AX11000_PRO" | "XT12")
           Band_5G_2_Support=true
           ;;
       "GT-BE98" | "GT-BE98_PRO" | "RT-BE96U" | \
       "GT-AXE16000" | "GT-AXE11000")
           Band_6G_1_Support=true
           ;;
       "GT-BE98_PRO")
           Band_6G_2_Support=true
           ;;
   esac

   wifiIFNameList="$(nvram get wl_ifnames)"
   if [ -z "$wifiIFNameList" ]
   then
       printf "\n**ERROR**: WiFi Interface List is *NOT* found.\n"
       return 1
   fi

   for wifiIFName in $wifiIFNameList
   do
       wifiBandInfo="$(wl -i "$wifiIFName" status 2>/dev/null | grep 'Chanspec:')"
       if [ -z "$wifiBandInfo" ]
       then
           if [ "$(wl -i "$wifiIFName" bss 2>/dev/null)" = "up" ]
           then
               printf "\n**ERROR**: Could not find 'Chanspec' for WiFi Interface [$wifiIFName].\n"
           fi
           wlvifName="$(GetWiFiVirtualInterfaceName "$wifiIFName")"
           if [ -n "wlvifName" ]
           then
               wifiChnList="$(nvram get ${wlvifName}_chlist)"
               if [ "$wifiChnList" = "1 2 3 4 5 6 7 8 9 10 11" ]
               then Band_24G_Support=true
               elif echo "$wifiChnList" | grep -qE "^36 40 44 48"
               then Band_5G_1_Support=true
               elif echo "$wifiChnList" | grep -qE "^149 153 157 161"
               then Band_5G_2_Support=true
               fi
           fi
           continue
       fi
       wifiBandName="$(echo "$wifiBandInfo" | awk -F ' ' '{print $2}')"

       case "$wifiBandName" in
           2.4GHz) Band_24G_Support=true
                   ;;
             5GHz) let wifi5GHzCount++
                   [ "$wifi5GHzCount" -eq 1 ] && Band_5G_1_Support=true
                   [ "$wifi5GHzCount" -eq 2 ] && Band_5G_2_support=true
                   ;;
             6GHz) let wifi6GHzCount++
                   [ "$wifi6GHzCount" -eq 1 ] && Band_6G_1_Support=true
                   [ "$wifi6GHzCount" -eq 2 ] && Band_6G_2_Support=true
                   ;;
                *) printf "\nWiFi Interface=[$wifiIFName], WiFi Band=[$wifiBandName]\n"
                   ;;
       esac
   done
}

_GetWiFiBandsSupported_

##----------------------------------------##
## Modified by Martinski W. [2025-Feb-15] ##
##----------------------------------------##
GetIFaceName()
{
    if [ $# -eq 0 ] || [ -z "$1" ]
    then echo ; return 1 ; fi

    theIFnamePrefix=""
    case "$1" in
        "2.4GHz")
            if [ "$ROUTER_MODEL" = "GT-BE98" ] || \
               [ "$ROUTER_MODEL" = "GT-BE98_PRO" ] || \
               [ "$ROUTER_MODEL" = "GT-AXE16000" ]
            then theIFnamePrefix="wl3"
            elif "$Band_24G_Support"
            then theIFnamePrefix="wl0"
            fi
            ;;
        "5GHz_1")
            if [ "$ROUTER_MODEL" = "GT-BE98" ] || \
               [ "$ROUTER_MODEL" = "GT-BE98_PRO" ] || \
               [ "$ROUTER_MODEL" = "GT-AXE16000" ]
            then theIFnamePrefix="wl0"
            elif "$Band_5G_1_Support"
            then theIFnamePrefix="wl1"
            fi
            ;;
        "5GHz_2")
            if [ "$ROUTER_MODEL" = "GT-BE98" ] || \
               [ "$ROUTER_MODEL" = "GT-AXE16000" ]
            then theIFnamePrefix="wl1"
            elif "$Band_5G_2_support"
            then theIFnamePrefix="wl2"
            fi
            ;;
        "6GHz_1")
            if [ "$ROUTER_MODEL" = "GT-BE98_PRO" ]
            then theIFnamePrefix="wl1"
            elif "$Band_6G_1_Support"
            then theIFnamePrefix="wl2"
            fi
            ;;
        "6GHz_2")
            if "$Band_6G_2_Support" || \
               [ "$ROUTER_MODEL" = "GT-BE98_PRO" ]
            then theIFnamePrefix="wl2" ; fi
            ;;
    esac
    if [ -z "$theIFnamePrefix" ]
    then echo ""
    else echo "$(nvram get "${theIFnamePrefix}_ifname")"
    fi
}

##----------------------------------------##
## Modified by Martinski W. [2025-Feb-15] ##
##----------------------------------------##
GetTemperatureValue()
{
   local theIFname  theTemprtr  wifiRadioState=""
   theIFname="$(GetIFaceName "$1")"
   if [ -z "$theIFname" ]
   then
       echo "DISABLED"
   else
       theTemprtr="$(wl -i "$theIFname" phy_tempsense 2>/dev/null)"
       if [ -z "$theTemprtr" ]
       then
           wlvifName="$(GetWiFiVirtualInterfaceName "$theIFname")"
           [ -n "wlvifName" ] && \
           wifiRadioState="$(nvram get ${wlvifName}_radio)"
           if [ "$wifiRadioState" = "0" ]
           then echo "[WiFi Radio for '${theIFname}' is DISABLED]"
           elif [ "$(wl -i "$theIFname" bss 2>/dev/null)" = "down" ]
           then echo "[Base Station for '${theIFname}' is DISABLED]"
           else echo "[WiFi Interface '${theIFname}' is DISABLED]"
           fi
       else
           echo "$theTemprtr" | awk -F ' ' '{print $1/2+20}'
       fi
   fi
}

##-------------------------------------##
## Added by Martinski W. [2025-Feb-15] ##
##-------------------------------------##
GetTemperatureString()
{
    if [ $# -eq 0 ] || [ -z "$1" ]
    then printf "${REDct}*Unknown*${CLRct}"
    fi
    if ! echo "$1" | grep -qE "^[0-9].*"
    then printf "${REDct}%s${CLRct}" "$theTemptrVal"
    else printf "${GRNct}%s°C${CLRct}" "$theTemptrVal"
    fi
}

##----------------------------------------##
## Modified by Martinski W. [2025-Feb-11] ##
##----------------------------------------##
# $1 = print to syslog, $2 = message to print, $3 = log level
Print_Output()
{
	local prioStr  prioNum
	if [ $# -gt 2 ] && [ -n "$3" ]
	then prioStr="$3"
	else prioStr="NOTICE"
	fi
	if [ "$1" = "true" ]
	then
		case "$prioStr" in
		    "$CRIT") prioNum=2 ;;
		     "$ERR") prioNum=3 ;;
		    "$WARN") prioNum=4 ;;
		    "$PASS") prioNum=6 ;; #INFO#
		          *) prioNum=5 ;; #NOTICE#
		esac
		logger -t "$SCRIPT_NAME" -p $prioNum "$2"
	fi
	printf "${BOLD}${3}%s${CLEARFORMAT}\n\n" "$2"
}

Firmware_Version_Check()
{
	if nvram get rc_support | grep -qF "am_addons"; then
		return 0
	else
		return 1
	fi
}

### Code for these functions inspired by https://github.com/Adamm00 - credit to @Adamm ###
Check_Lock()
{
	if [ -f "/tmp/$SCRIPT_NAME_LOWER.lock" ]
	then
		ageoflock=$(($(date +%s) - $(date +%s -r "/tmp/$SCRIPT_NAME_LOWER.lock")))
		if [ "$ageoflock" -gt 60 ]
		then
			Print_Output true "Stale lock file found (>60 seconds old) - purging lock" "$ERR"
			kill "$(sed -n '1p' "/tmp/$SCRIPT_NAME_LOWER.lock")" >/dev/null 2>&1
			Clear_Lock
			echo "$$" > "/tmp/$SCRIPT_NAME_LOWER.lock"
			return 0
		else
			Print_Output true "Lock file found (age: $ageoflock seconds)" "$ERR"
			if [ -z "$1" ]; then
				exit 1
			else
				return 1
			fi
		fi
	else
		echo "$$" > "/tmp/$SCRIPT_NAME_LOWER.lock"
		return 0
	fi
}

Clear_Lock(){
	rm -f "/tmp/$SCRIPT_NAME_LOWER.lock" 2>/dev/null
	return 0
}

##----------------------------------------##
## Modified by Martinski W. [2025-Feb-11] ##
##----------------------------------------##
Set_Version_Custom_Settings()
{
	SETTINGSFILE="/jffs/addons/custom_settings.txt"
	case "$1" in
		local)
			if [ -f "$SETTINGSFILE" ]
			then
				if [ "$(grep -c "^scmerlin_version_local" $SETTINGSFILE)" -gt 0 ]
				then
					if [ "$2" != "$(grep "^scmerlin_version_local" "$SETTINGSFILE" | cut -f2 -d' ')" ]
					then
						sed -i "s/^scmerlin_version_local.*/scmerlin_version_local $2/" "$SETTINGSFILE"
					fi
				else
					echo "scmerlin_version_local $2" >> "$SETTINGSFILE"
				fi
			else
				echo "scmerlin_version_local $2" >> "$SETTINGSFILE"
			fi
		;;
		server)
			if [ -f "$SETTINGSFILE" ]
			then
				if [ "$(grep -c "^scmerlin_version_server" $SETTINGSFILE)" -gt 0 ]
				then
					if [ "$2" != "$(grep "^scmerlin_version_server" "$SETTINGSFILE" | cut -f2 -d' ')" ]
					then
						sed -i "s/^scmerlin_version_server.*/scmerlin_version_server $2/" "$SETTINGSFILE"
					fi
				else
					echo "scmerlin_version_server $2" >> "$SETTINGSFILE"
				fi
			else
				echo "scmerlin_version_server $2" >> "$SETTINGSFILE"
			fi
		;;
	esac
}

##----------------------------------------##
## Modified by Martinski W. [2025-Feb-11] ##
##----------------------------------------##
Update_Check()
{
	echo 'var updatestatus = "InProgress";' > "$SCRIPT_WEB_DIR/detect_update.js"
	doupdate="false"
	localver="$(grep "SCRIPT_VERSION=" "/jffs/scripts/$SCRIPT_NAME_LOWER" | grep -m1 -oE "$scriptVersRegExp")"
	curl -fsL --retry 4 --retry-delay 5 "$SCRIPT_REPO/$SCRIPT_NAME_LOWER.sh" | grep -qF "jackyaz" || \
    { Print_Output true "404 error detected - stopping update" "$ERR"; return 1; }
	serverver="$(curl -fsL --retry 4 --retry-delay 5 "$SCRIPT_REPO/$SCRIPT_NAME_LOWER.sh" | grep "SCRIPT_VERSION=" | grep -m1 -oE "$scriptVersRegExp")"
	if [ "$localver" != "$serverver" ]
	then
		doupdate="version"
		Set_Version_Custom_Settings server "$serverver"
		echo 'var updatestatus = "'"$serverver"'";'  > "$SCRIPT_WEB_DIR/detect_update.js"
	else
		localmd5="$(md5sum "/jffs/scripts/$SCRIPT_NAME_LOWER" | awk '{print $1}')"
		remotemd5="$(curl -fsL --retry 4 --retry-delay 5 "$SCRIPT_REPO/$SCRIPT_NAME_LOWER.sh" | md5sum | awk '{print $1}')"
		if [ "$localmd5" != "$remotemd5" ]
		then
			doupdate="md5"
			Set_Version_Custom_Settings server "$serverver-hotfix"
			echo 'var updatestatus = "'"$serverver-hotfix"'";'  > "$SCRIPT_WEB_DIR/detect_update.js"
		fi
	fi
	if [ "$doupdate" = "false" ]; then
		echo 'var updatestatus = "None";' > "$SCRIPT_WEB_DIR/detect_update.js"
	fi
	echo "$doupdate,$localver,$serverver"
}

##---------------------------------------##
## Added by ExtremeFiretop [2025-May-15] ##
##---------------------------------------##
append_statejs_snippet() {
    cat << 'EOF'
function GenerateSiteMap(showurls){
    myMenu = [];
    if (typeof menuList == 'undefined' || menuList == null) {
        setTimeout(GenerateSiteMap, 1000, false);
        return;
    }
    for (var i = 0; i < menuList.length; i++) {
        var myobj = {};
        myobj.menuName = menuList[i].menuName;
        myobj.index    = menuList[i].index;
        var myTabs = menuList[i].tab.filter(function(item){
            return !menuExclude.tabs.includes(item.url);
        });
        myTabs = myTabs.filter(function(item){
            if (item.tabName == '__INHERIT__' && item.url == 'NULL') {
                return false;
            } else {
                return true;
            }
        });
        // ? changed: remove *all* __HIDE__ entries, regardless of URL
        myTabs = myTabs.filter(function(item){
            return item.tabName !== '__HIDE__';
        });
        myobj.tabs = myTabs;
        myMenu.push(myobj);
    }
    myMenu = myMenu.filter(function(item) {
        return !menuExclude.menus.includes(item.index);
    });
    myMenu = myMenu.filter(function(item) {
        return item.index != 'menu_Split';
    });
    var sitemapstring = '';
    for (var i = 0; i < myMenu.length; i++) {
        sitemapstring +=
            '<span style="font-size:14px;background-color:#4D595D;">' +
            '<b>' + myMenu[i].menuName + '</b></span><br>';
        for (var i2 = 0; i2 < myMenu[i].tabs.length; i2++) {
            var tab = myMenu[i].tabs[i2];
            var tabname = (tab.tabName == '__INHERIT__')
                        ? tab.url.split('.')[0]
                        : tab.tabName;
            var taburl  = (tab.url.indexOf('redirect.htm') != -1)
                        ? '/ext/shared-jy/redirect.htm'
                        : tab.url;
            if (showurls) {
                sitemapstring +=
                    '<a style="text-decoration:underline;background-color:#4D595D;" ' +
                    'href="' + taburl + '" target="_blank">' + tabname +
                    '</a> - ' + taburl + '<br>';
            } else {
                sitemapstring +=
                    '<a style="text-decoration:underline;background-color:#4D595D;" ' +
                    'href="' + taburl + '" target="_blank">' + tabname +
                    '</a><br>';
            }
        }
        sitemapstring += '<br>';
    }
    return sitemapstring;
}
(function(){
  if (window._stateEnhancedInjected) return;
  window._stateEnhancedInjected = true;
  const CACHE_KEY = 'stateEnhanced_menuListCache';
  function readCache(){
    try {
      return JSON.parse(localStorage.getItem(CACHE_KEY)) || {};
    } catch {
      return {};
    }
  }
  function writeCache(list, exclude){
    localStorage.setItem(CACHE_KEY,
      JSON.stringify({ menuList: list, menuExclude: exclude })
    );
  }
  (function watchForSetup(){
    if (location.pathname.endsWith('index.asp')) {
      if (!window.menuList || !window.menuExclude) {
        const { menuList, menuExclude } = readCache();
        if (menuList && menuExclude) {
          window.menuList    = menuList;
          window.menuExclude = menuExclude;
        } else {
          return setTimeout(watchForSetup, 200);
        }
      }
      window.addEventListener('load', () => {
        buildMyMenu();
        injectDropdowns();
      });
      return;
    }
    if (
      Array.isArray(window.menuList) && window.menuList.length &&
      window.menuExclude &&
      Array.isArray(window.menuExclude.tabs) &&
      Array.isArray(window.menuExclude.menus)
    ) {
      if (!readCache().menuList) {
        writeCache(window.menuList, window.menuExclude);
      }
      buildMyMenu();
      injectDropdowns();
    } else {
      setTimeout(watchForSetup, 200);
    }
  })();
  function buildMyMenu(){
    if (window.myMenu && window.myMenu.length) return;
    const cache   = readCache();
    const exclude = (window.menuExclude && Array.isArray(window.menuExclude.tabs))
                    ? window.menuExclude
                    : (cache.menuExclude || { tabs: [], menus: [] });
    const hidden  = new Set([...(exclude.menus||[]), 'menu_Split']);
    const src     = Array.isArray(window.menuList) && window.menuList.length
                    ? window.menuList
                    : (cache.menuList || []);
    window.myMenu = src
      .filter(m => !hidden.has(m.index))
      .map(m => ({
        menuName: m.menuName,
        index:    m.index,
        tabs:     (m.tab||[])
                    .filter(t => !exclude.tabs.includes(t.url))
                    .filter(t => !(t.tabName==='__INHERIT__' && t.url==='NULL'))
                    .filter(t => !(t.tabName==='__HIDE__'   && t.url==='NULL'))
                    .filter(t => t.tabName!=='__HIDE__')
      }))
      .filter(m => m.tabs.length > 0);
  }
  function injectDropdowns(){
    if (!Array.isArray(window.myMenu)) return;
    window.myMenu.forEach(menu => {
      let icon = document.getElementsByClassName(menu.index)[0];
      if (!icon) {
        const id = menu.index.replace(/^menu_/, '') + '_menu';
        icon = document.getElementById(id);
      }
      if (!icon || icon._injected) return;
      icon._injected = true;
      let html = '<div class="dropdown-content">';
      menu.tabs.forEach(t => {
        const name = (t.tabName==='__INHERIT__') ? t.url.split('.')[0] : t.tabName;
        const url  = t.url.includes('redirect.htm')
                   ? '/ext/shared-jy/redirect.htm'
                   : t.url;
        html += `<a href="${url}" target="_self">${name}</a>`;
      });
      html += '</div>';
      const container = icon.closest('.menu') || icon.parentElement;
      container.classList.add('dropdown');
      container.insertAdjacentHTML('beforeend', html);
      const dd = container.querySelector('.dropdown-content');
      icon.addEventListener('click', e => {
        e.stopPropagation();
        dd.style.display = (dd.style.display==='block') ? 'none' : 'block';
      });
      dd.addEventListener('click', e => e.stopPropagation());
    });
  }
  function rehookShowMenu(){
    if (typeof show_menu !== 'function') return;
    const orig = show_menu;
    show_menu = function(...args){
      orig.apply(this, args);
      buildMyMenu();
      injectDropdowns();
    };
  }
  function init(){
    rehookShowMenu();
    document.addEventListener('click', () => {
      document.querySelectorAll('.dropdown-content')
              .forEach(el => { if (el.style.display==='block') el.style.display = 'none'; });
    });
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
  window.addEventListener('load', ()=>{
    buildMyMenu();
    injectDropdowns();
  });
})();
EOF
}

##---------------------------------------##
## Added by ExtremeFiretop [2025-May-13] ##
##---------------------------------------##
Upgrade_StateJS() {
    STATE_JS="/tmp/state.js"
    [ -f "$STATE_JS" ] || return 0

    if grep -q "var myMenu = \[\];" "$STATE_JS"; then
        umount /www/state.js 2>/dev/null

        # 2) remove old snippet into a temp file
        TMP="/tmp/state-tmp.js"
        sed '/^var myMenu = \[\];$/,/^GenerateSiteMap(false); AddDropdowns();$/d' "$STATE_JS" > "$TMP"

        # 3) overwrite state.js with the stripped version
        mv "$TMP" "$STATE_JS"

        # append the shared snippet
        append_statejs_snippet >> "$STATE_JS"

        mount -o bind /tmp/state.js /www/state.js
    fi
}

##------------------------------------------##
## Modified by ExtremeFiretop [2025-May-13] ##
##------------------------------------------##
Update_Version()
{
	if [ $# -eq 0 ] || [ -z "$1" ]
	then
		updatecheckresult="$(Update_Check)"
		isupdate="$(echo "$updatecheckresult" | cut -f1 -d',')"
		localver="$(echo "$updatecheckresult" | cut -f2 -d',')"
		serverver="$(echo "$updatecheckresult" | cut -f3 -d',')"

		if [ "$isupdate" = "version" ]; then
			Print_Output true "New version of $SCRIPT_NAME available - $serverver" "$PASS"
		elif [ "$isupdate" = "md5" ]; then
			Print_Output true "MD5 hash of $SCRIPT_NAME does not match - hotfix available - $serverver" "$PASS"
		fi

		if [ "$isupdate" != "false" ]
		then
			printf "\n${BOLD}Do you want to continue with the update? (y/n)${CLEARFORMAT}  "
			read -r confirm
			case "$confirm" in
				y|Y)
					printf "\n"
					Update_File shared-jy.tar.gz
					Upgrade_StateJS
					Update_File scmerlin_www.asp
					Update_File sitemap.asp
					Update_File tailtop
					Update_File tailtopd
					Update_File tailtaintdns
					Update_File tailtaintdnsd
					Update_File sc.func
					Update_File S99tailtop
					Update_File S95tailtaintdns
					Download_File "$SCRIPT_REPO/$SCRIPT_NAME_LOWER.sh" "/jffs/scripts/$SCRIPT_NAME_LOWER" && \
					Print_Output true "$SCRIPT_NAME successfully updated" "$PASS"
					chmod 0755 "/jffs/scripts/$SCRIPT_NAME_LOWER"
					Set_Version_Custom_Settings local "$serverver"
					Set_Version_Custom_Settings server "$serverver"
					Clear_Lock
					PressEnter
					exec "$0"
					exit 0
				;;
				*)
					printf "\n"
					Clear_Lock
					return 1
				;;
			esac
		else
			Print_Output true "No updates available - latest is $localver" "$WARN"
			Clear_Lock
		fi
	fi

	if [ "$1" = "force" ]
	then
		serverver="$(curl -fsL --retry 4 --retry-delay 5 "$SCRIPT_REPO/$SCRIPT_NAME_LOWER.sh" | grep "SCRIPT_VERSION=" | grep -m1 -oE "$scriptVersRegExp")"
		Print_Output true "Downloading latest version ($serverver) of $SCRIPT_NAME" "$PASS"
		Update_File shared-jy.tar.gz
		Upgrade_StateJS
		Update_File scmerlin_www.asp
		Update_File sitemap.asp
		Update_File tailtop
		Update_File tailtopd
		Update_File tailtaintdns
		Update_File tailtaintdnsd
		Update_File sc.func
		Update_File S99tailtop
		Update_File S95tailtaintdns
		Download_File "$SCRIPT_REPO/$SCRIPT_NAME_LOWER.sh" "/jffs/scripts/$SCRIPT_NAME_LOWER" && \
		Print_Output true "$SCRIPT_NAME successfully updated" "$PASS"
		chmod 0755 "/jffs/scripts/$SCRIPT_NAME_LOWER"
		Set_Version_Custom_Settings local "$serverver"
		Set_Version_Custom_Settings server "$serverver"
		Clear_Lock
		if [ $# -lt 2 ] || [ -z "$2" ]
		then
			PressEnter
			exec "$0"
		elif [ "$2" = "unattended" ]
		then
			exec "$0" postupdate
		fi
		exit 0
	fi
}

##----------------------------------------##
## Modified by Martinski W. [2025-Feb-11] ##
##----------------------------------------##
Update_File()
{
	if [ "$1" = "scmerlin_www.asp" ] || [ "$1" = "sitemap.asp" ]
	then
		tmpfile="/tmp/$1"
		if [ -f "$SCRIPT_DIR/$1" ]
		then
			Download_File "$SCRIPT_REPO/$1" "$tmpfile"
			if ! diff -q "$tmpfile" "$SCRIPT_DIR/$1" >/dev/null 2>&1
			then
				Get_WebUI_Page "$SCRIPT_DIR/$1"
				sed -i "\\~$MyWebPage~d" "$TEMP_MENU_TREE"
				rm -f "$SCRIPT_WEBPAGE_DIR/$MyWebPage" 2>/dev/null
				Download_File "$SCRIPT_REPO/$1" "$SCRIPT_DIR/$1"
				Print_Output true "New version of $1 downloaded" "$PASS"
				Mount_WebUI
			fi
			rm -f "$tmpfile"
		else
			Download_File "$SCRIPT_REPO/$1" "$SCRIPT_DIR/$1"
			Print_Output true "New version of $1 downloaded" "$PASS"
			Mount_WebUI
		fi
	elif [ "$1" = "shared-jy.tar.gz" ]
	then
		if [ ! -f "$SHARED_DIR/$1.md5" ]
		then
			Download_File "$SHARED_REPO/$1" "$SHARED_DIR/$1"
			Download_File "$SHARED_REPO/$1.md5" "$SHARED_DIR/$1.md5"
			tar -xzf "$SHARED_DIR/$1" -C "$SHARED_DIR"
			rm -f "$SHARED_DIR/$1"
			Print_Output true "New version of $1 downloaded" "$PASS"
		else
			localmd5="$(cat "$SHARED_DIR/$1.md5")"
			remotemd5="$(curl -fsL --retry 4 --retry-delay 5 "$SHARED_REPO/$1.md5")"
			if [ "$localmd5" != "$remotemd5" ]
			then
				Download_File "$SHARED_REPO/$1" "$SHARED_DIR/$1"
				Download_File "$SHARED_REPO/$1.md5" "$SHARED_DIR/$1.md5"
				tar -xzf "$SHARED_DIR/$1" -C "$SHARED_DIR"
				rm -f "$SHARED_DIR/$1"
				Print_Output true "New version of $1 downloaded" "$PASS"
			fi
		fi
	elif [ "$1" = "S99tailtop" ]
	then
		tmpfile="/tmp/$1"
		Download_File "$SCRIPT_REPO/$1" "$tmpfile"
		if ! diff -q "$tmpfile" "$SCRIPT_DIR/$1" >/dev/null 2>&1
		then
			if [ -f "$SCRIPT_DIR/S99tailtop" ]
			then
				"$SCRIPT_DIR/S99tailtop" stop >/dev/null 2>&1
				sleep 2
			fi
			Download_File "$SCRIPT_REPO/$1" "$SCRIPT_DIR/$1"
			chmod 0755 "$SCRIPT_DIR/$1"
			"$SCRIPT_DIR/S99tailtop" start >/dev/null 2>&1
			Print_Output true "New version of $1 downloaded" "$PASS"
		fi
		rm -f "$tmpfile"
	elif [ "$1" = "tailtop" ] || [ "$1" = "tailtopd" ]
	then
		tmpfile="/tmp/$1"
		Download_File "$SCRIPT_REPO/$1" "$tmpfile"
		if ! diff -q "$tmpfile" "$SCRIPT_DIR/$1" >/dev/null 2>&1
		then
			if [ -f "$SCRIPT_DIR/S99tailtop" ]
			then
				"$SCRIPT_DIR/S99tailtop" stop >/dev/null 2>&1
				sleep 2
			fi
			Download_File "$SCRIPT_REPO/$1" "$SCRIPT_DIR/$1"
			chmod 0755 "$SCRIPT_DIR/$1"
			"$SCRIPT_DIR/S99tailtop" start >/dev/null 2>&1
			Print_Output true "New version of $1 downloaded" "$PASS"
		fi
		rm -f "$tmpfile"
	elif [ "$1" = "S95tailtaintdns" ]
	then
		tmpfile="/tmp/$1"
		Download_File "$SCRIPT_REPO/$1" "$tmpfile"
		if ! diff -q "$tmpfile" "$SCRIPT_DIR/$1" >/dev/null 2>&1
		then
			if [ -f "$SCRIPT_DIR/S95tailtaintdns" ]
			then
				"$SCRIPT_DIR/S95tailtaintdns" stop >/dev/null 2>&1
				sleep 2
			fi
			Download_File "$SCRIPT_REPO/$1" "$SCRIPT_DIR/$1"
			chmod 0755 "$SCRIPT_DIR/$1"
			if [ "$(NTP_BootWatchdog status)" = "ENABLED" ]; then
				"$SCRIPT_DIR/S95tailtaintdns" start >/dev/null 2>&1
			fi
			Print_Output true "New version of $1 downloaded" "$PASS"
		fi
		rm -f "$tmpfile"
	elif [ "$1" = "tailtaintdns" ] || [ "$1" = "tailtaintdnsd" ]
	then
		tmpfile="/tmp/$1"
		Download_File "$SCRIPT_REPO/$1" "$tmpfile"
		if ! diff -q "$tmpfile" "$SCRIPT_DIR/$1" >/dev/null 2>&1
		then
			if [ -f "$SCRIPT_DIR/S95tailtaintdns" ]
			then
				"$SCRIPT_DIR/S95tailtaintdns" stop >/dev/null 2>&1
				sleep 2
			fi
			Download_File "$SCRIPT_REPO/$1" "$SCRIPT_DIR/$1"
			chmod 0755 "$SCRIPT_DIR/$1"
			if [ "$(NTP_BootWatchdog status)" = "ENABLED" ]; then
				"$SCRIPT_DIR/S95tailtaintdns" start >/dev/null 2>&1
			fi
			Print_Output true "New version of $1 downloaded" "$PASS"
		fi
		rm -f "$tmpfile"
	elif [ "$1" = "sc.func" ]
	then
		tmpfile="/tmp/$1"
		Download_File "$SCRIPT_REPO/$1" "$tmpfile"
		if ! diff -q "$tmpfile" "$SCRIPT_DIR/$1" >/dev/null 2>&1
		then
			Download_File "$SCRIPT_REPO/$1" "$SCRIPT_DIR/$1"
			chmod 0755 "$SCRIPT_DIR/$1"
			Print_Output true "New version of $1 downloaded" "$PASS"
		fi
		rm -f "$tmpfile"
	else
		return 1
	fi
}

Validate_Number()
{
	if [ "$1" -eq "$1" ] 2>/dev/null; then
		return 0
	else
		return 1
	fi
}

Create_Dirs()
{
	if [ ! -d "$SCRIPT_DIR" ]; then
		mkdir -p "$SCRIPT_DIR"
	fi

	if [ ! -d "$SHARED_DIR" ]; then
		mkdir -p "$SHARED_DIR"
	fi

	if [ ! -d "$SCRIPT_WEBPAGE_DIR" ]; then
		mkdir -p "$SCRIPT_WEBPAGE_DIR"
	fi

	if [ ! -d "$SCRIPT_WEB_DIR" ]; then
		mkdir -p "$SCRIPT_WEB_DIR"
	fi
}

##----------------------------------------##
## Modified by Martinski W. [2024-Apr-28] ##
##----------------------------------------##
Create_Symlinks()
{
	rm -rf "${SCRIPT_WEB_DIR:?}/"* 2>/dev/null

	ln -s /tmp/scmerlin-top "$SCRIPT_WEB_DIR/top.htm" 2>/dev/null
	ln -s /tmp/addonwebpages.tmp "$SCRIPT_WEB_DIR/addonwebpages.htm" 2>/dev/null
	ln -s /tmp/scmcronjobs.tmp "$SCRIPT_WEB_DIR/scmcronjobs.htm" 2>/dev/null

	ln -s "$NTP_WATCHDOG_FILE" "$SCRIPT_WEB_DIR/watchdogenabled.htm" 2>/dev/null
	ln -s "$NTP_READY_CHECK_CONF" "$SCRIPT_WEB_DIR/${NTP_READY_CHECK_FILE}.htm" 2>/dev/null
	ln -s "$TAIL_TAINTED_FILE" "$SCRIPT_WEB_DIR/tailtaintdnsenabled.htm" 2>/dev/null

	if [ ! -d "$SHARED_WEB_DIR" ]; then
		ln -s "$SHARED_DIR" "$SHARED_WEB_DIR" 2>/dev/null
	fi
}

Auto_ServiceEvent()
{
	case $1 in
		create)
			if [ -f /jffs/scripts/service-event ]
			then
				STARTUPLINECOUNT=$(grep -c '# '"$SCRIPT_NAME" /jffs/scripts/service-event)
				STARTUPLINECOUNTEX=$(grep -cx 'if echo "$2" | /bin/grep -q "'"$SCRIPT_NAME_LOWER"'"; then { /jffs/scripts/'"$SCRIPT_NAME_LOWER"' service_event "$@" & }; fi # '"$SCRIPT_NAME" /jffs/scripts/service-event)

				if [ "$STARTUPLINECOUNT" -gt 1 ] || { [ "$STARTUPLINECOUNTEX" -eq 0 ] && [ "$STARTUPLINECOUNT" -gt 0 ]; }; then
					sed -i -e '/# '"$SCRIPT_NAME"'/d' /jffs/scripts/service-event
				fi

				if [ "$STARTUPLINECOUNTEX" -eq 0 ]; then
					echo 'if echo "$2" | /bin/grep -q "'"$SCRIPT_NAME_LOWER"'"; then { /jffs/scripts/'"$SCRIPT_NAME_LOWER"' service_event "$@" & }; fi # '"$SCRIPT_NAME" >> /jffs/scripts/service-event
				fi
			else
				echo "#!/bin/sh" > /jffs/scripts/service-event
				echo "" >> /jffs/scripts/service-event
				echo 'if echo "$2" | /bin/grep -q "'"$SCRIPT_NAME_LOWER"'"; then { /jffs/scripts/'"$SCRIPT_NAME_LOWER"' service_event "$@" & }; fi # '"$SCRIPT_NAME" >> /jffs/scripts/service-event
				chmod 0755 /jffs/scripts/service-event
			fi
		;;
		delete)
			if [ -f /jffs/scripts/service-event ]; then
				STARTUPLINECOUNT=$(grep -i -c '# '"$SCRIPT_NAME" /jffs/scripts/service-event)

				if [ "$STARTUPLINECOUNT" -gt 0 ]; then
					sed -i -e '/# '"$SCRIPT_NAME"'/d' /jffs/scripts/service-event
				fi
			fi
		;;
	esac
}

##----------------------------------------##
## Modified by Martinski W. [2024-Mar-12] ##
##----------------------------------------##
Auto_Startup()
{
	case $1 in
		create)
			if [ -f /jffs/scripts/post-mount ]
			then
				STARTUPLINECOUNT=$(grep -i -c '# '"$SCRIPT_NAME$" /jffs/scripts/post-mount)

				if [ "$STARTUPLINECOUNT" -gt 0 ]; then
					sed -i -e '/# '"$SCRIPT_NAME$"'/d' /jffs/scripts/post-mount
				fi
			fi
			if [ -f /jffs/scripts/services-start ]
			then
				## Clean up erroneous entries ##
				grep -iq '# '"${SCRIPT_NAME}[$]$" /jffs/scripts/services-start && \
				sed -i -e '/# '"${SCRIPT_NAME}[$]$"'/d' /jffs/scripts/services-start

				STARTUPLINECOUNT=$(grep -i -c '# '"$SCRIPT_NAME$" /jffs/scripts/services-start)
				STARTUPLINECOUNTEX=$(grep -i -cx "/jffs/scripts/$SCRIPT_NAME_LOWER startup"' & # '"$SCRIPT_NAME$" /jffs/scripts/services-start)

				if [ "$STARTUPLINECOUNT" -gt 1 ] || { [ "$STARTUPLINECOUNTEX" -eq 0 ] && [ "$STARTUPLINECOUNT" -gt 0 ]; }; then
					sed -i -e '/# '"$SCRIPT_NAME$"'/d' /jffs/scripts/services-start
				fi

				if [ "$STARTUPLINECOUNTEX" -eq 0 ]; then
					echo "/jffs/scripts/$SCRIPT_NAME_LOWER startup"' & # '"$SCRIPT_NAME" >> /jffs/scripts/services-start
				fi
			else
				echo "#!/bin/sh" > /jffs/scripts/services-start
				echo "" >> /jffs/scripts/services-start
				echo "/jffs/scripts/$SCRIPT_NAME_LOWER startup"' & # '"$SCRIPT_NAME" >> /jffs/scripts/services-start
				chmod 0755 /jffs/scripts/services-start
			fi
		;;
		delete)
			if [ -f /jffs/scripts/post-mount ]; then
				STARTUPLINECOUNT=$(grep -i -c '# '"$SCRIPT_NAME$" /jffs/scripts/post-mount)

				if [ "$STARTUPLINECOUNT" -gt 0 ]; then
					sed -i -e '/# '"$SCRIPT_NAME$"'/d' /jffs/scripts/post-mount
				fi
			fi
			if [ -f /jffs/scripts/services-start ]; then
				## Clean up erroneous entries ##
				grep -iq '# '"${SCRIPT_NAME}[$]$" /jffs/scripts/services-start && \
				sed -i -e '/# '"${SCRIPT_NAME}[$]$"'/d' /jffs/scripts/services-start

				STARTUPLINECOUNT=$(grep -i -c '# '"$SCRIPT_NAME$" /jffs/scripts/services-start)

				if [ "$STARTUPLINECOUNT" -gt 0 ]; then
					sed -i -e '/# '"$SCRIPT_NAME$"'/d' /jffs/scripts/services-start
				fi
			fi
		;;
	esac
}

##----------------------------------------##
## Modified by Martinski W. [2025-Feb-11] ##
##----------------------------------------##
Download_File()
{ /usr/sbin/curl -LSs --retry 4 --retry-delay 5 --retry-connrefused "$1" -o "$2" ; }

##-------------------------------------##
## Added by Martinski W. [2025-Feb-11] ##
##-------------------------------------##
_Check_WebGUI_Page_Exists_()
{
   local webPageStr  webPageFile  webPageLineRegExp  theWebPage

   if [ $# -eq 0 ] || [ -z "$1" ] || [ ! -f "$TEMP_MENU_TREE" ]
   then echo "NONE" ; return 1 ; fi

   theWebPage="NONE"
   if [ "${1##*/}" = "sitemap.asp" ]
   then webPageLineRegExp="$webPageSiteMpRegExp"
   else webPageLineRegExp="$webPageScriptRegExp"
   fi
   webPageStr="$(grep -E -m1 "^$webPageLineRegExp" "$TEMP_MENU_TREE")"
   if [ -n "$webPageStr" ]
   then
       webPageFile="$(echo "$webPageStr" | grep -owE "$webPageFileRegExp" | head -n1)"
       if [ -n "$webPageFile" ] && [ -s "${SCRIPT_WEBPAGE_DIR}/$webPageFile" ]
       then theWebPage="$webPageFile" ; fi
   fi
   echo "$theWebPage"
}

##----------------------------------------##
## Modified by Martinski W. [2025-Feb-11] ##
##----------------------------------------##
Get_WebUI_Page()
{
	local webPageFile  webPagePath

	MyWebPage="$(_Check_WebGUI_Page_Exists_ "$1")"

	for indx in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
	do
		webPageFile="user${indx}.asp"
		webPagePath="${SCRIPT_WEBPAGE_DIR}/$webPageFile"

		if [ -s "$webPagePath" ] && \
		   [ "$(md5sum < "$1")" = "$(md5sum < "$webPagePath")" ]
		then
			MyWebPage="$webPageFile"
			break
		elif [ "$MyWebPage" = "NONE" ] && [ ! -s "$webPagePath" ]
		then
			MyWebPage="$webPageFile"
		fi
	done
}

### function based on @dave14305's FlexQoS webconfigpage function ###
##----------------------------------------##
## Modified by Martinski W. [2025-Feb-11] ##
##----------------------------------------##
Get_WebUI_URL()
{
	local urlPage=""  urlProto=""  urlDomain=""  urlPort=""

	if [ ! -f "$TEMP_MENU_TREE" ]
	then
		echo "**ERROR**: WebUI page NOT mounted"
		return 1
	fi

	urlPage="$(sed -nE "/$SCRIPT_NAME/ s/.*url\: \"(user[0-9]+\.asp)\".*/\1/p" "$TEMP_MENU_TREE")"

	if [ "$(nvram get http_enable)" -eq 1 ]; then
		urlProto="https"
	else
		urlProto="http"
	fi
	if [ -n "$(nvram get lan_domain)" ]; then
		urlDomain="$(nvram get lan_hostname).$(nvram get lan_domain)"
	else
		urlDomain="$(nvram get lan_ipaddr)"
	fi
	if [ "$(nvram get ${urlProto}_lanport)" -eq 80 ] || \
	   [ "$(nvram get ${urlProto}_lanport)" -eq 443 ]
	then
		urlPort=""
	else
		urlPort=":$(nvram get ${urlProto}_lanport)"
	fi

	if echo "$urlPage" | grep -qE "^${webPageFileRegExp}$" && \
	   [ -s "${SCRIPT_WEBPAGE_DIR}/$urlPage" ]
	then
		echo "${urlProto}://${urlDomain}${urlPort}/${urlPage}" | tr "A-Z" "a-z"
	else
		echo "**ERROR**: WebUI page NOT found"
	fi
}

##-------------------------------------##
## Added by Martinski W. [2025-Feb-16] ##
##-------------------------------------##
_CreateMenuAddOnsSection_()
{
   if grep -qE "^${webPageMenuAddons}$" "$TEMP_MENU_TREE" && \
      grep -qE "${webPageHelpSupprt}$" "$TEMP_MENU_TREE"
   then return 0 ; fi

   lineinsBefore="$(($(grep -n "^exclude:" "$TEMP_MENU_TREE" | cut -f1 -d':') - 1))"

   sed -i "$lineinsBefore""i\
${BEGIN_MenuAddOnsTag}\n\
,\n{\n\
${webPageMenuAddons}\n\
index: \"menu_Addons\",\n\
tab: [\n\
{url: \"javascript:var helpwindow=window.open('\/ext\/shared-jy\/redirect.htm')\", ${webPageHelpSupprt}\n\
{url: \"NULL\", tabName: \"__INHERIT__\"}\n\
]\n}\n\
${ENDIN_MenuAddOnsTag}" "$TEMP_MENU_TREE"
}

### locking mechanism code credit to Martineau (@MartineauUK) ###
##------------------------------------------##
## Modified by ExtremeFiretop [2025-May-13] ##
##------------------------------------------##
Mount_WebUI()
{
	realpage=""
	Print_Output true "Mounting WebUI tabs for $SCRIPT_NAME" "$PASS"
	LOCKFILE=/tmp/addonwebui.lock
	FD=386
	eval exec "$FD>$LOCKFILE"
	flock -x "$FD"
	Get_WebUI_Page "$SCRIPT_DIR/scmerlin_www.asp"
	if [ "$MyWebPage" = "NONE" ]
	then
		Print_Output true "**ERROR** Unable to mount $SCRIPT_NAME WebUI page, exiting" "$CRIT"
		flock -u "$FD"
		return 1
	fi
	cp -fp "$SCRIPT_DIR/scmerlin_www.asp" "$SCRIPT_WEBPAGE_DIR/$MyWebPage"
	echo "$SCRIPT_NAME" > "$SCRIPT_WEBPAGE_DIR/$(echo "$MyWebPage" | cut -f1 -d'.').title"

	if [ "$(uname -o)" = "ASUSWRT-Merlin" ]
	then
		if [ ! -f /tmp/index_style.css ]; then
			cp -fp /www/index_style.css /tmp/
		fi

		if ! grep -q '.menu_Addons' /tmp/index_style.css ; then
			echo ".menu_Addons { background: url(ext/shared-jy/addons.png); background-size: contain; }" >> /tmp/index_style.css
		fi

		if grep -q '.menu_Addons' /tmp/index_style.css && ! grep -q 'url(ext/shared-jy/addons.png); background-size: contain;' /tmp/index_style.css; then
			sed -i 's/addons.png);/addons.png); background-size: contain;/' /tmp/index_style.css
		fi

		if grep -q '.dropdown-content {display: block;}' /tmp/index_style.css ; then
			sed -i '/dropdown-content/d' /tmp/index_style.css
		fi

		if ! grep -q '.dropdown-content {visibility: visible;}' /tmp/index_style.css
		then
			{
				echo ".dropdown-content {top: 0px; left: 185px; visibility: hidden; position: absolute; background-color: #3a4042; min-width: 165px; box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 1000;}"
				echo ".dropdown-content a {padding: 6px 8px; text-decoration: none; display: block; height: 100%; min-height: 20px; max-height: 40px; font-weight: bold; text-shadow: 1px 1px 0px black; font-family: Verdana, MS UI Gothic, MS P Gothic, Microsoft Yahei UI, sans-serif; font-size: 12px; border: 1px solid #6B7071;}"
				echo ".dropdown-content a:hover {background-color: #77a5c6;}"
				echo ".dropdown:hover .dropdown-content {visibility: visible;}"
			} >> /tmp/index_style.css
		fi

		umount /www/index_style.css 2>/dev/null
		mount -o bind /tmp/index_style.css /www/index_style.css

		if [ ! -f "$TEMP_MENU_TREE" ]; then
			cp -fp /www/require/modules/menuTree.js "$TEMP_MENU_TREE"
		fi
		sed -i "\\~$MyWebPage~d" "$TEMP_MENU_TREE"

		_CreateMenuAddOnsSection_

		sed -i "/url: \"javascript:var helpwindow=window.open('\/ext\/shared-jy\/redirect.htm'/i {url: \"$MyWebPage\", tabName: \"$SCRIPT_NAME\"}," "$TEMP_MENU_TREE"
		realpage="$MyWebPage"

		if [ -f "$SCRIPT_DIR/sitemap.asp" ]
		then
			Get_WebUI_Page "$SCRIPT_DIR/sitemap.asp"
			if [ "$MyWebPage" = "NONE" ]
			then
				Print_Output true "**ERROR** Unable to mount $SCRIPT_NAME Sitemap page, exiting" "$CRIT"
				flock -u "$FD"
				return 1
			fi
			cp -fp "$SCRIPT_DIR/sitemap.asp" "$SCRIPT_WEBPAGE_DIR/$MyWebPage"
			sed -i "\\~$MyWebPage~d" "$TEMP_MENU_TREE"
			sed -i "/url: \"javascript:var helpwindow=window.open('\/ext\/shared-jy\/redirect.htm'/a {url: \"$MyWebPage\", tabName: \"Sitemap\"}," "$TEMP_MENU_TREE"

			umount /www/state.js 2>/dev/null
			cp -f /www/state.js /tmp/
			sed -i 's~<td width=\\"335\\" id=\\"bottom_help_link\\" align=\\"left\\">~<td width=\\"335\\" id=\\"bottom_help_link\\" align=\\"left\\"><a style=\\"font-weight: bolder;text-decoration:underline;cursor:pointer;\\" href=\\"\/'"$MyWebPage"'\\" target=\\"_blank\\">Sitemap<\/a>\&nbsp\|\&nbsp~' /tmp/state.js

			# append the same shared snippet
			append_statejs_snippet >> /tmp/state.js

			mount -o bind /tmp/state.js /www/state.js

			Print_Output true "Mounted Sitemap page as $MyWebPage" "$PASS"
		fi

		umount /www/require/modules/menuTree.js 2>/dev/null
		mount -o bind "$TEMP_MENU_TREE" /www/require/modules/menuTree.js
	fi
	flock -u "$FD"
	Print_Output true "Mounted $SCRIPT_NAME WebUI page as $realpage" "$PASS"
}

##-------------------------------------##
## Added by Martinski W. [2025-Feb-11] ##
##-------------------------------------##
_CheckFor_WebGUI_Page_()
{
   if [ "$(_Check_WebGUI_Page_Exists_ "scmerlin_www.asp")" = "NONE" ]
   then Mount_WebUI ; fi
}

##----------------------------------------##
## Modified by Martinski W. [2024-Sep-29] ##
##----------------------------------------##
Get_Cron_Jobs()
{
	printf "%-27s┌────────── minute (0 - 59)\\n" " "
	printf "%-27s│%-9s┌──────── hour (0 - 23)\\n" " " " "
	printf "%-27s│%-9s│%-9s┌────── day of month (1 - 31)\\n" " " " " " "
	printf "%-27s│%-9s│%-9s│%-9s┌──── month (1 - 12)\\n" " " " " " " " "
	printf "%-27s│%-9s│%-9s│%-9s│%-9s┌── day of week (0 - 6 => Sunday - Saturday)\\n" " " " " " " " " " "
	printf "%-27s│%-9s│%-9s│%-9s│%-9s│\\n" " " " " " " " " " "
	printf "%-27s↓%-9s↓%-9s↓%-9s↓%-9s↓\\n" " " " " " " " " " "
	printf "${GRNct}%-25s %-9s %-9s %-9s %-9s %-10s %s${CLEARFORMAT}\n" "Cron Job Name" "Min" "Hour" "DayM" "Month" "DayW" "Command"
	cronjobs="$(eval $cronListCmd | awk 'FS="#" {printf "%s %s\n",$2,$1}' | awk '{printf "%-25s %-9s %-9s %-9s %-9s %-10s ",$1,$2,$3,$4,$5,$6;for(i=7; i<=NF; ++i) printf "%s ", $i; print ""}')"
	echo "$cronjobs"
	eval $cronListCmd | sed 's/,/|/g' | awk 'FS="#" {printf "%s %s\n",$2,$1}' | \
	awk '{printf "\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"",$1,$2,$3,$4,$5,$6;for(i=7; i<=NF; ++i) printf "%s ", $i; print "\""}' | sed 's/ "$/"/g' > /tmp/scmcronjobs.tmp
}

Get_Addon_Pages()
{
	local urlProto=""  urlDomain=""  urlPort=""

	if [ "$(nvram get http_enable)" -eq 1 ]; then
		urlProto="https"
	else
		urlProto="http"
	fi
	if [ -n "$(nvram get lan_domain)" ]; then
		urlDomain="$(nvram get lan_hostname).$(nvram get lan_domain)"
	else
		urlDomain="$(nvram get lan_ipaddr)"
	fi
	if [ "$(nvram get ${urlProto}_lanport)" -eq 80 ] || \
	   [ "$(nvram get ${urlProto}_lanport)" -eq 443 ]
	then
		urlPort=""
	else
		urlPort=":$(nvram get ${urlProto}_lanport)"
	fi

	weburl="$(echo "${urlProto}://${urlDomain}${urlPort}/" | tr "A-Z" "a-z")"

	grep "user.*\.asp" "$TEMP_MENU_TREE" | awk -F'"' -v wu="$weburl" '{printf "%-12s "wu"%s\n",$4,$2}' | sort -f
	grep "user.*\.asp" "$TEMP_MENU_TREE" | awk -F'"' -v wu="$weburl" '{printf "%s,"wu"%s\n",$4,$2}' > /tmp/addonwebpages.tmp
}

##-------------------------------------##
## Added by Martinski W. [2024-Apr-28] ##
##-------------------------------------##
_WaitForConfirmation_()
{
   ! "$isInteractiveMenuMode" && return 0
   local promptStr

   if [ $# -eq 0 ] || [ -z "$1" ]
   then promptStr=" [yY|nN] N? "
   else promptStr="$1 [yY|nN] N? "
   fi

   printf "$promptStr" ; read -rn 3 YESorNO
   if echo "$YESorNO" | grep -qE "^([Yy](es)?)$"
   then echo "OK" ; return 0
   else echo "NO" ; return 1
   fi
}

##-------------------------------------##
## Added by Martinski W. [2024-Apr-29] ##
##-------------------------------------##
NTP_ReadyCheckOption()
{
	case "$1" in
		enable)
			echo "${NTP_READY_CHECK_KEYN}=ENABLED" > "$NTP_READY_CHECK_CONF" ;;
		disable)
			if "$isInteractiveMenuMode"
			then
			    printf "${REDct}**${YLWct}WARNING${REDct}**${CLRct}\n"
			    printf "You're about to disable the \"NTP Ready\" check. This is generally not recommended\n"
			    printf "unless you have some very specific conditions (e.g. WAN state is not connected).\n"
			    printf "Remember to re-enable the \"NTP Ready\" check as soon as you possibly can.\n\n"
			    if ! _WaitForConfirmation_ "Proceed to ${REDct}DISABLE${CLRct} the 'NTP Ready' check"
			    then return 1 ; fi
			fi
			echo "${NTP_READY_CHECK_KEYN}=DISABLED" > "$NTP_READY_CHECK_CONF"
			;;
		delete)
			rm -f "$NTP_READY_CHECK_CONF" ;;
		status)
			[ ! -f "$NTP_READY_CHECK_CONF" ] && \
			NTP_ReadyCheckOption enable

			if [ -f "$NTP_READY_CHECK_CONF" ] && \
			    grep -qE "^${NTP_READY_CHECK_KEYN}=ENABLED$" "$NTP_READY_CHECK_CONF"
			then
			    echo "ENABLED"
			else
			    echo "DISABLED"
			fi
		;;
	esac
}

##----------------------------------------##
## Modified by Martinski W. [2024-Apr-28] ##
##----------------------------------------##
NTP_BootWatchdog()
{
	case "$1" in
		enable)
			touch "$NTP_WATCHDOG_FILE"
			cat << "EOF" > /jffs/scripts/ntpbootwatchdog.sh
#!/bin/sh
# ntpbootwatchdog.sh (created by scMerlin).
#
if [ "$(nvram get ntp_ready)" -eq 1 ]
then
	/usr/bin/logger -st ntpbootwatchdog "NTP is synced, exiting"
else
	/usr/bin/logger -st ntpbootwatchdog "NTP boot watchdog started..."
	ntpTimerSecs=0
	while [ "$(nvram get ntp_ready)" -eq 0 ] && [ "$ntpTimerSecs" -lt 600 ]
	do
		if [ "$ntpTimerSecs" -gt 0 ] && [ "$((ntpTimerSecs % 30))" -eq 0 ]
		then
			/usr/bin/logger -st ntpbootwatchdog "Still waiting for NTP to sync [$ntpTimerSecs secs]..."
			killall ntp
			killall ntpd
			service restart_ntpd
		fi
		sleep 10
		ntpTimerSecs="$((ntpTimerSecs + 10))"
	done

	if [ "$ntpTimerSecs" -ge 600 ]; then
		/usr/bin/logger -st ntpbootwatchdog "NTP failed to sync after 10 minutes - please check immediately!"
		exit 1
	else
		/usr/bin/logger -st ntpbootwatchdog "NTP has synced!"
	fi
fi
EOF
			chmod +x /jffs/scripts/ntpbootwatchdog.sh
			if [ -f /jffs/scripts/init-start ]; then
				STARTUPLINECOUNT=$(grep -i -c 'ntpbootwatchdog' /jffs/scripts/init-start)
				if [ "$STARTUPLINECOUNT" -gt 0 ]; then
					sed -i -e '/ntpbootwatchdog/d' /jffs/scripts/init-start
				fi

				STARTUPLINECOUNT=$(grep -i -c '# '"$SCRIPT_NAME" /jffs/scripts/init-start)
				STARTUPLINECOUNTEX=$(grep -i -cx "sh /jffs/scripts/ntpbootwatchdog.sh & # $SCRIPT_NAME" /jffs/scripts/init-start)

				if [ "$STARTUPLINECOUNT" -gt 1 ] || { [ "$STARTUPLINECOUNTEX" -eq 0 ] && [ "$STARTUPLINECOUNT" -gt 0 ]; }; then
					sed -i -e '/# '"$SCRIPT_NAME"'/d' /jffs/scripts/init-start
				fi

				if [ "$STARTUPLINECOUNTEX" -eq 0 ]; then
					echo "sh /jffs/scripts/ntpbootwatchdog.sh & # $SCRIPT_NAME" >> /jffs/scripts/init-start
				fi
			else
				echo "#!/bin/sh" > /jffs/scripts/init-start
				echo "" >> /jffs/scripts/init-start
				echo "sh /jffs/scripts/ntpbootwatchdog.sh & # $SCRIPT_NAME" >> /jffs/scripts/init-start
				chmod 0755 /jffs/scripts/init-start
			fi
		;;
		disable)
			rm -f "$NTP_WATCHDOG_FILE"
			rm -f /jffs/scripts/ntpbootwatchdog.sh
			if [ -f /jffs/scripts/init-start ]; then
				STARTUPLINECOUNT=$(grep -i -c '# '"$SCRIPT_NAME" /jffs/scripts/init-start)

				if [ "$STARTUPLINECOUNT" -gt 0 ]; then
					sed -i -e '/# '"$SCRIPT_NAME"'/d' /jffs/scripts/init-start
				fi
			fi
		;;
		status)
			if [ -f /jffs/scripts/ntpbootwatchdog.sh ] && \
			   [ "$(grep -i -c '# '"$SCRIPT_NAME" /jffs/scripts/init-start)" -gt 0 ]
			then
				echo "ENABLED"
			else
				echo "DISABLED"
			fi
		;;
	esac
}

##----------------------------------------##
## Modified by Martinski W. [2024-Apr-29] ##
##----------------------------------------##
TailTaintDNSmasq()
{
	case "$1" in
		enable)
			touch "$TAIL_TAINTED_FILE"
			"$SCRIPT_DIR/S95tailtaintdns" start >/dev/null 2>&1
			if [ -f /jffs/scripts/services-start ]; then
				STARTUPLINECOUNT=$(grep -i -c '# '"$SCRIPT_NAME - tailtaintdns" /jffs/scripts/services-start)
				STARTUPLINECOUNTEX=$(grep -i -cx "$SCRIPT_DIR/S95tailtaintdns start >/dev/null 2>&1 & # $SCRIPT_NAME - tailtaintdns" /jffs/scripts/services-start)

				if [ "$STARTUPLINECOUNT" -gt 1 ] || { [ "$STARTUPLINECOUNTEX" -eq 0 ] && [ "$STARTUPLINECOUNT" -gt 0 ]; }; then
					sed -i -e '/# '"$SCRIPT_NAME - tailtaintdns"'/d' /jffs/scripts/services-start
				fi

				if [ "$STARTUPLINECOUNTEX" -eq 0 ]; then
					echo "$SCRIPT_DIR/S95tailtaintdns start >/dev/null 2>&1 & # $SCRIPT_NAME - tailtaintdns" >> /jffs/scripts/services-start
				fi
			else
				echo "#!/bin/sh" > /jffs/scripts/services-start
				echo "" >> /jffs/scripts/services-start
				echo "$SCRIPT_DIR/S95tailtaintdns start >/dev/null 2>&1 & # $SCRIPT_NAME - tailtaintdns" >> /jffs/scripts/services-start
				chmod 0755 /jffs/scripts/services-start
			fi
		;;
		disable)
			rm -f "$TAIL_TAINTED_FILE"
			"$SCRIPT_DIR/S95tailtaintdns" stop >/dev/null 2>&1
			if [ -f /jffs/scripts/services-start ]; then
				STARTUPLINECOUNT=$(grep -i -c '# '"$SCRIPT_NAME - tailtaintdns" /jffs/scripts/services-start)

				if [ "$STARTUPLINECOUNT" -gt 0 ]; then
					sed -i -e '/# '"$SCRIPT_NAME"' - tailtaintdns/d' /jffs/scripts/services-start
				fi
			fi
		;;
		status)
			if [ -f "$TAIL_TAINTED_FILE" ] && \
			   [ "$(grep -i -c '# '"$SCRIPT_NAME - tailtaintdns" /jffs/scripts/services-start)" -gt 0 ]
			then
				echo "ENABLED"
			else
				echo "DISABLED"
			fi
		;;
	esac
}

Process_Upgrade()
{
	if [ -f /opt/etc/init.d/S99tailtop ]
	then
		/opt/etc/init.d/S99tailtop stop >/dev/null 2>&1
		sleep 2
		rm -f /opt/etc/init.d/S99tailtop 2>/dev/null
		rm -f /opt/bin/tailtopd
		Update_File sc.func
		Update_File S99tailtop
		rm -f "$SCRIPT_DIR/.usbdisabled"
	fi
	if [ ! -f "$SCRIPT_DIR/S95tailtaintdns" ]
	then
		Update_File tailtaintdns
		Update_File tailtaintdnsd
		Update_File S95tailtaintdns
		rm -f "$SCRIPT_DIR/.usbdisabled"
	fi
	if [ ! -f "$SCRIPT_DIR/sitemap.asp" ]; then
		Update_File sitemap.asp
	fi

	if [ "$(uname -o)" = "ASUSWRT-Merlin" ]
	then
		if grep '.dropdown-content' /tmp/index_style.css | grep -q '{display: block;}'
		then
			umount /www/index_style.css 2>/dev/null
			cp -fp /www/index_style.css /tmp/

			echo ".menu_Addons { background: url(ext/shared-jy/addons.png); }" >> /tmp/index_style.css

			{
				echo ".dropdown-content {top: 0px; left: 185px; visibility: hidden; position: absolute; background-color: #3a4042; min-width: 165px; box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); z-index: 1000;}"
				echo ".dropdown-content a {padding: 6px 8px; text-decoration: none; display: block; height: 100%; min-height: 20px; max-height: 40px; font-weight: bold; text-shadow: 1px 1px 0px black; font-family: Verdana, MS UI Gothic, MS P Gothic, Microsoft Yahei UI, sans-serif; font-size: 12px; border: 1px solid #6B7071;}"
				echo ".dropdown-content a:hover {background-color: #77a5c6;}"
				echo ".dropdown:hover .dropdown-content {visibility: visible;}"
			} >> /tmp/index_style.css

			mount -o bind /tmp/index_style.css /www/index_style.css
		fi
	fi
}

Shortcut_Script()
{
	case $1 in
		create)
			if [ -d /opt/bin ] && [ ! -f "/opt/bin/$SCRIPT_NAME_LOWER" ] && [ -f "/jffs/scripts/$SCRIPT_NAME_LOWER" ]
			then
				ln -s "/jffs/scripts/$SCRIPT_NAME_LOWER" /opt/bin
				chmod 0755 "/opt/bin/$SCRIPT_NAME_LOWER"
			fi
		;;
		delete)
			if [ -f "/opt/bin/$SCRIPT_NAME_LOWER" ]; then
				rm -f "/opt/bin/$SCRIPT_NAME_LOWER"
			fi
		;;
	esac
}

PressEnter()
{
	while true
	do
		printf "Press <Enter> key to continue..."
		read -rs key
		case "$key" in
			*) break ;;
		esac
	done
	return 0
}

##----------------------------------------------##
## Added/Modified by Martinski W. [2024-Jun-28] ##
##----------------------------------------------##
Get_JFFS_Usage()
{
   _GetNum_() { printf "%.2f" "$(echo "$1" | awk "{print $1}")" ; }
   local jffsMountStr  jffsUsageStr  typex  total  usedx  freex  totalx
   printf "\n${GRNct}${BOLDUNDERLN}JFFS${CLEARFORMAT}\n"
   df -kT | grep -E '^Filesystem[[:blank:]]+'
   jffsMountStr="$(mount | grep '/jffs')"
   jffsUsageStr="$(df -kT /jffs | grep -E '.*[[:blank:]]+/jffs$')"
   if [ -z "$jffsMountStr" ] || [ -z "$jffsUsageStr" ]
   then
       printf "\n${REDct}**ERROR**${CLRct}\n"
       printf "JFFS partition is NOT found mounted.\n"
       return 1
   fi
   echo "$jffsUsageStr"
   typex="$(echo "$jffsUsageStr" | awk -F ' ' '{print $2}')"
   total="$(echo "$jffsUsageStr" | awk -F ' ' '{print $3}')"
   usedx="$(echo "$jffsUsageStr" | awk -F ' ' '{print $4}')"
   freex="$(echo "$jffsUsageStr" | awk -F ' ' '{print $5}')"
   totalx="$total"
   if [ "$typex" = "ubifs" ] && [ "$((usedx + freex))" -ne "$total" ]
   then totalx="$((usedx + freex))" ; fi
   echo
   printf "JFFS Used:  %6d KB = %5.2f MB [%4.1f%%]\n" \
          "$usedx" "$(_GetNum_ "($usedx / 1024)")" "$(_GetNum_ "($usedx * 100 / $totalx)")"
   printf "JFFS Free:  %6d KB = %5.2f MB [%4.1f%%]\n" \
          "$freex" "$(_GetNum_ "($freex / 1024)")" "$(_GetNum_ "($freex * 100 / $totalx)")"
   printf "JFFS Total: %6d KB = %5.2f MB\n" \
          "$total" "$(_GetNum_ "($total / 1024)")"

   if echo "$jffsMountStr" | grep -qE "[[:blank:]]+[(]?ro[[:blank:],]"
   then
       printf "\n${GRNct}${BOLDUNDERLN}Mount Point:${CLRct}\n"
       echo "${jffsMountStr}"
       printf "\n${REDct}**${YLWct}WARNING${REDct}**${CLRct}\n"
       printf "JFFS partition appears to be READ-ONLY.\n"
   fi
}

##----------------------------------------##
## Modified by Martinski W. [2024-Jun-27] ##
##----------------------------------------##
Get_NVRAM_Usage()
{
   _GetNum_() { printf "%.2f" "$(echo "$1" | awk "{print $1}")" ; }
   local tempFile  nvramUsageStr  total  usedx  freex
   printf "\n${GRNct}${BOLDUNDERLN}NVRAM${CLEARFORMAT}\n"
   tempFile="${HOME}/nvramUsage.txt"
   nvram show 1>/dev/null 2>"$tempFile"
   nvramUsageStr="$(grep -i "^size:" "$tempFile")"
   rm -f "$tempFile"
   if [ -z "$nvramUsageStr" ]
   then
       printf "NVRAM size info is NOT found.\n" ; return 1
   fi
   echo "$nvramUsageStr"
   usedx="$(echo "$nvramUsageStr" | awk -F ' ' '{print $2}')"
   freex="$(echo "$nvramUsageStr" | awk -F ' ' '{print $4}')"
   freex="$(echo "$freex" | sed 's/[()]//g')"
   total="$((usedx + freex))"
   echo
   printf "NVRAM Used:  %7d Bytes = %6.2f KB [%4.1f%%]\n" \
          "$usedx" "$(_GetNum_ "($usedx / 1024)")" "$(_GetNum_ "($usedx * 100 / $total)")"
   printf "NVRAM Free:  %7d Bytes = %6.2f KB [%4.1f%%]\n" \
          "$freex" "$(_GetNum_ "($freex / 1024)")" "$(_GetNum_ "($freex * 100 / $total)")"
   printf "NVRAM Total: %7d Bytes = %6.2f KB\n" \
          "$total" "$(_GetNum_ "($total / 1024)")"
   echo
}

ScriptHeader()
{
	clear
	printf "\\n"
	printf "${BOLD}######################################################${CLEARFORMAT}\\n"
	printf "${BOLD}##               __  __              _  _           ##${CLEARFORMAT}\\n"
	printf "${BOLD}##              |  \/  |            | |(_)          ##${CLEARFORMAT}\\n"
	printf "${BOLD}##    ___   ___ | \  / |  ___  _ __ | | _  _ __     ##${CLEARFORMAT}\\n"
	printf "${BOLD}##   / __| / __|| |\/| | / _ \| '__|| || || '_ \    ##${CLEARFORMAT}\\n"
	printf "${BOLD}##   \__ \| (__ | |  | ||  __/| |   | || || | | |   ##${CLEARFORMAT}\\n"
	printf "${BOLD}##   |___/ \___||_|  |_| \___||_|   |_||_||_| |_|   ##${CLEARFORMAT}\\n"
	printf "${BOLD}##                                                  ##${CLEARFORMAT}\\n"
	printf "${BOLD}##              %9s on %-18s     ##${CLEARFORMAT}\n" "$SCRIPT_VERSION" "$ROUTER_MODEL"
	printf "${BOLD}##                                                  ##${CLEARFORMAT}\\n"
	printf "${BOLD}##       https://github.com/jackyaz/scMerlin        ##${CLEARFORMAT}\\n"
	printf "${BOLD}##                                                  ##${CLEARFORMAT}\\n"
	printf "${BOLD}######################################################${CLEARFORMAT}\\n"
	printf "\\n"
}

##----------------------------------------##
## Modified by Martinski W. [2024-Apr-28] ##
##----------------------------------------##
MainMenu()
{
	local NTP_WATCHDOG_STATUS=""  NTP_READY_CHECK_STATUS=""  TAILTAINT_DNS_STATUS=""
	isInteractiveMenuMode=true

	printf "WebUI for %s is available at:\n${SETTING}%s${CLEARFORMAT}\n\n" "$SCRIPT_NAME" "$(Get_WebUI_URL)"

	##---------- SERVICES ----------##
	printf "${BOLDUNDERLN}Services${CLEARFORMAT}"
	printf "${BOLD}${WARN} (selecting an option will restart the service)${CLEARFORMAT}\\n"
	printf "1.    DNS/DHCP Server (dnsmasq)\\n"
	printf "2.    Internet connection\\n"
	printf "3.    Web Interface (httpd)\\n"
	printf "4.    WiFi\\n"
	printf "5.    FTP Server (vsftpd)\\n"
	printf "6.    Samba\\n"
	printf "7.    DDNS client\\n"
	printf "8.    Timeserver (ntpd/chronyd)\\n"

	##---------- VPN CLIENTS ----------##
	vpnclients="$(nvram show 2> /dev/null | grep "^vpn_client._addr")"
	vpnclientenabled="false"
	for vpnclient in $vpnclients; do
		if [ -n "$(nvram get "$(echo "$vpnclient" | cut -f1 -d'=')")" ]; then
			vpnclientenabled="true"
		fi
	done
	if [ "$vpnclientenabled" = "true" ]; then
		printf "\\n${BOLDUNDERLN}VPN Clients${CLEARFORMAT}"
		printf "${BOLD}${WARN} (selecting an option will restart the VPN Client)${CLEARFORMAT}\\n"
		vpnclientnum=1
		while [ "$vpnclientnum" -lt 6 ]; do
			printf "vc%s.  VPN Client %s (%s)\\n" "$vpnclientnum" "$vpnclientnum" "$(nvram get vpn_client"$vpnclientnum"_desc)"
			vpnclientnum=$((vpnclientnum + 1))
		done
	fi

	##---------- VPN SERVERS ----------##
	vpnservercount="$(nvram get vpn_serverx_start | awk '{n=split($0, array, ",")} END{print n-1 }')"
	vpnserverenabled="false"
	if [ "$vpnservercount" -gt 0 ]; then
		vpnserverenabled="true"
	fi
	if [ "$vpnserverenabled" = "true" ]; then
		printf "\\n${BOLDUNDERLN}VPN Servers${CLEARFORMAT}"
		printf "${BOLD}${WARN} (selecting an option will restart the VPN Server)${CLEARFORMAT}\\n"
		vpnservernum=1
		while [ "$vpnservernum" -lt 3 ]; do
			vpnsdesc=""
			if ! nvram get vpn_serverx_start | grep -q "$vpnservernum"; then
				vpnsdesc="(Not configured)"
			fi
			printf "vs%s.  VPN Server %s %s\\n" "$vpnservernum" "$vpnservernum" "$vpnsdesc"
			vpnservernum=$((vpnservernum + 1))
		done
	fi

	##---------- ENTWARE ----------##
	if [ -f /opt/bin/opkg ]; then
		printf "\\n${BOLDUNDERLN}Entware${CLEARFORMAT}\\n"
		printf "et.   Restart all Entware applications\\n"
	fi

	##---------- ROUTER ----------##
	printf "\n${BOLDUNDERLN}Router${CLEARFORMAT}\n"
	printf "c.    View running processes\n"
	printf "m.    View RAM/memory usage\n"
	printf "jn.   View internal storage usage [JFFS & NVRAM]\n"
	printf "cr.   View cron jobs\n"
	printf "t.    View router temperatures\n"
	printf "w.    List Addon WebUI tab to page mapping\n"
	printf "r.    Reboot router\n\n"

	##---------- OTHER ----------##
	printf "${BOLDUNDERLN}Other${CLEARFORMAT}\\n"
	if [ "$(NTP_BootWatchdog status)" = "ENABLED" ]
	then
		NTP_WATCHDOG_STATUS="${GRNct}ENABLED${CLRct}"
	else
		NTP_WATCHDOG_STATUS="${REDct}DISABLED${CLRct}"
	fi
	printf "ntp.  Toggle NTP boot watchdog script\n      Currently: ${NTP_WATCHDOG_STATUS}\n\n"

	if [ "$(NTP_ReadyCheckOption status)" = "ENABLED" ]
	then
		NTP_READY_CHECK_STATUS="${GRNct}ENABLED${CLRct}"
	else
		NTP_READY_CHECK_STATUS="${REDct}DISABLED${CLRct}"
	fi
	if [ "$(nvram get ntp_ready)" -eq 0 ]
	then
		NTP_READY_CHECK_STATUS="${NTP_READY_CHECK_STATUS} [${YLWct}*WARNING*${CLRct}: NTP is ${REDct}NOT${CLRct} synced]"
	fi
	printf "nrc.  Toggle NTP Ready startup check\n      Currently: ${NTP_READY_CHECK_STATUS}\n\n"

	if [ "$(TailTaintDNSmasq status)" = "ENABLED" ]
	then
		TAILTAINT_DNS_STATUS="${GRNct}ENABLED${CLRct}"
	else
		TAILTAINT_DNS_STATUS="${REDct}DISABLED${CLRct}"
	fi
	printf "dns.  Toggle dnsmasq tainted watchdog script\n      Currently: ${TAILTAINT_DNS_STATUS}\n\n"
	printf "u.    Check for updates\\n"
	printf "uf.   Update %s with latest version (force update)\\n\\n" "$SCRIPT_NAME"
	printf "e.    Exit %s\\n\\n" "$SCRIPT_NAME"
	printf "z.    Uninstall %s\\n" "$SCRIPT_NAME"
	printf "\\n"
	printf "${BOLD}######################################################${CLEARFORMAT}\\n"
	printf "\\n"
	while true; do
		printf "Choose an option:  "
		read -r menu
		case "$menu" in
			1)
				printf "\\n"
				service restart_dnsmasq >/dev/null 2>&1
				PressEnter
				break
			;;
			2)
				printf "\\n"
				while true; do
					printf "\\n${BOLD}Internet connection will take 30s-60s to reconnect. Continue? (y/n)${CLEARFORMAT}  "
					read -r confirm
					case "$confirm" in
						y|Y)
							service restart_wan >/dev/null 2>&1
							break
						;;
						*)
							break
						;;
					esac
				done
				PressEnter
				break
			;;
			3)
				printf "\\n"
				service restart_httpd >/dev/null 2>&1
				PressEnter
				break
			;;
			4)
				printf "\\n"
				service restart_wireless >/dev/null 2>&1
				PressEnter
				break
			;;
			5)
				ENABLED_FTP="$(nvram get enable_ftp)"
				if ! Validate_Number "$ENABLED_FTP"; then ENABLED_FTP=0; fi
				if [ "$ENABLED_FTP" -eq 1 ]; then
					printf "\\n"
					service restart_ftpd >/dev/null 2>&1
				else
				printf "\\n${BOLD}\\e[31mInvalid selection (FTP not enabled)${CLEARFORMAT}\\n\\n"
				fi
				PressEnter
				break
			;;
			6)
				ENABLED_SAMBA="$(nvram get enable_samba)"
				if ! Validate_Number "$ENABLED_SAMBA"; then ENABLED_SAMBA=0; fi
				if [ "$ENABLED_SAMBA" -eq 1 ]; then
					printf "\\n"
					service restart_samba >/dev/null 2>&1
				else
					printf "\\n${BOLD}\\e[31mInvalid selection (Samba not enabled)${CLEARFORMAT}\\n\\n"
				fi
				PressEnter
				break
			;;
			7)
				ENABLED_DDNS="$(nvram get ddns_enable_x)"
				if ! Validate_Number "$ENABLED_DDNS"; then ENABLED_DDNS=0; fi
				if [ "$ENABLED_DDNS" -eq 1 ]; then
					printf "\\n"
					service restart_ddns >/dev/null 2>&1
				else
					printf "\\n${BOLD}\\e[31mInvalid selection (DDNS client not enabled)${CLEARFORMAT}\\n\\n"
				fi
				PressEnter
				break
			;;
			8)
				ENABLED_NTPD="$(nvram get ntpd_enable)"
				if ! Validate_Number "$ENABLED_NTPD"; then ENABLED_NTPD=0; fi
				if [ "$ENABLED_NTPD" -eq 1 ]; then
					printf "\\n"
					service restart_time >/dev/null 2>&1
				elif [ -f /opt/etc/init.d/S77ntpd ]; then
					printf "\\n"
					/opt/etc/init.d/S77ntpd restart
				elif [ -f /opt/etc/init.d/S77chronyd ]; then
					printf "\\n"
					/opt/etc/init.d/S77chronyd restart
				else
					printf "\\n${BOLD}\\e[31mInvalid selection (NTP server not enabled/installed)${CLEARFORMAT}\\n\\n"
				fi
				PressEnter
				break
			;;
			vc1)
				if [ -n "$(nvram get vpn_client1_addr)" ]; then
					printf "\\n"
					service restart_vpnclient1 >/dev/null 2>&1
				else
					printf "\\n${BOLD}\\e[31mInvalid selection (VPN Client not configured)${CLEARFORMAT}\\n\\n"
				fi
				PressEnter
				break
			;;
			vc2)
				if [ -n "$(nvram get vpn_client2_addr)" ]; then
					printf "\\n"
					service restart_vpnclient2 >/dev/null 2>&1
				else
					printf "\\n${BOLD}\\e[31mInvalid selection (VPN Client not configured)${CLEARFORMAT}\\n\\n"
				fi
				PressEnter
				break
			;;
			vc3)
				if [ -n "$(nvram get vpn_client3_addr)" ]; then
					printf "\\n"
					service restart_vpnclient3 >/dev/null 2>&1
				else
					printf "\\n${BOLD}\\e[31mInvalid selection (VPN Client not configured)${CLEARFORMAT}\\n\\n"
				fi
				PressEnter
				break
			;;
			vc4)
				if [ -n "$(nvram get vpn_client4_addr)" ]; then
					printf "\\n"
					service restart_vpnclient4 >/dev/null 2>&1
				else
					printf "\\n${BOLD}\\e[31mInvalid selection (VPN Client not configured)${CLEARFORMAT}\\n\\n"
				fi
				PressEnter
				break
			;;
			vc5)
				if [ -n "$(nvram get vpn_client5_addr)" ]; then
					printf "\\n"
					service restart_vpnclient5 >/dev/null 2>&1
				else
					printf "\\n${BOLD}\\e[31mInvalid selection (VPN Client not configured)${CLEARFORMAT}\\n\\n"
				fi
				PressEnter
				break
			;;
			vs1)
				if nvram get vpn_serverx_start | grep -q 1; then
					printf "\\n"
					service restart_vpnserver1 >/dev/null 2>&1
				else
					printf "\\n${BOLD}\\e[31mInvalid selection (VPN Server not configured)${CLEARFORMAT}\\n\\n"
				fi
				PressEnter
				break
			;;
			vs2)
				if nvram get vpn_serverx_start | grep -q 2; then
					printf "\\n"
					service restart_vpnserver2 >/dev/null 2>&1
				else
					printf "\\n${BOLD}\\e[31mInvalid selection (VPN Server not configured)${CLEARFORMAT}\\n\\n"
				fi
				PressEnter
				break
			;;
			et)
				printf "\\n"
				if [ -f /opt/bin/opkg ]; then
					if Check_Lock menu; then
						while true; do
							printf "\\n${BOLD}Are you sure you want to restart all Entware scripts? (y/n)${CLEARFORMAT}  "
							read -r confirm
							case "$confirm" in
								y|Y)
									/opt/etc/init.d/rc.unslung restart
									break
								;;
								*)
									break
								;;
							esac
						done
						Clear_Lock
					fi
				else
					printf "\\n${BOLD}\\e[31mInvalid selection (Entware not installed)${CLEARFORMAT}\\n"
				fi
				PressEnter
				break
			;;
			c)
				printf "\\n"
				program=""
				if [ -f /opt/bin/opkg ]; then
					if [ -f /opt/bin/htop ]; then
						program="htop"
					else
						program=""
						while true; do
							printf "\\n${BOLD}Would you like to install htop (enhanced version of top)? (y/n)${CLEARFORMAT}  "
							read -r confirm
							case "$confirm" in
								y|Y)
									program="htop"
									opkg install htop
									break
								;;
								*)
									program="top"
									break
								;;
							esac
						done
					fi
				else
					program="top"
				fi
				trap trap_ctrl 2
				trap_ctrl(){
					exec "$0"
				}
				"$program"
				trap - 2
				PressEnter
				break
			;;
			m)
				ScriptHeader
				printf "\\n"
				free
				printf "\\n"
				PressEnter
				break
			;;
			jn)
				ScriptHeader
				Get_JFFS_Usage
				Get_NVRAM_Usage
				PressEnter
				break
			;;
			cr)
				ScriptHeader
				Get_Cron_Jobs
				printf "\\n"
				PressEnter
				break
			;;
			t)
				ScriptHeader
				printf "\n${GRNct}${BOLDUNDERLN}Temperatures${CLRct}\n\n"
				if [ -f /sys/class/thermal/thermal_zone0/temp ]
				then
					printf "CPU:\t ${GRNct}%s°C${CLRct}\n" "$(awk '{print int($1/1000)}' /sys/class/thermal/thermal_zone0/temp)"
				elif [ -f /proc/dmu/temperature ]
				then
					printf "CPU:\t ${GRNct}%s${CLRct}\n" "$(cut -f2 -d':' /proc/dmu/temperature | awk '{$1=$1;print}' | sed 's/..$/°C/')"
				else
					printf "CPU:\t ${REDct}[N/A]${CLRct}\n"
				fi

				##----------------------------------------##
				## Modified by Martinski W. [2025-Feb-15] ##
				##----------------------------------------##
				if "$Band_24G_Support"
				then
					theTemptrVal="$(GetTemperatureValue "2.4GHz")"
					printf "2.4 GHz: %s\n" "$(GetTemperatureString "$theTemptrVal")"
				fi

				if [ "$ROUTER_MODEL" = "RT-AC87U" ] || [ "$ROUTER_MODEL" = "RT-AC87R" ]
				then
					printf "5 GHz:   %s°C\n" "$(qcsapi_sockrpc get_temperature | awk 'FNR == 2 {print $3}')"
					echo ; PressEnter
					break
				fi

				if "$Band_5G_2_support"
				then
					theTemptrVal="$(GetTemperatureValue "5GHz_1")"
					printf "5 GHz-1: %s\n" "$(GetTemperatureString "$theTemptrVal")"

					theTemptrVal="$(GetTemperatureValue "5GHz_2")"
					printf "5 GHz-2: %s\n" "$(GetTemperatureString "$theTemptrVal")"
				elif "$Band_5G_1_Support"
				then
					theTemptrVal="$(GetTemperatureValue "5GHz_1")"
					printf "5 GHz:   %s\n" "$(GetTemperatureString "$theTemptrVal")"
				fi

				if "$Band_6G_2_Support"
				then
					theTemptrVal="$(GetTemperatureValue "6GHz_1")"
					printf "6 GHz-1: %s\n" "$(GetTemperatureString "$theTemptrVal")"

					theTemptrVal="$(GetTemperatureValue "6GHz_2")"
					printf "6 GHz-2: %s\n" "$(GetTemperatureString "$theTemptrVal")"
				elif "$Band_6G_1_Support"
				then
					theTemptrVal="$(GetTemperatureValue "6GHz_1")"
					printf "6 GHz:   %s\n" "$(GetTemperatureString "$theTemptrVal")"
				fi
				echo ; PressEnter
				break
			;;
			w)
				ScriptHeader
				Get_Addon_Pages
				printf "\\n"
				PressEnter
				break
			;;
			r)
				printf "\\n"
				while true; do
					if [ "$ROUTER_MODEL" = "RT-AC86U" ]; then
						printf "\\n${BOLD}${WARN}Remote reboots are not recommend for %s${CLEARFORMAT}" "$ROUTER_MODEL"
						printf "\\n${BOLD}${WARN}Some %s fail to reboot correctly and require a manual power cycle${CLEARFORMAT}\\n" "$ROUTER_MODEL"
					fi
					printf "\\n${BOLD}Are you sure you want to reboot? (y/n)${CLEARFORMAT}  "
					read -r confirm
					case "$confirm" in
						y|Y)
							service reboot >/dev/null 2>&1
							break
						;;
						*)
							break
						;;
					esac
				done
				PressEnter
				break
			;;
			ntp)
				printf "\n"
				NTP_WATCHDOG_STATUS="$(NTP_BootWatchdog status)"
				if [ "$NTP_WATCHDOG_STATUS" = "ENABLED" ]
				then NTP_BootWatchdog disable
				elif [ "$NTP_WATCHDOG_STATUS" = "DISABLED" ]
				then NTP_BootWatchdog enable
				fi
				break
			;;
			nrc)
				printf "\n"
				NTP_READY_CHECK_STATUS="$(NTP_ReadyCheckOption status)"
				if [ "$NTP_READY_CHECK_STATUS" = "ENABLED" ]
				then NTP_ReadyCheckOption disable
				elif [ "$NTP_READY_CHECK_STATUS" = "DISABLED" ]
				then NTP_ReadyCheckOption enable
				fi
				break
			;;
			dns)
				printf "\n"
				TAILTAINT_DNS_STATUS="$(TailTaintDNSmasq status)"
				if [ "$TAILTAINT_DNS_STATUS" = "ENABLED" ]
				then TailTaintDNSmasq disable
				elif [ "$TAILTAINT_DNS_STATUS" = "DISABLED" ]
				then TailTaintDNSmasq enable
				fi
				break
			;;
			u)
				printf "\\n"
				if Check_Lock menu; then
					Update_Version
					Clear_Lock
				fi
				PressEnter
				break
			;;
			uf)
				printf "\\n"
				if Check_Lock menu; then
					Update_Version force
					Clear_Lock
				fi
				PressEnter
				break
			;;
			e)
				ScriptHeader
				printf "\\n${BOLD}Thanks for using %s!${CLEARFORMAT}\\n\\n\\n" "$SCRIPT_NAME"
				exit 0
			;;
			z)
				printf "\\n${BOLD}Are you sure you want to uninstall %s? (y/n)${CLEARFORMAT}  " "$SCRIPT_NAME"
				read -r confirm
				case "$confirm" in
					y|Y)
						Menu_Uninstall
						exit 0
					;;
					*)
						:
					;;
				esac
			;;
			*)
				printf "\\nPlease choose a valid option\\n\\n"
			;;
		esac
	done

	ScriptHeader
	MainMenu
}

Check_Requirements(){
	CHECKSFAILED="false"

	if [ "$(nvram get jffs2_scripts)" -ne 1 ]; then
		nvram set jffs2_scripts=1
		nvram commit
		Print_Output true "Custom JFFS Scripts enabled" "$WARN"
	fi

	if ! Firmware_Version_Check; then
		Print_Output false "Unsupported firmware version detected" "$ERR"
		Print_Output false "$SCRIPT_NAME requires Merlin 384.15/384.13_4 or Fork 43E5 (or later)" "$ERR"
		CHECKSFAILED="true"
	fi

	if [ "$CHECKSFAILED" = "false" ]; then
		return 0
	else
		return 1
	fi
}

##----------------------------------------##
## Modified by Martinski W. [2025-Feb-15] ##
##----------------------------------------##
Menu_Install()
{
	ScriptHeader
	Print_Output true "Welcome to $SCRIPT_NAME $SCRIPT_VERSION, a script by JackYaz" "$PASS"
	sleep 1

	Print_Output true "Checking if your router meets the requirements for $SCRIPT_NAME" "$PASS"

	if ! Check_Requirements
	then
		Print_Output true "Requirements for $SCRIPT_NAME not met, please see above for the reason(s)" "$CRIT"
		PressEnter
		Clear_Lock
		rm -f "/jffs/scripts/$SCRIPT_NAME_LOWER" 2>/dev/null
		rm -rf "$SCRIPT_DIR" 2>/dev/null
		exit 1
	fi

	Create_Dirs
	Create_Symlinks
	Shortcut_Script create
	Set_Version_Custom_Settings local "$SCRIPT_VERSION"
	Set_Version_Custom_Settings server "$SCRIPT_VERSION"
	Auto_Startup create 2>/dev/null
	Auto_ServiceEvent create 2>/dev/null

	Update_File scmerlin_www.asp
	Update_File sitemap.asp
	Update_File shared-jy.tar.gz
	Update_File tailtop
	Update_File tailtopd
	Update_File tailtaintdns
	Update_File tailtaintdnsd
	Update_File sc.func
	Update_File S99tailtop
	Update_File S95tailtaintdns

	Clear_Lock

	Download_File "$SCRIPT_REPO/LICENSE" "$SCRIPT_DIR/LICENSE"

	ScriptHeader
	MainMenu
}

##----------------------------------------##
## Modified by Martinski W. [2024-Apr-28] ##
##----------------------------------------##
Menu_Startup()
{
	Create_Dirs
	Create_Symlinks
	Auto_Startup create 2>/dev/null

	NTP_Ready

	Check_Lock
	if [ "$1" != "force" ]; then
		sleep 14
	fi

	Shortcut_Script create
	Auto_ServiceEvent create 2>/dev/null

	"$SCRIPT_DIR/S99tailtop" start >/dev/null 2>&1

	Mount_WebUI
	Clear_Lock
}

##-------------------------------------##
## Added by Martinski W. [2025-Mar-01] ##
##-------------------------------------##
_RemoveMenuAddOnsSection_()
{
   if [ $# -lt 2 ] || [ -z "$1" ] || [ -z "$2" ] || \
      ! echo "$1" | grep -qE "^[1-9][0-9]*$" || \
      ! echo "$2" | grep -qE "^[1-9][0-9]*$" || \
      [ "$1" -ge "$2" ]
   then return 1 ; fi
   local BEGINnum="$1"  ENDINnum="$2"

   if [ -n "$(sed -E "${BEGINnum},${ENDINnum}!d;/${webPageLineTabExp}/!d" "$TEMP_MENU_TREE")" ]
   then return 1
   fi
   sed -i "${BEGINnum},${ENDINnum}d" "$TEMP_MENU_TREE"
   return 0
}

##-------------------------------------##
## Added by Martinski W. [2025-Mar-01] ##
##-------------------------------------##
_FindandRemoveMenuAddOnsSection_()
{
   local BEGINnum  ENDINnum  retCode=1

   if grep -qE "^${BEGIN_MenuAddOnsTag}$" "$TEMP_MENU_TREE" && \
      grep -qE "^${ENDIN_MenuAddOnsTag}$" "$TEMP_MENU_TREE"
   then
       BEGINnum="$(grep -nE "^${BEGIN_MenuAddOnsTag}$" "$TEMP_MENU_TREE" | awk -F ':' '{print $1}')"
       ENDINnum="$(grep -nE "^${ENDIN_MenuAddOnsTag}$" "$TEMP_MENU_TREE" | awk -F ':' '{print $1}')"
       _RemoveMenuAddOnsSection_ "$BEGINnum" "$ENDINnum" && retCode=0
   fi

   if grep -qE "^${webPageMenuAddons}$" "$TEMP_MENU_TREE" && \
      grep -qE "${webPageHelpSupprt}$" "$TEMP_MENU_TREE"
   then
       BEGINnum="$(grep -nE "^${webPageMenuAddons}$" "$TEMP_MENU_TREE" | awk -F ':' '{print $1}')"
       ENDINnum="$(grep -nE "${webPageHelpSupprt}$" "$TEMP_MENU_TREE" | awk -F ':' '{print $1}')"
       if [ -n "$BEGINnum" ] && [ -n "$ENDINnum" ] && [ "$BEGINnum" -lt "$ENDINnum" ]
       then
           BEGINnum="$((BEGINnum - 2))" ; ENDINnum="$((ENDINnum + 3))"
           if [ "$(sed -n "${BEGINnum}p" "$TEMP_MENU_TREE")" = "," ] && \
              [ "$(sed -n "${ENDINnum}p" "$TEMP_MENU_TREE")" = "}" ]
           then
               _RemoveMenuAddOnsSection_ "$BEGINnum" "$ENDINnum" && retCode=0
           fi
       fi
   fi
   return "$retCode"
}

##----------------------------------------##
## Modified by Martinski W. [2025-Mar-01] ##
##----------------------------------------##
Menu_Uninstall()
{
	Print_Output true "Removing $SCRIPT_NAME..." "$PASS"
	Shortcut_Script delete
	Auto_Startup delete 2>/dev/null
	Auto_ServiceEvent delete 2>/dev/null
	NTP_BootWatchdog disable
	NTP_ReadyCheckOption delete
	TailTaintDNSmasq disable

	LOCKFILE=/tmp/addonwebui.lock
	FD=386
	eval exec "$FD>$LOCKFILE"
	flock -x "$FD"

	local doResetWebGUI=false  doResetStyle=false

	if [ -f "$SCRIPT_DIR/sitemap.asp" ]
	then
		Get_WebUI_Page "$SCRIPT_DIR/sitemap.asp"
		if [ -n "$MyWebPage" ] && \
		   [ "$MyWebPage" != "NONE" ] && \
		   [ -f "$TEMP_MENU_TREE" ]
		then
			doResetWebGUI=true
			sed -i "\\~$MyWebPage~d" "$TEMP_MENU_TREE"
			rm -f "$SCRIPT_WEBPAGE_DIR/$MyWebPage"
		fi
	fi
	Get_WebUI_Page "$SCRIPT_DIR/scmerlin_www.asp"
	if [ -n "$MyWebPage" ] && \
	   [ "$MyWebPage" != "NONE" ] && \
	   [ -f "$TEMP_MENU_TREE" ]
	then
		doResetWebGUI=true
		sed -i "\\~$MyWebPage~d" "$TEMP_MENU_TREE"
		rm -f "$SCRIPT_WEBPAGE_DIR/$MyWebPage"
		rm -f "$SCRIPT_WEBPAGE_DIR/$(echo "$MyWebPage" | cut -f1 -d'.').title"
	fi

	_FindandRemoveMenuAddOnsSection_ && doResetStyle=true

	if "$doResetWebGUI"
	then
		umount /www/require/modules/menuTree.js 2>/dev/null
		mount -o bind "$TEMP_MENU_TREE" /www/require/modules/menuTree.js
		if "$doResetStyle" && [ -f /tmp/index_style.css ] && \
		   grep -qF '.menu_Addons { background:' /tmp/index_style.css
		then
			rm -f /tmp/index_style.css
			umount /www/index_style.css 2>/dev/null
		fi
		if [ -f /tmp/state.js ] && \
		   grep -qE 'function GenerateSiteMap|function AddDropdowns' /tmp/state.js
		then
			rm -f /tmp/state.js
			umount /www/state.js 2>/dev/null
		fi
	fi
	flock -u "$FD"
	rm -rf "$SCRIPT_WEB_DIR" 2>/dev/null

	"$SCRIPT_DIR/S99tailtop" stop >/dev/null 2>&1
	sleep 5

	rm -rf "$SCRIPT_DIR"

	SETTINGSFILE="/jffs/addons/custom_settings.txt"
	sed -i '/scmerlin_version_local/d' "$SETTINGSFILE"
	sed -i '/scmerlin_version_server/d' "$SETTINGSFILE"

	rm -f "/jffs/scripts/$SCRIPT_NAME_LOWER" 2>/dev/null
	Clear_Lock
	Print_Output true "Uninstall completed" "$PASS"
}

##-------------------------------------##
## Added by Martinski W. [2024-Apr-28] ##
##-------------------------------------##
WAN_IsConnected()
{
   local retCode=1
   for iFaceNum in 0 1
   do
       if [ "$(nvram get wan${iFaceNum}_primary)" -eq 1 ] && \
          [ "$(nvram get wan${iFaceNum}_state_t)" -eq 2 ]
       then retCode=0 ; break ; fi
   done
   return "$retCode"
}

##----------------------------------------##
## Modified by Martinski W. [2024-Apr-28] ##
##----------------------------------------##
NTP_Ready()
{
	local theSleepDelay=15  ntpMaxWaitSecs=600  ntpWaitSecs
	local NTP_READY_CHECK_STATUS

	NTP_READY_CHECK_STATUS="$(NTP_ReadyCheckOption status)"

	if [ "$(nvram get ntp_ready)" -eq 1 ]
	then
		[ "$isInteractiveMenuMode" = "false" ] && \
		Print_Output false "NTP is synced." "$PASS"
		return 0
	fi

	##--------------------------------------------------------------
	## If WAN is in a "connected" state, ignore when "NTP Ready"
	## check is disabled. IOW, the "NTP Ready" check is skipped
	## if WAN is *not* in the "connected" state. This is done
	## to avoid any problems related not having NTP synchronized.
	##--------------------------------------------------------------
	if [ "$NTP_READY_CHECK_STATUS" = "DISABLED" ] && ! WAN_IsConnected
	then
		[ "$isInteractiveMenuMode" = "false" ] && \
		Print_Output true "Check for NTP sync is currently DISABLED. Skipping check..." "$REDct"
		return 0
	fi

	if [ "$(nvram get ntp_ready)" -eq 0 ]
	then
		Check_Lock
		Print_Output true "Waiting for NTP to sync..." "$WARN"

		ntpWaitSecs=0
		while [ "$(nvram get ntp_ready)" -eq 0 ] && [ "$ntpWaitSecs" -lt "$ntpMaxWaitSecs" ]
		do
			if [ "$ntpWaitSecs" -gt 0 ] && [ "$((ntpWaitSecs % 30))" -eq 0 ]
			then
			    Print_Output true "Waiting for NTP to sync [$ntpWaitSecs secs]..." "$WARN"
			fi
			sleep "$theSleepDelay"
			ntpWaitSecs="$((ntpWaitSecs + theSleepDelay))"
		done

		if [ "$ntpWaitSecs" -ge "$ntpMaxWaitSecs" ]
		then
			Print_Output true "NTP failed to sync after 10 minutes. Please resolve!" "$CRIT"
			Clear_Lock
			exit 1
		else
			Print_Output true "NTP has synced, $SCRIPT_NAME will now continue" "$PASS"
			Clear_Lock
		fi
	fi
}

### function based on @Adamm00's Skynet USB wait function ###
##----------------------------------------##
## Modified by Martinski W. [2025-Feb-28] ##
##----------------------------------------##
Entware_Ready()
{
	local theSleepDelay=5  maxSleepTimer=120  sleepTimerSecs

	if [ ! -f /opt/bin/opkg ]
	then
		Check_Lock
		sleepTimerSecs=0

		while [ ! -f /opt/bin/opkg ] && [ "$sleepTimerSecs" -lt "$maxSleepTimer" ]
		do
			if [ "$((sleepTimerSecs % 10))" -eq 0 ]
			then
			    Print_Output true "Entware NOT found, sleeping for $theSleepDelay secs [$sleepTimerSecs secs]..." "$WARN"
			fi
			sleep "$theSleepDelay"
			sleepTimerSecs="$((sleepTimerSecs + theSleepDelay))"
		done
		if [ ! -f /opt/bin/opkg ]
		then
			Print_Output true "Entware NOT found and is required for $SCRIPT_NAME to run, please resolve!" "$CRIT"
			Clear_Lock
			exit 1
		else
			Print_Output true "Entware found, $SCRIPT_NAME will now continue" "$PASS"
			Clear_Lock
		fi
	fi
}

Show_About()
{
	cat << EOF
About
  $SCRIPT_NAME allows you to easily control the most common
  services/scripts on your router. scMerlin also augments your
  router's WebUI with a Sitemap and dynamic submenus for the
  main left menu of Asuswrt-Merlin.

License
  $SCRIPT_NAME is free to use under the GNU General Public License
  version 3 (GPL-3.0) https://opensource.org/licenses/GPL-3.0

Help & Support
  https://www.snbforums.com/forums/asuswrt-merlin-addons.60/?prefix_id=23

Source code
  https://github.com/jackyaz/$SCRIPT_NAME
EOF
	printf "\n"
}

### function based on @dave14305's FlexQoS show_help function ###
Show_Help()
{
	cat << EOF
Available commands:
  $SCRIPT_NAME_LOWER about            explains functionality
  $SCRIPT_NAME_LOWER update           checks for updates
  $SCRIPT_NAME_LOWER forceupdate      updates to latest version (force update)
  $SCRIPT_NAME_LOWER startup force    runs startup actions such as mount WebUI tab
  $SCRIPT_NAME_LOWER install          installs script
  $SCRIPT_NAME_LOWER uninstall        uninstalls script
  $SCRIPT_NAME_LOWER develop          switch to development branch
  $SCRIPT_NAME_LOWER stable           switch to stable branch
EOF
	printf "\n"
}

##----------------------------------------##
## Modified by Martinski W. [2025-Feb-11] ##
##----------------------------------------##
if [ $# -eq 0 ] || [ -z "$1" ]
then
	isInteractiveMenuMode=true
	Create_Dirs
	Upgrade_StateJS
	Create_Symlinks
	NTP_Ready
	Shortcut_Script create
	Auto_Startup create 2>/dev/null
	Auto_ServiceEvent create 2>/dev/null
	Process_Upgrade
	_CheckFor_WebGUI_Page_
	ScriptHeader
	MainMenu
	exit 0
fi

##----------------------------------------##
## Modified by Martinski W. [2024-Sep-22] ##
##----------------------------------------##
case "$1" in
	install)
		Check_Lock
		Menu_Install
		exit 0
	;;
	startup)
		Menu_Startup "$2"
		exit 0
	;;
	service_event)
		if [ "$2" = "start" ] && echo "$3" | grep -qE "^${SCRIPT_NAME_LOWER}_NTPwatchdog"
		then
			settingstate="$(echo "$3" | sed "s/${SCRIPT_NAME_LOWER}_NTPwatchdog//")";
			settingstate="$(echo "$settingstate" | tr 'A-Z' 'a-z')"
			NTP_BootWatchdog "$settingstate"
			exit 0
		elif [ "$2" = "start" ] && echo "$3" | grep -qE "^${SCRIPT_NAME_LOWER}_NTPcheck"
		then
			settingstate="$(echo "$3" | sed "s/${SCRIPT_NAME_LOWER}_NTPcheck//")";
			settingstate="$(echo "$settingstate" | tr 'A-Z' 'a-z')"
			NTP_ReadyCheckOption "$settingstate"
			exit 0
		elif [ "$2" = "start" ] && echo "$3" | grep -qE "^${SCRIPT_NAME_LOWER}_DNSmasqWatchdog"
		then
			settingstate="$(echo "$3" | sed "s/${SCRIPT_NAME_LOWER}_DNSmasqWatchdog//")";
			settingstate="$(echo "$settingstate" | tr 'A-Z' 'a-z')"
			TailTaintDNSmasq "$settingstate"
			exit 0
		elif [ "$2" = "start" ] && echo "$3" | grep -qE "^${SCRIPT_NAME_LOWER}servicerestart"
		then
			rm -f "$SCRIPT_WEB_DIR/detect_service.js"
			echo 'var servicestatus = "InProgress";' > "$SCRIPT_WEB_DIR/detect_service.js"
			srvname="$(echo "$3" | sed "s/${SCRIPT_NAME_LOWER}servicerestart//")";

			if [ "$srvname" = "vsftpd" ]; then
				ENABLED_FTP="$(nvram get enable_ftp)"
				if ! Validate_Number "$ENABLED_FTP"; then ENABLED_FTP=0; fi
				if [ "$ENABLED_FTP" -eq 1 ]; then
					service restart_"$srvname" >/dev/null 2>&1
					echo 'var servicestatus = "Done";' > "$SCRIPT_WEB_DIR/detect_service.js"
				else
					echo 'var servicestatus = "Invalid";' > "$SCRIPT_WEB_DIR/detect_service.js"
				fi
			elif [ "$srvname" = "samba" ]; then
				ENABLED_SAMBA="$(nvram get enable_samba)"
				if ! Validate_Number "$ENABLED_SAMBA"; then ENABLED_SAMBA=0; fi
				if [ "$ENABLED_SAMBA" -eq 1 ]; then
					service restart_"$srvname" >/dev/null 2>&1
					echo 'var servicestatus = "Done";' > "$SCRIPT_WEB_DIR/detect_service.js"
				else
					echo 'var servicestatus = "Invalid";' > "$SCRIPT_WEB_DIR/detect_service.js"
				fi
			elif [ "$srvname" = "ntpdchronyd" ]; then
				ENABLED_NTPD="$(nvram get ntpd_enable)"
				if ! Validate_Number "$ENABLED_NTPD"; then ENABLED_NTPD=0; fi
				if [ "$ENABLED_NTPD" -eq 1 ]; then
					service restart_time >/dev/null 2>&1
					echo 'var servicestatus = "Done";' > "$SCRIPT_WEB_DIR/detect_service.js"
				elif [ -f /opt/etc/init.d/S77ntpd ]; then
					/opt/etc/init.d/S77ntpd restart
					echo 'var servicestatus = "Done";' > "$SCRIPT_WEB_DIR/detect_service.js"
				elif [ -f /opt/etc/init.d/S77chronyd ]; then
					/opt/etc/init.d/S77chronyd restart
					echo 'var servicestatus = "Done";' > "$SCRIPT_WEB_DIR/detect_service.js"
				else
					echo 'var servicestatus = "Invalid";' > "$SCRIPT_WEB_DIR/detect_service.js"
				fi
			elif echo "$srvname" | grep -q "vpnclient"; then
				vpnno="$(echo "$srvname" | sed "s/vpnclient//")";
				if [ -n "$(nvram get "vpn_client${vpnno}_addr")" ]; then
					service restart_"$srvname" >/dev/null 2>&1
					echo 'var servicestatus = "Done";' > "$SCRIPT_WEB_DIR/detect_service.js"
				else
					echo 'var servicestatus = "Invalid";' > "$SCRIPT_WEB_DIR/detect_service.js"
				fi
			elif echo "$srvname" | grep -q "vpnserver"; then
				vpnno="$(echo "$srvname" | sed "s/vpnserver//")";
				if nvram get vpn_serverx_start | grep -q "$vpnno"; then
					service restart_"$srvname" >/dev/null 2>&1
					echo 'var servicestatus = "Done";' > "$SCRIPT_WEB_DIR/detect_service.js"
				else
					echo 'var servicestatus = "Invalid";' > "$SCRIPT_WEB_DIR/detect_service.js"
				fi
			elif [ "$srvname" = "entware" ]; then
				/opt/etc/init.d/rc.unslung restart
				echo 'var servicestatus = "Done";' > "$SCRIPT_WEB_DIR/detect_service.js"
			else
				service restart_"$srvname" >/dev/null 2>&1
				echo 'var servicestatus = "Done";' > "$SCRIPT_WEB_DIR/detect_service.js"
			fi
			exit 0
		elif [ "$2" = "start" ] && [ "$3" = "${SCRIPT_NAME_LOWER}checkupdate" ]; then
			Update_Check
			exit 0
		elif [ "$2" = "start" ] && [ "$3" = "${SCRIPT_NAME_LOWER}doupdate" ]; then
			Update_Version force unattended
			exit 0
		elif [ "$2" = "start" ] && [ "$3" = "${SCRIPT_NAME_LOWER}getaddonpages" ]; then
			rm -f /tmp/addonwebpages.tmp
			sleep 3
			Get_Addon_Pages
			exit 0
		elif [ "$2" = "start" ] && [ "$3" = "${SCRIPT_NAME_LOWER}getcronjobs" ]; then
			rm -f /tmp/scmcronjobs.tmp
			sleep 3
			Get_Cron_Jobs
			exit 0
		fi
		exit 0
	;;
	update)
		Update_Version
		exit 0
	;;
	forceupdate)
		Update_Version force
		exit 0
	;;
	postupdate)
		Create_Dirs
		Create_Symlinks
		Shortcut_Script create
		Auto_Startup create 2>/dev/null
		Auto_ServiceEvent create 2>/dev/null
		Process_Upgrade
		exit 0
	;;
	checkupdate)
		Update_Check
		exit 0
	;;
	uninstall)
		Menu_Uninstall
		exit 0
	;;
	about)
		ScriptHeader
		Show_About
		exit 0
	;;
	help)
		ScriptHeader
		Show_Help
		exit 0
	;;
	develop)
		if false  ## The "develop" branch is NOT available on this repository ##
		then
		    SCRIPT_BRANCH="develop"
		else
		    SCRIPT_BRANCH="master"
		    printf "\n${REDct}The 'develop' branch is NOT available. Updating from the 'master' branch...${CLRct}\n"
		fi
		SCRIPT_REPO="https://raw.githubusercontent.com/decoderman/$SCRIPT_NAME/$SCRIPT_BRANCH"
		Update_Version force
		exit 0
	;;
	stable)
		SCRIPT_BRANCH="master"
		SCRIPT_REPO="https://raw.githubusercontent.com/decoderman/$SCRIPT_NAME/$SCRIPT_BRANCH"
		Update_Version force
		exit 0
	;;
	*)
		ScriptHeader
		Print_Output false "Parameter [$*] is NOT recognised." "$ERR"
		Print_Output false "For a list of available commands run: $SCRIPT_NAME_LOWER help" "$SETTING"
		exit 1
	;;
esac
