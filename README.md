# BigClown Hub/playground for Windows
For Microsoft Windows 7, 8, 10 (32bit and 64bit).

[BigClown Documentation](https://doc.bigclown.com/)

NOTE: Internet connectivity is required during install for pip and npm package managers.

Hub playground is based on:
  * The MQTT broker [Mosquitto](https://mosquitto.org) (with client tools)
  * The web-based tool [Node-RED](https://nodered.org) for automation flows
  * The process manager [PM2](http://pm2.keymetrics.io) to start the components automatically on boot
  * [BigClown Hub Service](https://github.com/bigclownlabs/bch-usb-gateway/) for BigClown USB Gateway - Python application for MQTT/gateway bridging
  * [BigClown Firmware Flasher](https://github.com/bigclownlabs/bch-firmware-flasher/)

Default install destination directory is `%ProgramFiles(x86)%` on 64bit OS or into `%ProgramFiles%` on 32bit OS (can be changed by user during installation).
Defines [HKLM](https://www.google.com/search?q=hklm) environment variable `%BigClownHub%` pointing to top level directory of installation.

Set Hub enviroment paths and run `cmd.exe` shell by executing *BigClown Hub* from Start menu or by Desktop icon.


## Usage examples

  * `bcf update`
  * `bcf devices`
  * `bcf flash bigclownlabs/bcf-usb-dongle:latest --device <COMxx>`
  * `bcg --list`
  * `pm2 start bcg --device <COMxx>`
  * `pm2 list`
  * `pub <topic> <payload>`
  * `sub <topic> <payload>`
  * Navigate to local [Node-RED](http://localhost:1880/)


## Components 
32bit versions, drivers 32bit & 64bit:
  * [Mosquitto 1.4.14](https://mosquitto.org)
    * `mosquitto\*`
  * [Node.js 6.11.5 LTS](https://nodejs.org/en/download/)
    * OS wide install
  * [Python 3.6.3](https://www.python.org/downloads/)
    * OS wide install
  * [Clink v0.4.8](https://github.com/mridgers/clink/)
  * [FTDI Virtual COM Port Drivers 2.12.28](http://www.ftdichip.com/Drivers/VCP.htm)
  * [dfu-util-static v0.8](https://sourceforge.net/projects/dfu-util/files/dfu-util-0.8-binaries/win32-mingw32/)
  * [libwdi v1.2.5](https://github.com/pbatard/libwdi) WinUSB drivers for STM32 DFU
  * [Zadig v2.3](http://zadig.akeo.ie/) USB driver check&fix for STM32 DFU
  * [STM32 Virtual COM Port Driver v1.4.0](http://www.st.com/en/development-tools/stsw-stm32102.html)
  * [BigClown Firmware Flasher v0.6.0](https://github.com/bigclownlabs/bch-firmware-flasher/)
    * *pip installed*
  * [BigClown Hub Service v1.8.0](https://github.com/bigclownlabs/bch-usb-gateway) for BigClown USB Gateway
    * *pip installed*
  * [Node-RED](https://nodered.org)
    * *npm installed*
  * [PM2](http://pm2.keymetrics.io/)
    * *npm installed*


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
  * change to `bch-hub-windows` directory
  * `download`
  * `build`
