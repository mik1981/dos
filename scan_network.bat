@echo off
for /l %%i IN (%1,1,%2) DO (
    echo scan 192.168.%%i.xx...
    time /t
    for /l %%g IN (1,1,255) DO ping -a -4 -n 1 -w 500 192.168.%%i.%%g | grep MFP
)
echo FINE
time /t
