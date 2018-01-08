## [v1.0.9](https://github.com/bigclownlabs/bch-playground-windows/releases/tag/v1.0.9)(2018-01-08)

* Update npm execution without intermediate cmd during install
* Update npm install to be visible (remove runhidden)
* Update quotes around all paths with possible space inside passed as args
* Upgrade Node.js to v8.9.4
* Upgrade Clink to v0.4.9

## [v1.0.8](https://github.com/bigclownlabs/bch-playground-windows/releases/tag/v1.0.8)(2017-12-29)

  * Upgrade Python to 3.6.4
  
  ## [v1.0.7](https://github.com/bigclownlabs/bch-playground-windows/releases/tag/v1.0.7)(2017-12-28)

  * Add pip3 upgrade to 10.0.0.dev0 because of UTF-8 encoding errors during simplejson module installation
  * Add dialogue to ask wheather to open Node-RED in browser after installation
  * Show installation finished dialogue after installation
  
  ## [v1.0.6](https://github.com/bigclownlabs/bch-playground-windows/releases/tag/v1.0.6)(2017-12-22)

  * Add set PYTHONIOENCODING=utf-8 for Playground cmd shell

## [v1.0.5](https://github.com/bigclownlabs/bch-playground-windows/releases/tag/v1.0.5)(2017-12-20)

  * Add set PYTHONIOENCODING=utf-8 for all Python operation

## [v1.0.4](https://github.com/bigclownlabs/bch-playground-windows/releases/tag/v1.0.4)(2017-12-20)

  * Update UTF-8 console for all Python operation

## [v1.0.3](https://github.com/bigclownlabs/bch-playground-windows/releases/tag/v1.0.3)(2017-12-20)

  * Update pm2 restart bcg for upgrades
  * Fix pm2 InitializeSetup
  * Show pip3 installation of bcf and bcg

## [v1.0.2](https://github.com/bigclownlabs/bch-playground-windows/releases/tag/v1.0.2)(2017-12-19)

  * Update pm2 install/update commands
  * Fix Node-RED start
  * Update DFU driver installation

## [v1.0.1](https://github.com/bigclownlabs/bch-playground-windows/releases/tag/v1.0.1)(2017-12-11)

  * Add pm2 save during installation
  * Fix pm2 paths for cleaning during uninstall
  * Update Node.js to v8.9.3

## [v1.0.0](https://github.com/bigclownlabs/bch-playground-windows/releases/tag/v1.0.0)(2017-11-19)

  * Add BigClownGateway environment variable
  * Fix DFU driver install - do not install libwdi driver if it is installed

## [v1.0.0-rc7](https://github.com/bigclownlabs/bch-playground-windows/releases/tag/v1.0.0-rc7)(2017-11-13)

  * Fix Node-RED instalation
  * Fix DFU driver installation - remove all libwdi drivers before installation
  * Upgrade Node.js to v8.9.1
  * Upgrade Win32OpenSSL Light to v1.0.2m
  * Set Unicode for console
  * Fix bcf update during install
  * Stop PM2 during uninstall
  * Fix pnputils execution during DFU driver installation

## [v1.0.0-rc6](https://github.com/bigclownlabs/bch-playground-windows/releases/tag/v1.0.0-rc6)(2017-11-02)

  * Add msvcr100.dll to Mosquitto
  * Update BigClown Firmware Tool references (Tool instead of Flasher)
  * Add autoconfiguration of Windows firewall
  * Add Windows firewall configuration for Mosquitto and Node.js into installation
  * Add https://github.com/node-red/node-red-dashboard

## [v1.0.0-rc5](https://github.com/bigclownlabs/bch-playground-windows/releases/tag/v1.0.0-rc5) (2017-11-02)

  * Rename repository to bch-playground-windows
  * Fix DFU driver install paths
  * Fix PM2 services setup

## [v1.0.0-rc4](https://github.com/bigclownlabs/bch-hub-windows/releases/tag/v1.0.0-rc4) (2017-11-02)

 * Try to uninstall Python3 and Node.js before installation
 * Hide cmd script windows

## [v1.0.0-rc3](https://github.com/bigclownlabs/bch-hub-windows/releases/tag/v1.0.0-rc3) (2017-11-01)

 * Fix Python3 DefaultAllUsersTargetDir
 * Update README, Add services list

## [v1.0.0-rc2](https://github.com/bigclownlabs/bch-hub-windows/releases/tag/v1.0.0-rc2) (2017-11-01)

  * Add OpenSSL binary to Mosquitto installation
  * Update README
  * Fix Python installation TargetDir path to Program Files
  * Add bcf.cmd
  * Fix bch.cmd paths

## [v1.0.0-rc1](https://github.com/bigclownlabs/bch-hub-windows/releases/tag/v1.0.0-rc1) (2017-11-01)

Initial prerelease.
