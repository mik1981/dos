@echo off



if "%1"=="-h" (
    echo Visualizza popup con il messaggio passago per argomento
    echo Il contenuto del messaggio e' da passare senza virgolette
    echo.
    echo    info la piu' bella frase del mondo
    echo.


) else (
    if "%1"=="" ( msg /SERVER:192.168.67.87 Michele "Scaduto messaggio generico"
    ) else ( msg /SERVER:192.168.67.87 Michele "%*" )
)