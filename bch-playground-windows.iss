#define MyAppName "BigClown Playground"
#define MyAppVersion "1.0.9"

[Setup]
SignTool=signtool
PrivilegesRequired=admin
AppId={{BDCE012A-ABB1-402A-8E63-8D2DC786C1AD}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher="HARDWARIO s.r.o."
AppPublisherURL="https://www.hardwario.com/"
AppSupportURL="https://www.bigclown.com/contact/"
AppUpdatesURL="https://github.com/bigclownlabs/bch-playground-windows"
UsePreviousAppDir=yes
DefaultDirName={pf}\BigClown Playground
DisableDirPage=yes
DisableProgramGroupPage=yes
DisableFinishedPage=no
OutputBaseFilename=bch-playground-windows-v{#MyAppVersion}
Compression=lzma
SolidCompression=yes
UninstallDisplayIcon={app}\BigClown.ico
ChangesEnvironment=true
ChangesAssociations=true
RestartIfNeededByRun=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "BigClown.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "CHANGELOG.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "script\bcp.cmd"; DestDir: "{app}\script"; Flags: ignoreversion
Source: "script\bcf.cmd"; DestDir: "{app}\script"; Flags: ignoreversion
Source: "script\pub.cmd"; DestDir: "{app}\script"; Flags: ignoreversion
Source: "script\sub.cmd"; DestDir: "{app}\script"; Flags: ignoreversion

; Mosquitto
Source: "mosquitto\*"; DestDir: "{app}\mosquitto"; Flags: ignoreversion recursesubdirs
Source: "download\msvcr100.dll"; DestDir: "{app}\mosquitto"; Flags: ignoreversion

#define Nodejs "node-v8.9.4-x86.msi"
Source: "{#Nodejs}"; DestDir: "{tmp}"

#define Python "python-3.6.4.exe"
Source: "{#Python}"; DestDir: "{tmp}"

#define Clink "clink_0.4.9_setup.exe"
Source: "{#Clink}"; DestDir: "{tmp}"

; USB UART FTDI Virtual COM Port Drivers
; http://www.ftdichip.com/Drivers/VCP.htm
Source: "CDM21228_Setup.exe"; DestDir: "{tmp}";

; USB UART ST Driver
; http://www.st.com/en/development-tools/stsw-stm32102.html
Source: "download\Virtual Com port driver V1.4.0.msi"; DestDir: "{tmp}";

; DFU
; http://zadig.akeo.ie/ https://github.com/pbatard/libwdi
Source: "download\zadig-2.3.exe"; DestDir: "{app}\dfu"; DestName: "zadig.exe"; Flags: ignoreversion
; Multiple installations bloat PNP unfortunately, identify and delete all except one occurence
; pnputil.exe /e | Select-String -Context 2 'Driver package provider :\s+ libwdi' | ForEach-Object { ($_.Context.PreContext[1] -split ' : +')[1] } | ForEach-Object {pnputil /d $_}
Source: "download\zadic.exe"; DestDir: "{app}\dfu"; Flags: ignoreversion
Source: "script\dfu-driver-install.cmd"; DestDir: "{app}\dfu"; Flags: ignoreversion
; https://sourceforge.net/projects/dfu-util/files/?source=navbar
Source: "download\dfu-util-static.exe"; DestDir: "{app}\dfu"; DestName: "dfu-util.exe"; Flags: ignoreversion


[Run]
; Uninstall Python3
Filename: "{tmp}\{#Python}"; Parameters: "/uninstall /passive /norestart"; \
    StatusMsg: "Trying to uninstall Python3, if there is Python3 already installed"

; Install Python3
Filename: "{tmp}\{#Python}"; Parameters: "/passive ""DefaultAllUsersTargetDir={pf}\Python36-32"" InstallAllUsers=1 PrependPath=1 Include_test=0 Include_tcltk=0 Include_launcher=0"; \
    StatusMsg: "Installing {#Python}"

; Upgrade pip3
Filename: "{cmd}"; Parameters: "/c chcp 65001 & set PYTHONIOENCODING=utf-8 & ""{pf}\Python36-32\python.exe"" -m pip install -U git+https://github.com/pypa/pip.git@729990c9869148f3f0098a2b2a0c0b92aefb8a69"; \
    StatusMsg: "Upgrading pip3 from GitHub"
;    Flags: runhidden


; Uninstall Node.js
Filename: "msiexec.exe"; Parameters: "/x ""{tmp}\{#Nodejs}"" /passive /norestart"; \
    WorkingDir: "{%USERPROFILE}"; \
    StatusMsg: "Trying to uninstall Node.js, if there is Node.js already installed"

; Install Node.js
Filename: "msiexec.exe"; Parameters: "/i ""{tmp}\{#Nodejs}"" /passive /norestart"; \
    WorkingDir: "{%USERPROFILE}"; \
    StatusMsg: "Installing {#Nodejs}"

; Install Clink
Filename: "{tmp}\{#Clink}"; \
    Parameters: "/S"; \
    StatusMsg: "Installing {#Clink}"

; Install DFU Drivers
Filename: "{app}\dfu\dfu-driver-install.cmd"; \
    WorkingDir: "{app}\dfu"; \
    StatusMsg: "Installing DFU Driver";  \
    Flags: runhidden

; pnputil.exe -e | Select-String -Context 2 'Driver package provider :\s+ STMicroelectronics' | ForEach-Object { ($_.Context.PreContext[1] -split ' : +')[1] } | ForEach-Object {pnputil -d $_}
; Install USB UART STM32 Virtual COM Port Driver
Filename: "msiexec.exe"; \
    Parameters: "/i ""{tmp}\Virtual Com Port Driver V1.4.0.msi"" /passive /norestart"; \
    StatusMsg: "Installing usb uart STM32 Virtual COM Port Driver"

; Install USB UART FTDI Virtual COM Port Drivers
Filename: "{tmp}\CDM21228_Setup.exe"; \
    StatusMsg: "Installing USB UART FTDI Virtual COM Port Drivers"

; Install bcf BigClown Firmware Tool
Filename: "{cmd}"; Parameters: "/c chcp 65001 & set PYTHONIOENCODING=utf-8 & ""{pf}\Python36-32\Scripts\pip3.exe"" install --upgrade --no-cache-dir bcf"; \
    StatusMsg: "Installing BigClown Firmware Tool, downloading by pip3"
;    Flags: runhidden

; Install bcf BigClown Gateway
Filename: "{cmd}"; Parameters: "/c chcp 65001 & set PYTHONIOENCODING=utf-8 & ""{pf}\Python36-32\Scripts\pip3.exe"" install --upgrade --no-cache-dir bcg"; \
    StatusMsg: "Installing BigClown Gateway, downloading by pip3"
;    Flags: runhidden

; Install Node-RED
Filename: "{pf}\nodejs\node.exe"; \
    Parameters: """{pf}\nodejs\node_modules\npm\bin\npm-cli.js"" install --unsafe-perm -g node-red"; \
    StatusMsg: "Installing Node-RED (it may take a few minutes, downloading by npm)"; \
    WorkingDir: "{%USERPROFILE}"; Flags: runasoriginaluser
; runhidden

; Install PM2
Filename: "{pf}\nodejs\node.exe"; \
    Parameters: """{pf}\nodejs\node_modules\npm\bin\npm-cli.js"" install --unsafe-perm -g pm2"; \
    StatusMsg: "Installing PM2 (it may take a few minutes, downloading by npm)"; \
    WorkingDir: "{%USERPROFILE}";Flags: runasoriginaluser
; runhidden

; Enable Windows firewall for Mosquitto
;https://technet.microsoft.com/en-us/library/dd734783(v=ws.10).aspx
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=Mosquitto"; \
    StatusMsg: "Deleting Windows firewall rules for Mosquitto"; Flags: runhidden
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=Mosquitto dir=in action=allow program=""{app}\mosquitto\mosquitto.exe"" protocol=tcp profile=any edge=deferuser"; \
    StatusMsg: "Enabling Windows firewall for Mosquitto"; \
    Flags: runhidden
; netsh advfirewall firewall show rule name=Mosquitto

; Start Mosquitto service
Filename: "{pf}\nodejs\node.exe"; \
    Parameters: """{%APPDATA}\npm\node_modules\pm2\bin\pm2"" start ""{app}\mosquitto\mosquitto.exe"" --name mosquitto"; \
    WorkingDir: "{%USERPROFILE}"; Flags: runasoriginaluser runhidden; \
    StatusMsg: "Starting Mosquitto MQTT broker service";

; Enable Windows firewall for Node.js Node-RED
Filename: "netsh.exe"; Parameters: "advfirewall firewall delete rule name=Node.js"; \
    StatusMsg: "Deleting Windows firewall rules for Node.js"; Flags: runhidden
Filename: "netsh.exe"; Parameters: "advfirewall firewall add rule name=Node.js dir=in action=allow program=""{pf}\nodejs\node.exe"" protocol=tcp profile=any edge=deferuser"; \
    StatusMsg: "Enabling Windows firewall for Node.js"; \
    Flags: runhidden
;netsh advfirewall firewall show rule name=Node.js
;netsh advfirewall firewall show rule name="Node.js: Server-side JavaScript"

; Start Node-RED service
Filename: "{pf}\nodejs\node.exe"; \
    Parameters: """{%APPDATA}\npm\node_modules\pm2\bin\pm2"" start ""{pf}\nodejs\node.exe"" --name node-red -- ""{%APPDATA}\npm\node_modules\node-red\red.js"""; \
    WorkingDir: "{%USERPROFILE}"; Flags: runasoriginaluser runhidden; \
    StatusMsg: "Starting Node-RED service"

; Save PM2 configuration
Filename: "{pf}\nodejs\node.exe"; \
    Parameters: """{%APPDATA}\npm\node_modules\pm2\bin\pm2"" save"; \
    WorkingDir: "{%USERPROFILE}"; Flags: runasoriginaluser runhidden; \
    StatusMsg: "Saving PM2 configuration"

; Wait for Node-RED start
Filename: {cmd}; Parameters: "/c timeout 15"; Flags: runasoriginaluser runhidden; \
    StatusMsg: "Waiting for Node-RED start"

; Stop Node-RED service for Node-RED-Dashboard installation
; ~/.node-red directory is created now by first Node-RED start
Filename: "{pf}\nodejs\node.exe"; \
    Parameters: """{%APPDATA}\npm\node_modules\pm2\bin\pm2"" stop node-red"; \
    WorkingDir: "{%USERPROFILE}"; Flags: runasoriginaluser runhidden; \
    StatusMsg: "Stopping Node-RED service for Node-RED-Dashboard installation"

; Install Node-RED-Dashboard
Filename: "{pf}\nodejs\node.exe"; \
    Parameters: """{pf}\nodejs\node_modules\npm\bin\npm-cli.js"" install node-red-dashboard"; \
    StatusMsg: "Installing Node-RED-Dashboard (it may take a few minutes, downloading by npm)"; \
    WorkingDir: "{%USERPROFILE}\.node-red"; \
    Flags: runasoriginaluser
; runhidden

; Start Node-RED service again
Filename: "{pf}\nodejs\node.exe"; \
    Parameters: """{%APPDATA}\npm\node_modules\pm2\bin\pm2"" restart node-red"; \
    WorkingDir: "{%USERPROFILE}"; Flags: runasoriginaluser runhidden; \
    StatusMsg: "Restarting Node-RED service"

; Update available BigClown firmwares
Filename: "{cmd}"; \
    Parameters: "/c chcp 65001 & set PYTHONIOENCODING=utf-8 & ""{pf}\Python36-32\Scripts\bcf.exe"" update"; \
    StatusMsg: "Updating available BigClown firmwares"; \
    WorkingDir: "{%USERPROFILE}"; Flags: runasoriginaluser

; Restart bcg service (for case when installer used as upgrade)
Filename: "{pf}\nodejs\node.exe"; \
    Parameters: """{%APPDATA}\npm\node_modules\pm2\bin\pm2"" restart bcg"; \
    WorkingDir: "{%USERPROFILE}"; Flags: runasoriginaluser runhidden; \
    StatusMsg: "Restarting bcg service"

; Wait for Node-RED start
Filename: {cmd}; Parameters: "/c timeout 10"; Flags: runasoriginaluser runhidden; \
    StatusMsg: "Waiting for Node-RED start"

; Navigate web browser to local Node-RED
Filename: http://localhost:1880/; \
    Description: "Open Node-RED in web browser"; \
    Flags: postinstall shellexec runasoriginaluser


[Registry]
; Store BigClown Playground installation directory into BigClown enviroment variable
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "BigClownPlayground"; ValueData: "{app}"; Flags: uninsdeletevalue
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "BigClownPlaygroundVersion"; ValueData: "{#MyAppVersion}"; Flags: uninsdeletevalue
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "BigClownFirmware"; ValueData: "{pf}\Python36-32\Scripts\bcf.exe"; Flags: uninsdeletevalue
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "BigClownGateway"; ValueData: "{pf}\Python36-32\lib\site-packages\bcg\gateway.py"; Flags: uninsdeletevalue


; Add BigClown Scripts into Path
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{app}\script"; \
    Check: NeedsAddPath('{app}\script')

; Add DFU utils into Path
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{app}\dfu"; \
    Check: NeedsAddPath('{app}\dfu')


[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{win}\system32\cmd.exe"; IconFilename: "{app}\BigClown.ico"; \
    Parameters: "/K ""{app}\script\bcp.cmd"""; WorkingDir: "{%USERPROFILE}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{win}\system32\cmd.exe"; IconFilename: "{app}\BigClown.ico"; \
    Parameters: "/K ""{app}\script\bcp.cmd"""; WorkingDir: "{%USERPROFILE}"


[Code]
function InitializeSetup(): Boolean;
var
   ResultCode: integer;
begin
   ExecAsOriginalUser(ExpandConstant('{%APPDATA}\npm\pm2.cmd'), 'delete mosquitto', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)
   ExecAsOriginalUser(ExpandConstant('{%APPDATA}\npm\pm2.cmd'), 'delete node-red', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)
   ExecAsOriginalUser(ExpandConstant('{%APPDATA}\npm\pm2.cmd'), 'stop bcg', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)
   ExecAsOriginalUser(ExpandConstant('{%APPDATA}\npm\pm2.cmd'), 'kill', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)
   Result := True;
end;

const EnvironmentKey = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';

{WARNING works for set of paths who are not substrings to each other}
function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', OrigPath)
  then begin
    Result := True;
    exit;
  end;
  { look for the path with leading semicolon}
  { Pos() returns 0 if not found }
  Log('PATH: ' +  ExpandConstant(Param));
  Result := Pos(';' + ExpandConstant(Param), ';' + OrigPath) = 0;
end;

{WARNING works for set of paths who are not substrings to each other}
procedure RemovePath(Path: string);
var
  Paths: string;
  P: Integer;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', Paths) then
  begin
    Log('PATH not found');
  end
    else
  begin
    Log(Format('PATH is [%s]', [Paths]));

    P := Pos(';' + Uppercase(Path), ';' + Uppercase(Paths));
    if P = 0 then
    begin
      Log(Format('Path [%s] not found in PATH', [Path]));
    end
      else
    begin
      Delete(Paths, P - 1, Length(Path) + 1);
      Log(Format('Path [%s] removed from PATH => [%s]', [Path, Paths]));

      if RegWriteStringValue(HKEY_LOCAL_MACHINE, EnvironmentKey, 'Path', Paths) then
      begin
        Log('PATH written');
      end
        else
      begin
        Log('Error writing PATH');
      end;
    end;
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then
  begin
    RemovePath(ExpandConstant('{app}\script'));
  end;
end;

[UninstallRun]
Filename: "{%APPDATA}\npm\pm2"; Parameters: "delete mosquitto"; Flags: runhidden; \
  StatusMsg: "Stopping PM2 service mosquitto"
Filename: "{%APPDATA}\npm\pm2"; Parameters: "delete node-red"; Flags: runhidden; \
  StatusMsg: "Stopping PM2 service mosquitto"
Filename: "{%APPDATA}\npm\pm2"; Parameters: "delete bcg"; Flags: runhidden; \
  StatusMsg: "Stopping PM2 service mosquitto"  
Filename: "{%APPDATA}\npm\pm2"; Parameters: "kill"; Flags: runhidden; \
  StatusMsg: "Stopping PM2"

[UninstallDelete]
Type: filesandordirs; Name: "{app}"
Type: filesandordirs; Name: "{%USERPROFILE}\.pm2"
