@echo off
echo.
echo ----------------   arresto symantec...   ----------------
rem "c:\Program Files (x86)\Symantec\Symantec Endpoint Protection\14.3.7393.4000.105\Bin\smc" -stop
"C:\Program Files\Symantec\Symantec Endpoint Protection\smc" -stop

echo.
echo.
echo ---------------   avvio servizio di rete   ---------------
net start npf

echo --------------   attesa chiusura finestra   --------------
echo sleep 5
sleep 5