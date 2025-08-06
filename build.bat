@echo off
curl -O https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js
FOR /F "tokens=*" %%g IN ('findstr "version:" user.js') do (SET version=%%g)
FOR /F "tokens=*" %%g IN ('findstr "version:" okayfox.js') do (SET version_copy=%%g)
set /a version=%version:~11,-1%
set /a version_copy=%version_copy:~11,-1%
@echo user.js version: %version%
@echo okayfox.js version: %version%
if %version_copy% neq %version% (
  @echo okayfox.js is outdated! (%version_copy% vs %version%)
)
if %version_copy% == %version% (
  busybox diff -u user.js okayfox.js > okayfox.patch
  busybox patch user.js okayfox.patch
)
