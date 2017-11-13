powershell -command "pnputil.exe /e | Select-String -Context 2 'Driver package provider :\s+ libwdi' | ForEach-Object { ($_.Context.PreContext[1] -split ' : +')[1] } | ForEach-Object {pnputil /d $_}"
"%BigClownPlayground%\dfu\zadic.exe" --vid 0x0483 --pid 0xDF11 --create stm32dfu
rmdir /S /Q "%BigClownPlayground%\dfu\usb_driver"
