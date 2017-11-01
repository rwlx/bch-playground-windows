@echo off
if not defined BCH (
    if exist "%BigClownHub%" (
        title BigClown Hub v%BigClownHubVersion%
        set "BCH=%BigClownHub%"
        set "Path=%BigClownHub%\script;%BigClownHub%\dfu;%Path%"
        echo Welcome to BigClown Hub - pm2, bcg, bcf, pub, sub
        echo Documentation https://doc.bigclown.com/
        echo Node-RED http://localhost:1880/
    )
)
