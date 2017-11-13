<a href="https://www.bigclown.com/"><img src="https://bigclown.sirv.com/logo.png" width="200" height="59" alt="BigClown Logo" align="right"></a>

# BigClown Playground for Windows
For Microsoft Windows 7, 8, 10 (32bit and 64bit).

[BigClown Documentation](https://doc.bigclown.com/)

NOTE: Internet connectivity is required during install for pip and npm package managers.

NOTE: Windows firewall is configured to allow connections from all networks for Node.js and Mosquitto.

WARNING: During installation installer tries to uninstall previously installed Python3 and Node.js because their installers can colide with previously installed versions under certain circumstances.

Hub playground is based on:
  * The MQTT broker [Mosquitto](https://mosquitto.org) (with client tools)
  * The web-based tool [Node-RED](https://nodered.org) for automation flows
  * The process manager [PM2](http://pm2.keymetrics.io) to start the components automatically on boot
  * [BigClown Hub Service](https://github.com/bigclownlabs/bch-usb-gateway/) for BigClown [USB Dongle](https://shop.bigclown.com/products/usb-dongle) - Python application for MQTT/gateway bridging
  * [BigClown Firmware Tool](https://github.com/bigclownlabs/bch-firmware-tool/)

Install destination directories are in `%ProgramFiles(x86)%` on 64bit OS or in `%ProgramFiles%` on 32bit OS:

  * `BigClown Playground` for scripts, Mosquitto and DFU
  * `Python36-32` for Python3
  * `nodejs` for Node.js

Defines [HKLM](https://www.google.com/search?q=hklm) environment variables:

  * `%BigClownPlayground%` pointing to top level directory of installation.
  * `%BigClownPlaygroundVersion%` with BigClown Playground version.
  * `%BigClownFirmware%` pointing to bcf.exe from BigClown Firmware Tool.

**BigClown Playground** can be executed by Desktop icon or from Start menu. Sets Playground enviroment paths for Mosquitto, dfu utils and run `cmd.exe` shell. Other paths (Python3, Node.js, Clink, pip and npm packages) are set from installation OS wide.


## Configured services

  * Node-RED web/application server on http://localhost:1880/
  * Mosquitto MQTT broker
    * mqtt on 1883


## Usage examples

  * `bcf update` - get list of BigClown firmware binaries form GitHub (*Integnet connectivity required*)
  * `bcf devices` - list of available COM devices
  * `bcf flash bigclownlabs/bcf-usb-dongle:latest --device <COMxx>` - flash latest USB Dongle firmware
  * `bcg --list` - list of available COM devices
  * `pm2 start bcg --device <COMxx>` - register and start BigClown Hub Service for BigClown USB Dongle
  * `pm2 list` - list registered services
  * `pub <topic> -m <payload>` e.g. `pub test/temperature -m 21` - MQTT publish 
  * `sub <topic>` e.g. `sub #` - subscribe and listen for all MQTT topics
  * Navigate to local Node-RED http://localhost:1880/


## Components 
32bit versions, drivers 32bit & 64bit:
  * [Mosquitto v1.4.14](https://mosquitto.org)
    * `mosquitto\*`
    * Dependencies:
      * [Win32OpenSSL v1.0.2m Light](https://slproweb.com/products/Win32OpenSSL.html)
      * [pthreadVC2.dll](https://www.sourceware.org/pub/pthreads-win32/dll-latest/dll/x86/pthreadVC2.dll)
      * msvcr100.dll
  * [Node.js v8.9.1 LTS](https://nodejs.org/en/download/) - OS wide install
  * [Python v3.6.3](https://www.python.org/downloads/) - OS wide install
  * [Clink v0.4.8](https://github.com/mridgers/clink/) - OS wide install
  * [FTDI Virtual COM Port Drivers 2.12.28](http://www.ftdichip.com/Drivers/VCP.htm)
  * [dfu-util-static v0.8](https://sourceforge.net/projects/dfu-util/files/dfu-util-0.8-binaries/win32-mingw32/)
    * `dfu\dfu-util.exe`
  * [libwdi v1.2.5](https://github.com/pbatard/libwdi) WinUSB drivers for STM32 DFU
    * `dfu\zadic.exe` - compiled by Microsoft Visual Studio Community Edition with Windows Driver Kit environment according [Compiling libwdi instructions](https://github.com/pbatard/libwdi/wiki/Compiling-and-debugging-libwdi-or-Zadig)
  * [Zadig v2.3](http://zadig.akeo.ie/) USB driver check&fix for STM32 DFU
    * `dfu\zadig-2.3.exe`
  * [STM32 Virtual COM Port Driver v1.4.0](http://www.st.com/en/development-tools/stsw-stm32102.html) - OS wide driver install
  * *pip installed*, up-to-date version from pip repository
    * [BigClown Firmware Tool](https://github.com/bigclownlabs/bch-firmware-tool/)
    * [BigClown Hub Service](https://github.com/bigclownlabs/bch-usb-gateway) for BigClown USB Gateway
  * *npm installed*, up-to-date version from npm repository
    * [Node-RED](https://nodered.org/)
      * [Node-RED-Dashboard](https://github.com/node-red/node-red-dashboard)
    * [PM2](http://pm2.keymetrics.io/)


## Build prerequisites

  * Microsoft Windows 7, 8, 10 (`cmd` shell)
  * [7-Zip](http://www.7-zip.org/download.html)
  * [Inno Setup v5.5.9](http://www.jrsoftware.org/isinfo.php)
  * [Windows 10 SDK](https://go.microsoft.com/fwlink/?LinkID=698771) signtool
    * [Signing Installers You Create with Inno Setup](http://revolution.screenstepslive.com/s/revolution/m/10695/l/563371-signing-installers-you-create-with-inno-setup)
      * `"C:\Program Files (x86)\Windows Kits\10\bin\x64\signtool.exe" sign /f "...\cert.p12" /t http://timestamp.comodoca.com/authenticode /p MY_PASSWORD $f`
  * Internet connectivity


## How to build

  * install prerequisites
  * clone repository from GitHub (or unzip from release repository archive)
  * change to `bch-playground-windows` directory
  * `download`
  * `build`

---

Made with &#x2764;&nbsp; by [**HARDWARIO s.r.o.**](https://www.hardwario.com/) in the heart of Europe.
