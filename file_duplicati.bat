@echo off
set corrispondenza=true
set filename=%0
set dir2=%~1%
set onlycurrdir=false

:ricomincia

if "%~1" == "" goto help

if "%~1" == "-h" goto help

if "%~1" == "-n" (
    set corrispondenza=false
    shift
    goto ricomincia
)

if "%~1" == "-f" (
    set dir2=%~2%
    shift
    shift
    goto ricomincia
)

if "%~1" == "-c" (
    set onlycurrdir=true
    shift
    goto ricomincia
)


echo avvio...
time /t

if onlycurrdir==true (
    rem con questo for lavora solo a partire dal percorso corrente
    FOR /r %%f IN (*) DO (
        set trovato=false
        FOR  /r %%j IN (*) DO (
            if "%%~pf" NEQ "%%~pj" (
                if "%%~nxf" == "%%~nxj" (
                    set trovato=true
                    if "%corrispondenza%"=="true" (
                        echo duplicato del "%%~nxf"  ----  del "%%~nxj" --- in "%%~pf" e "%%~pj"

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

) else (
echo confronto tra 2 dir
    FOR /r "%~1" %%f IN (*) DO (
        set trovato=false
        FOR  /r "%dir2%" %%j IN (*) DO (
            if "%%~pf" NEQ "%%~pj" (
                if "%%~nxf" == "%%~nxj" (
                    set trovato=true
                    if "%corrispondenza%"=="true" (
                        echo duplicato del "%%~nxf"  ----  del "%%~nxj" --- in "%%~pf" e "%%~pj"
                        echo "%%~pj\%%~nxj"  >>  log_file_duplicati.txt

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
)

echo fine...
time /t

goto fine

:help
echo confronta i file a partire da una cartella radice
echo.
echo    %filename% dir
echo    %filename% -f dir1 dir2
echo    %filename% -c
echo.
echo dir, dir1 e dir2 non possono essere vuoti
echo.
echo -c ricerca a partire dalla directory corrente
echo -n inverte la ricerca e mostra tutti i file che non trovano corrispondenza
echo.

:fine