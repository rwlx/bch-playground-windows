#define MyAppName "BigClown Hub"
#define MyAppVersion "1.0.0-rc3"

[Setup]
SignTool=signtool
PrivilegesRequired=admin
AppId={{19CC80E2-23C5-4323-AC4C-152B723B9382}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher="HARDWARIO s.r.o."
AppPublisherURL="https://www.hardwario.com/"
AppSupportURL="https://www.bigclown.com/contact/"
AppUpdatesURL="https://github.com/bigclownlabs/bch-hub-windows"
UsePreviousAppDir=yes
DefaultDirName={pf}\BigClown Hub
DisableDirPage=yes
DisableProgramGroupPage=yes
OutputBaseFilename=bch-win-windows-v{#MyAppVersion}
Compression=lzma
SolidCompression=yes
UninstallDisplayIcon={app}\BigClown.ico
ChangesEnvironment=true
ChangesAssociations=true

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "BigClown.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "README.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "CHANGELOG.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "script\bch.cmd"; DestDir: "{app}\script"; Flags: ignoreversion
Source: "script\bcf.cmd"; DestDir: "{app}\script"; Flags: ignoreversion
Source: "script\pub.cmd"; DestDir: "{app}\script"; Flags: ignoreversion
Source: "script\sub.cmd"; DestDir: "{app}\script"; Flags: ignoreversion

; Mosquitto
Source: "mosquitto\*"; DestDir: "{app}\mosquitto"; Flags: ignoreversion recursesubdirs

#define Nodejs "node-v6.11.5-x86.msi"
Source: "{#Nodejs}"; DestDir: "{tmp}"

#define Python "python-3.6.3.exe"
Source: "{#Python}"; DestDir: "{tmp}"

#define Clink "clink_0.4.8_setup.exe"
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
; pnputil /enumdrivers
; pnputil /deletedriver oemXX.inf
Source: "download\zadic.exe"; DestDir: "{app}\dfu"; Flags: ignoreversion
Source: "script\dfu-driver-install.cmd"; DestDir: "{app}\dfu"; Flags: ignoreversion
; https://sourceforge.net/projects/dfu-util/files/?source=navbar
Source: "download\dfu-util-static.exe"; DestDir: "{app}\dfu"; DestName: "dfu-util.exe"; Flags: ignoreversion


[Run]
; Install Node.js
Filename: "msiexec.exe"; \
    Parameters: "/passive /i ""{tmp}\{#Nodejs}"""; \
    StatusMsg: "Installing {#Nodejs}";

; Install Python3
Filename: "{tmp}\{#Python}"; Parameters: "/passive ""DefaultAllUsersTargetDir={pf}\Python36-32"" InstallAllUsers=1 PrependPath=1 Include_test=0 Include_tcltk=0 Include_launcher=0"; \
    StatusMsg: "Installing {#Python}"

; Install bcf BigClown Firmware Flasher
Filename: "{pf}\Python36-32\Scripts\pip3.exe"; Parameters: "install --upgrade --no-cache-dir bcf"; \
    StatusMsg: "Installing BigClown Firmware Flasher"

; Install bcf BigClown Gateway
Filename: "{pf}\Python36-32\Scripts\pip3.exe"; Parameters: "install --upgrade --no-cache-dir bcg"; \
    StatusMsg: "Installing BigClown Gateway"

; Install Node-RED
Filename: "{pf}\nodejs\npm.cmd"; Parameters: "install -g --unsafe-perm node-red"; \
    StatusMsg: "Installing Node-RED"

; Install PM2
Filename: "{pf}\nodejs\npm.cmd"; Parameters: "install -g pm2"; \
    StatusMsg: "Installing PM2";

; Install Clink
Filename: "{tmp}\{#Clink}"; \
    Parameters: "/S"; \
    StatusMsg: "Installing {#Clink}";

; Install DFU Drivers
Filename: "{app}\dfu\dfu-driver-install.cmd"; \
    StatusMsg: "Installing DFU Driver"; \
    Flags: runhidden

; Install USB UART STM32 Virtual COM Port Driver
Filename: "msiexec.exe"; \
    Parameters: "/i ""{tmp}\Virtual Com Port Driver V1.4.0.msi"" /passive /norestart"; \
    StatusMsg: "Installing usb uart STM32 Virtual COM Port Driver";

; Install USB UART FTDI Virtual COM Port Drivers
Filename: "{tmp}\CDM21228_Setup.exe"; \
    StatusMsg: "Installing USB UART FTDI Virtual COM Port Drivers";

; Start Mosquitto service
Filename: "{%APPDATA}\npm\pm2.cmd"; \
    Parameters: "start ""{app}\mosquitto\mosquitto.exe"" --name mosquitto"; \
    WorkingDir: "{app}\mosquitto"; Flags: runasoriginaluser; \
    StatusMsg: "Starting Mosquitto MQTT broker service";

; Start Mosquitto Node-RED
Filename: "{%APPDATA}\npm\pm2.cmd"; \
    Parameters: "start ""{pf}\nodejs\node.exe"" --name node-red -- ""{%APPDATA}\npm\node_modules\node-red\red.js"" -v"; \
    WorkingDir: "{%USERPROFILE}"; Flags: runasoriginaluser; \
    StatusMsg: "Starting Node-RED service";

; Wait for Node-RED start
Filename: {cmd}; Parameters: "/c timeout 15"; Flags: runasoriginaluser runhidden; \
    StatusMsg: "Waiting for Node-RED start";

; Navigate web browser to local Node-RED
Filename: http://localhost:1880/; Flags: shellexec runasoriginaluser


[Registry]
; Store BigClown Hub installation directory into BigClown enviroment variable
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "BigClownHub"; ValueData: "{app}"; Flags: uninsdeletevalue
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "BigClownHubVersion"; ValueData: "{#MyAppVersion}"; Flags: uninsdeletevalue
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "BigClownFirmware"; ValueData: "{pf}\Python36-32\Scripts\bcf.exe"; Flags: uninsdeletevalue

; Add BigClown Scripts into Path
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{app}\script"; \
    Check: NeedsAddPath('{app}\script');

; Add DFU utils into Path
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{app}\dfu"; \
    Check: NeedsAddPath('{app}\dfu')


[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{win}\system32\cmd.exe"; IconFilename: "{app}\BigClown.ico"; \
    Parameters: "/K ""{app}\script\bch.cmd"""; WorkingDir: "{%USERPROFILE}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{win}\system32\cmd.exe"; IconFilename: "{app}\BigClown.ico"; \
    Parameters: "/K ""{app}\script\bch.cmd"""; WorkingDir: "{%USERPROFILE}"


[Code]
const
  EnvironmentKey = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';

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

[UninstallDelete]
Type: filesandordirs; Name: "{app}"
