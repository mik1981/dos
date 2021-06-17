@echo off

set minmaius=true
set subfolders=true

set before=2
set after=0
set filter=true
set str_in_file=false
set feedback=false
set strcmp=
set wildcards=*.c *.h *.cpp *.hpp *.ld *.icf

:loop

if "%~1" == "-h" ( goto help )
if "%~1" == "-H" ( goto help )

if "%~1" == "-s" (
    set strcmp="%~2"
    set str_in_file=true
    echo ricerca di %2 ...
    shift
    shift
    goto loop
)

if "%~1" == "-fb" (
    set feedback=true
    shift
    goto loop
)

if "%~1" == "-i" (
    echo ignoro maiuscole/misnuscole...
    set minmaius=false
    shift
    goto loop
)

if "%~1" == "-g" (
    echo filtro mostrando %2 riga/he prima e %3 dopo...
    set before=%2
    set after=%3
    set filter=true
    shift
    shift
    shift
    goto loop
)

if "%~1" == "-c" (
    echo cerca solo nella directory corrente
    set subfolders=false
    shift
    goto loop
)

if "%~1" == "-a" (
    echo fa il log di tutti i file in cui ha effettuato la ricerca
    set filter=false
    shift
    goto loop
)

REM if "%~1" == "" ( goto help )
if "%~1" EQU "" goto jump_wildcards
set wildcards=%~1
shift
:loop_wildcards
if "%~1"=="" goto jump_wildcards
set wildcards=%wildcards% %~1
shift
goto loop_wildcards
:jump_wildcards

REM if "%~2" == "" ( goto help )

if "%~1" NEQ "" ( goto help )

echo tra i file/s %wildcards% ...
echo ************************************************************************* %time% ***********

if "%str_in_file%"=="false" (
    dir /s /b %wildcards%

) else if "%subfolders%"=="true" (

    for /r %%i in (%wildcards%) do (
        if "%minmaius%"=="false" (
            if "%filter%"=="false" (
                find /n %strcmp% "%%i"
            ) else (
                find /n %strcmp% "%%i" | grep -B %before% -A %after% "\["
            )
        ) else (
            if "%filter%"=="false" (
                find /n /i %strcmp% "%%i"
            ) else (
                find /n /i %strcmp% "%%i" | grep -B %before% -A %after% "\["
            )
        )
    )

) else (

    for %%i in (%wildcards%) do (
        echo find /n %strcmp% "%%i"
        if "%minmaius%"=="false" (
            if "%filter%"=="false" (
                find /n %strcmp% "%%i"
            ) else (
                find /n %strcmp% "%%i" | grep -B %before% -A %after% "\["
            )
        ) else (
            if "%filter%"=="false" (
                find /n /i %strcmp% "%%i"
            ) else (
                find /n /i %strcmp% "%%i" | grep -B %before% -A %after% "\["
            )
        )
    )

)


echo ************************************************************************* %time% ***********

if "%feedback%"=="true" ( info Termine ricerca dei file/s %wildcards% in %cd% ) 

goto fine


:help
echo.
echo   eseguire:        trova -s ^<stringa^> ^<wildcards^>
echo.
echo   esempio:         trova -s "stringa da trovare" *.c *.h
echo                    ricerca dal percorso corrente e in tutte le sottodirectory la stringa "stringa da trovare"
echo                    in tutti i file che rispettano la sintassi "*.c *.h"
echo.
echo   -g a1 a2 str     mostra a1 righe prima e a2 righe dopo il match con str
echo   -c               cerca solo nella directory corrente
echo   -a               mostra tutti i file ricercati
echo   -i               ignora maiuscole-minuscole
echo   -fb              informa con un popup della fine dell'operazione
echo.
echo   se non si specifica un ^<wildcards^> verra' applicato il default *.c *.h *.cpp *.hpp *.ld *.icf
echo.
:fine