@echo off
set corrispondenza=true
set filename=%0

:ricomincia

if "%1" == "" goto help

if "%1" == "-h" goto help

if "%1" == "-n" (
    set corrispondenza=false
    shift
    goto ricomincia
)

if "%1" == "-f" (
    set dir2=%~2%
    shift
    shift
    goto ricomincia
)


echo avvio...
time /t

FOR /r "%1" %%f IN (*) DO (
    set trovato=false
    FOR  /r "%dir2%" %%j IN (*) DO (
       if "%%f" NEQ "%%j" (
            if "%%~nf" == "%%~nj" (
                set trovato=true
                if "%corrispondenza%"=="true" (
                    echo duplicato del "%%~nf"  ----  del "%%~nj" --- in "%%~pf" e "%%~pj"

                )
            ) else (
                set trovato=true
            )
       )
    )

    if "%trovato%"=="true" if "%corrispondenza%"=="false" (
        echo manca copia "%%~nf"  ----  del "%%~nj"
    )
)

echo fine...
time /t

goto fine

:help
echo confronta i file a partire da una cartella radice
echo.
echo    %filename% dir
echo    %filename% -f dir1 dir2
echo.
echo dir, dir1 e dir2 non possono essere vuoti
echo.
echo -n inverte la ricerca e mostra tutti i file che non trovano corrispondenza
echo.

:fine