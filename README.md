# scMerlin - service and script control menu for AsusWRT-Merlin
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/bfd397624cdf4803a465d4ae1530e7fe)](https://www.codacy.com/app/jackyaz/scMerlin?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=jackyaz/scMerlin&amp;utm_campaign=Badge_Grade)
[![Build Status](https://travis-ci.com/jackyaz/scmerlin.svg?branch=master)](https://travis-ci.com/jackyaz/scmerlin)

## v1.0.0
### Updated on 2019-04-21
## About
Quick access to controlling services and scripts on your router

scMerlin is free to use under the [GNU General Public License version 3](https://opensource.org/licenses/GPL-3.0) (GPL 3.0).

![Menu UI](https://puu.sh/DfKf9/b90295e188.png)

### Supporting development
Love the script and want to support future development? Any and all donations gratefully received!
[**PayPal donation**](https://paypal.me/jackyaz21)

## Supported Models
All modes supported by [Asuswrt-Merlin](https://asuswrt.lostrealm.ca/about). Models confirmed to work are below:
*   RT-AC86U

## Installation
Using your preferred SSH client/terminal, copy and paste the following command, then press Enter:

```sh
/usr/sbin/curl --retry 3 "https://raw.githubusercontent.com/jackyaz/scmerlin/master/scmerlin.sh" -o "/jffs/scripts/scmerlin" && chmod 0755 /jffs/scripts/scmerlin && /jffs/scripts/scmerlin install
```

## Usage
To launch the scMerlin menu after installation, use:
```sh
scmerlin
```

If this does not work, you will need to use the full path:
```sh
/jffs/scripts/scmerlin
```

## Updating
Launch scMerlin and select option u

## Help
Please post about any issues and problems here: [scMerlin on SNBForums](https://www.snbforums.com/threads/spdmerlin-automated-speedtests-with-graphs.55904/)

## FAQs
### I haven't used scripts before on AsusWRT-Merlin
If this is the first time you are using scripts, don't panic! In your router's WebUI, go to the Administration area of the left menu, and then the System tab. Set Enable JFFS custom scripts and configs to Yes.

Further reading about scripts is available here: [AsusWRT-Merlin User-scripts](https://github.com/RMerl/asuswrt-merlin/wiki/User-scripts)

![WebUI enable scripts](https://puu.sh/A3wnG/00a43283ed.png)