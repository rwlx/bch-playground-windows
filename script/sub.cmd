@echo off
if exist "%BigClownHub%" (
    "%BigClownHub%\mosquitto\mosquitto_sub" -v -t %*
)
