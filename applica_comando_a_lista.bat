@echo off

if "%~1"=="" (
    echo specificare file lista e comando da applicare
    goto fine
)

if "%~2"=="" (
    echo specificare comando da applicare
    goto fine
)

for /F "delims=" %%x in (%1) do (
    echo applico %2 a %%x
    rem %~2 %%x
    %2 %%x C:\Users\Pasinelli\Desktop\Archivio\provaVbs\_cest

)


:fine