@echo off

set debug=false
set file=false
set checkhash=false
set sleeptime=4
set checkerror=false

REM setlocal enableDelayedExpansion

:loop

if "%~1"=="-s" (
    set sleeptime=%2
    shift
    shift
    goto loop
)

if "%~1"=="-d" (
    if "%debug%"=="true" goto help
    set debug=true
    shift
    goto loop
)

if "%~1"=="-f" (
    if "%file%"=="true" goto help
    set file=true
    shift
    goto loop
)

if "%~1"=="-e" (
    if "%checkerror%"=="true" goto help
    set checkerror=true
    shift
    goto loop
)

if "%~1"=="-h" (
    if "%checkhash%"=="true" goto help
    set checkhash=true
    shift
    goto loop
)

if "%~1" == "-h" goto help
if "%~1" == "" goto help
if "%~2" == "" goto help


if "%file%"=="true" goto crea_file



:crea_directory

for /f "tokens=1* delims=\" %%A in ('forfiles /s /p "%~1" /m * /c "cmd /c if @isdir==TRUE echo @relpath"') do for %%F in (^"%%B) do (
    rem echo %%~F
    if "%debug%"=="true" (
        echo testing dir... "%~2\%%~F"
        sleep 1
    ) else (
        mkdir "%~2\%%~F"
        echo creating... "%~2\%%~F"
        choice /c CA /m "Premi A per annullare... " /d A /t %sleeptime% /n
    )
)

goto fine


:crea_file

REM set md5=


for /f "tokens=1* delims=\" %%A in ('forfiles /s /p "%~1" /m *.* /c "cmd /c echo @relpath"') do for %%F in (^"%%B) do (
    rem echo %%~F
REM     set hashsrc=%%i
REM     for /f %%i in ('md5 "%~1\%%~F"') do (
REM         set hashsrc=%%i
REM         echo %%i
REM     )
REM
REM     set md5=
REM     set file="%~1\%%~F"
REM     for /f %%i in ('certutil -hashfile "%file%" md5 ^| grep -E "[0-9][a-f]"') do echo set "md5=%%i"
REM
REM     echo %ERRORLEVEL%  --- "%md5%"  ----  "%hashdst%"  --- "%~1\%%~F"
REM     endlocal
REM
    if "1"=="2" (
        echo.

    ) else if exist "%~1\%%~F\*" (
        if "%checkerror%"=="false" ( echo  +  e' una directory "%~1\%%~F" )

    ) else if not exist "%~1\%%~F" (
        echo --- file non trovato..... "%~1\%%~F"

    ) else if exist "%~2\%%~F" (

        if "%checkerror%"=="false" ( echo     file gia' in ..... "%~2\%%~F" )

REM         if "%checkhash%"=="true" (
REM             set hashsrc=
REM             set hashdst=
            rem for /f %%i in ('md5 "%~1\%%~F"') do set hashsrc=%%i
            rem for /f %%i in ('md5 "%~2\%%~F"') do set hashdst=%%i
            rem echo verifing... "%~1\%%~F"
REM             call md5 "%~1\%%~F" hashsrc
            rem echo verifing 2 ... "%~1\%%~F"
REM             md5 "%~2\%%~F" hashdst
REM             echo %ERRORLEVEL%  --- "%hashsrc%"  ----  "%hashdst%"  --- "%~1\%%~F"
REM
REM             if "%hashsrc%"=="%hashdst%" (
REM                 echo --- gia' copiato "%~2\%%~F" -- checksum ok
REM             ) else (
REM                 echo ******** checksum error per "%~2\%%~F" ********
REM                 echo "%~2\%%~F" >>copia_problemi.txt
REM             )
REM         )

    ) else if "%checkerror%"=="false" if "%debug%"=="true" (
            echo testing file... da "%~1\%%~F" a "%~2\%%~F"

            if "%checkhash%"=="true" (
                set hashsrc=
                for /f %%i in ('md5 "%~1\%%~F"') do set hashsrc=%%i
                echo %hashsrc%
            ) else (
                sleep 1
            )

        ) else (
            echo copying... "%~2\%%~F"
            copy /v "%~1\%%~F" "%~2\%%~F"
            choice /c CA /m "Premi A per annullare... " /d C /t %sleeptime% /n
            if ERRORLEVEL==2 (
                echo ----------------    chiusura anticipata    ----------------
                goto fine
            )
        )

    )
)

goto fine


# non funziona proprio a dovere
REM for /f "delims=|" %%c in ('dir /s /b "%~1\*."') do (
REM     if "%debug%"=="true" (
REM         echo test B... "%%~pc"
REM         sleep 1
REM     ) else (
REM         mkdir "%~2%%~pc%%~nc"
REM         echo creating... "%2%%~pc%%~nc"
REM         sleep 4
REM     )
)

goto fine

:help
echo.
echo    replica l'albero delle directory a partire dalla sorgente alla destizione
echo.
echo    arg1=directory sorgente senza barra finale
echo    arg2=directory di destinazione senza barra finale
echo.
echo    -d      debug mode  mostra l'elenco delle intenzioni senza operare
echo    -f      file mode   copia tutti i files al posto delle directory
echo    -h      check hash  verifica che gli hash corrispondano per file gia' copiati
echo    -s nn   nn e' il tempo in secondi d'attesa tra un trasferimento e l'altro -^> %sleeptime%s se omesso
echo    -e      elenca solo gli errori
echo.

:fine
