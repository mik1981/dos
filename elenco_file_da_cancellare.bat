@echo off

set dir1="%~1"
set dir2="%~2"
set lista=%~3

echo confronta dir1 dir2 lista
echo.
echo dir1    sorgente da cui ottenere la lista dei file da eliminare (no spazi)
echo dir2    archivio dei dati da non cancellare (no spazi)
echo lista   nome del file compreso di percorso dove riporre la lista dei file da eliminare
echo         nb: lista non puo' contenere spazi sia nel percorso che nel nome del file
echo
echo per l'efficienza del codice e' presupposto dir1 con molti meno elementi di dir2

if "%lista%"=="" goto fine

cls
echo ottenimento lista file sorgenti da confrontare...
time /t
echo.
echo ...forfiles /s /p %dir1% /c "cmd /c if @isdir==FALSE echo @path" ---- %lista%2
forfiles /s /p %dir1% /c "cmd /c if @isdir==FALSE echo @path" >%lista%2
echo.
echo.
echo confronto lista con l'archivio..
time /t
echo.
echo ...forfiles /s /p %dir2% /c "cmd /c grep -i @file %lista%2"  ---- %lista%
forfiles /s /p %dir2% /c "cmd /c if @isdir==FALSE grep -i @file %lista%2" >%lista%
REM forfiles /s /p %dir2% /c "cmd /c if @isdir==FALSE echo @path" >%lista%
REM forfiles /s /p %dir2% /c "cmd /c echo grep -i @file %lista%2" >%lista%
echo.
echo.
echo confronto terminato: nel file %lista% e' presente l'elenco dei file cancellabili
time /t
info creato file %lista%

:fine