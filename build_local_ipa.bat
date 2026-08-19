@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File %~dp0build_local_ipa.ps1 %*
pause
