@echo off
set filter=* 
if "%1" == "" goto help
if "%1" == "-h" goto help

echo dir /s /b "%*"
dir /s /b "%*"

goto fine

:help
echo cerca i file selezionati della directory specificata
echo %0 "wildcard"
echo.
echo %0 *.c     cerca dalla sottodirectory corrente tutti i file compatibili con la maschera "*.c"
echo.

:fine