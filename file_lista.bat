@echo off
set filter=* 
if "%1" == "" goto help
if "%1" == "-h" goto help
if "%1" == "-g" ( 
    set filter=%~2 
    shift  
    shift  
)

if "%1" == "-f" (
    FOR /r "%2" %%f IN (%filter%) DO echo %%~nf
) else (
    FOR /r "%1" %%f IN (%filter%) DO echo %%~nf	%%~pf
)

goto fine

:help
echo elenca i file per nome della directory specificata 
echo %0 -g "filter1 filter2 ..." dir
echo dir non può essere vuota
echo.
echo -f     mostra solo il nome del file
echo -g     filtra i file per le estensioni specificate 

:fine