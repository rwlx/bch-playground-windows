rem Mosquitto
powershell -Command "Invoke-WebRequest https://mirrors.nic.cz/eclipse/mosquitto/binary/win32/mosquitto-1.4.14-install-win32.exe -OutFile mosquitto-1.4.14-install-win32.exe"
rem Alternative mirror https://mirror.dkm.cz/eclipse/mosquitto/binary/win32/
if exist mosquitto rmdir /S /Q mosquitto
mkdir mosquitto
cd mosquitto
"%ProgramFiles%\7-Zip\7z.exe" x ..\mosquitto-1.4.14-install-win32.exe
del uninstall.exe
rem Mosquitto dependency pthreads
powershell -Command "Invoke-WebRequest https://www.sourceware.org/pub/pthreads-win32/dll-latest/dll/x86/pthreadVC2.dll -OutFile pthreadVC2.dll"
cd ..
rem Mosquitto dependencies - OpenSSL_Light
powershell -Command "Invoke-WebRequest https://slproweb.com/download/Win32OpenSSL_Light-1_0_2m.exe -OutFile Win32OpenSSL_Light-1_0_2m.exe"
Win32OpenSSL_Light-1_0_2m.exe /SILENT
rem copy C:\Windows\System32\ssleay32.dll mosquitto
rem copy C:\Windows\System32\libeay32.dll mosquitto
copy /Y C:\OpenSSL-Win32\*.dll mosquitto
copy /Y C:\OpenSSL-Win32\bin\* mosquitto
rem Node.js 
powershell -Command "Invoke-WebRequest https://nodejs.org/dist/v8.9.4/node-v8.9.4-x86.msi -OutFile node-v8.9.4-x86.msi"
rem Python
powershell -Command "Invoke-WebRequest https://www.python.org/ftp/python/3.6.4/python-3.6.4.exe -OutFile python-3.6.4.exe"
rem FTDI USB CDC/UART drivers
powershell -Command "Invoke-WebRequest http://www.ftdichip.com/Drivers/CDM/CDM21228_Setup.zip -OutFile CDM21228_Setup.zip"
if exist CDM21228_Setup.exe del CDM21228_Setup.exe
"%ProgramFiles%\7-Zip\7z.exe" x CDM21228_Setup.zip
rem Clink
powershell -Command "Invoke-WebRequest https://github.com/mridgers/clink/releases/download/0.4.9/clink_0.4.9_setup.exe -OutFile clink_0.4.9_setup.exe"
