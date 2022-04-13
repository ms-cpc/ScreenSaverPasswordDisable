@echo off
:: Screen Saver password disabler.
:: This disabled the password prompt if screen saver turns on, not the screensaver it's self. 
:: Also supposed to remove password promt from session restore (sleep/hibernate?) but untested. Let me know!
:: Created by Sgt. Mark Southby
::ver 20220209a
GOTO SCREEN

:SCREEN
cls
set choice=Q
::REG Query "HKCU\Control panel\Desktop" /v ScreenSaverIsSecure>nul
::if %errorlevel% equ 0 (
for /F "tokens=3" %%A in ('reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ScreenSaverIsSecure"') DO (set value=%%A)
if %value%==1 goto enabled
:disabled
ECHO PASSWORD ON SCREENSAVE RESUME DISABLED
TITLE PASSWORD ON SCREENSAVE RESUME DISABLED
GOTO EXIT
::) else (
:ENABLED
COLOR 04
ECHO PASSWORD ON SCREENSAVE RESUME IS CURRENTLY ENABLED
ECHO WOULD YOU LIKE TO DISABLE PASSWORD ON SESSION RESUME?
::)
set /p pssw=(Y)es or (N)o:
IF %pssw%==Y GOTO dis
IF %pssw%==y GOTO dis
GOTO EXIT

:dis
Reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaverIsSecure /t REG_SZ /d 0 /f
::GO back and check value
GOTO SCREEN

:EXIT
color 0F
pause
