@echo off

set ippc=172.19.14.53


if "%1"=="-h" (
    echo Visualizza popup con il messaggio passato per argomento
    echo Il contenuto del messaggio e' da passare senza virgolette
    echo.
    echo    info la piu' bella frase del mondo
    echo.


) else (
    if "%1"=="" ( msg /SERVER:%ippc% Michele "Scaduto messaggio generico"
    ) else ( msg /SERVER:%ippc% Michele "%*" )
)