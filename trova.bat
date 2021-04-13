@echo off

set minmaius=true
set subfolders=true

set before=2
set after=0
set filter=true
set str_in_file=false
set strcmp=

:loop

if "%~1" == "-s" (
    set strcmp=%2
    set str_in_file=true
    echo ricerca di %2 ...
    shift
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

if "%~1" == "" ( goto help )
REM if "%~2" == "" ( goto help )
if "%~1" == "-h" ( goto help )
if "%~1" == "-H" ( goto help )

if "%~3" NEQ "" ( goto help )


echo ************************************************************************************

if "%str_in_file%"=="false" (
    dir /s /b %~1
    goto fine
)

if "%subfolders%"=="true" (

    for /r %%i in (%~1) do (
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

    for %%i in (%~1) do (
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


echo ************************************************************************************

goto fine


:help
echo.
echo   eseguire:        trova ^<wildcards^> ^<stringa^>
echo.
echo   esempio:         trova "?time.h;?time.c" "tim_set_ms"
echo                    trova "?time.h,?time.c" "tim_set_ms"
echo                    trova "?time.h ?time.c" "tim_set_ms"
echo                    ricerca dal percorso corrente e in tutte le sottodirectory la stringa "tim_set_ms" in tutti i file che rispettano la sintassi "?time.h;?time.c"
echo.
echo   -g a1 a2 str     mostra a1 righe prima e a2 righe dopo il match con str
echo   -c               cerca solo nella directory corrente
echo   -a               mostra tutti i file ricercati
echo.
:fine