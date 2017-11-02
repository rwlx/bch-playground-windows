@echo off
if exist "%BigClownPlayground%" (
    "%BigClownPlayground%\mosquitto\mosquitto_sub" -v -t %*
)
