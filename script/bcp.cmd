@echo off
if not defined BCP (
    if exist "%BigClownPlayground%" (
        title BigClown Playground v%BigClownPlaygroundVersion%
        set "BCP=%BigClownPlayground%"
        set "Path=%BigClownPlayground%\mosquitto;%BigClownPlayground%\dfu;%Path%"
        chcp 65001
        set PYTHONIOENCODING=utf-8
        echo Welcome to BigClown Playground - pm2, bcg, bcf, pub, sub
        echo Documentation https://doc.bigclown.com/
        echo Local Node-RED http://localhost:1880/
    )
)
