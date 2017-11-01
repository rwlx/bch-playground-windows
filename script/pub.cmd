@echo off
if exist "%BigClownHub%" (
    "%BigClownHub%\mosquitto\mosquitto_pub" -t %*
)
