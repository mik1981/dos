@echo off
rem set percorso=D:\pc\Sfondi windows
set percorso=C:\Users\Pasinelli\Desktop\Archivio\Sfondi windows
rem set /A tot=0
rem for /R "C:\Users\Pasinelli\Desktop\Archivio\Sfondi windows" %%i in (A????.png) do ( IF %%~zi GTR 400000000 set /A tot=tot+1 )

rem set STR2=(date /T)
rem set STR="C:\Users\Pasinelli\Desktop\Archivio\Sfondi windows\" + (date /T)

rem echo %STR% 
rem %STR% 
rem echo %STR2%
rem %STR2%
"C:\Program Files\IrfanView\i_view64.exe" /clippaste /crop=(1920,0,1920,1080) /convert="%percorso%\A0599.png"
explorer "%percorso%"
