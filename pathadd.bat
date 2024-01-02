@echo off
setlocal EnableDelayedExpansion

if "%~1"=="" (
    echo !PATH:;=^

!
    echo.
    echo specificare il percorso da aggiungere
    echo es: %0 path
    goto fine
)

set PATH=%PATH%;%~1

echo !PATH:;=^

!

:fine
