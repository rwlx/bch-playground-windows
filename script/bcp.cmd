@echo off
if not defined BCP (
    if exist "%BigClownPlayground%" (
        title BigClown Playground v%BigClownPlaygroundVersion%
        set "BCP=%BigClownPlayground%"
        set "Path=%BigClownPlayground%\mosquitto;%BigClownPlayground%\dfu;%Path%"
        chcp 65001
        mode con: cols=120 lines=50
        prompt BCP $p$g
        echo Welcome to BigClown Playground - pm2, bcg, bcf, pub, sub
        echo Documentation https://doc.bigclown.com/
        echo Local Node-RED http://localhost:1880/
    )
)
