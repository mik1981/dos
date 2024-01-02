@echo off

set perc="s:\Reparti\Progettazione\Datasheet"

if "%1"=="" goto help

setlocal EnableExtensions EnableDelayedExpansion

pushd %perc%
for /f "delims=£" %%i in ('where trova.bat') do set cmd_trova=%%i
echo esecuzione di %cmd_trova% *%**.pdf
%cmd_trova% *%**.pdf
popd
goto fine

:help
echo.
echo Nessun argomento passato!
echo Ricerca i wildcards passati sotto il percordo %perc%
echo.
echo.

:fine
