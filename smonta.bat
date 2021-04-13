@echo off

if "%~1" == "" ( goto help )
if "%~2" NEQ "" ( goto help )

set /a retry=1
set /a maxretry=5

:riprova
mountvol %1 /d

if %ERRORLEVEL% NEQ 0 (
    set /a retry=%retry%+1
    if %retry% == %maxretry% (
        echo IMPOSSIBILE CONCLUDERE LA OPERAZIONE
        goto fine 
    )
    echo fallito -- attesa 5" per %retry%/%maxretry% tentativo...
    sleep 5
    goto riprova
)

goto fine


:help
echo.
echo eseguire:          smonta unita' 
echo.
echo esempio:           smonta e:
echo.

:fine