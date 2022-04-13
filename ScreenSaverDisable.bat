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
for /F "tokens=3" %%A in ('reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ScreenSaveActive"') DO (set value=%%A)
if %value%==1 goto enabled
ECHO SCREENSAVER DISABLED
TITLE SCREENSAVER DISABLED
GOTO DISABLED

:ENABLED
SET SSE=1
ECHO SCREENSAVER IS CURRENTLY ENABLED
ECHO.
for /F "tokens=3" %%A in ('reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ScreenSaverIsSecure"') DO (set value=%%A)
if %value%==1 goto disabled
ECHO PASSWORD ON SCREENSAVER / SESSION RESUME NOT ENABLED
ECHO WOULD YOU LIKE TO DISABLE THE SCREEN Saver?
set /p pssw=(Y)es or (N)o:
IF %pssw%==Y GOTO diss
IF %pssw%==y GOTO diss
:diss
Reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaveActive /t REG_SZ /d 0 /f
GOTO EXIT
:disabled
for /F "tokens=3" %%A in ('reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v "ScreenSaverIsSecure"') DO (set value=%%A)
if %value%==1 goto SSPW
ECHO PASSWORD ON SCREENSAVER / SESSION RESUME NOT ENABLED
GOTO EXIT

ECHO PASSWORD ON SCREENSAVE RESUME DISABLED
GOTO EXIT
:SSPW
ECHO PASSWORD ON SCREENSAVER / SESSION RESUME ENABLED
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
