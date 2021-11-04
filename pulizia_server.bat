@echo off

if "%1"=="-h" goto help

REM if "%2"=="" (
    set perc="S:\Reparti\Progettazione\ProgettiAperti"
REM     echo aggiunta percorso di default %perc%
REM
REM ) else ( set perc="%~2"
REM )

echo avvio...
time /t


if "%1"=="-f" (
    forfiles /s /p %perc% /m *.zip /d -365 /c "cmd /c echo @path" | find "HW\History" > files_to_delete.txt
    echo.
REM     for /f "delims=" %%f in (files_to_delete.txt) do del "%%f"

) else if "%1"=="-l" (
    if exist files_to_delete.txt ( for /f "delims=" %%f in (files_to_delete.txt) do del "%%f"

    ) else ( echo impossibile trovare il files_to_delete.txt
    )


) else if "%1"=="-g" (
    forfiles /s /p %perc% /m *.zip /d -365 /c "cmd /c echo @path" | find "HW\History" > files_to_delete.txt

) else (
REM     forfiles /s /p %perc% /m *.zip /d -365 /c "cmd /c echo @fdate @path" | find "HW\History"
    echo forfiles /s /p %perc% /m *~(*).SchDoc.zip /d -365 /c "cmd /c echo @fdate @path"...
    forfiles /s /p %perc% /m *~(*).SchDoc.zip /d -365 /c "cmd /c echo @fdate @path"
)

echo fine...
time /t
pause

goto fine

:help
echo.
echo elimina i file *.zip piu' vecchi di 365gg da HW\History
echo.

:fine