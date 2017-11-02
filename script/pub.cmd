@echo off
if exist "%BigClownPlayground%" (
    "%BigClownPlayground%\mosquitto\mosquitto_pub" -t %*
)
