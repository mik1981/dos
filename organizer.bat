@echo off
setlocal EnableDelayedExpansion
for %%a in (*.*) do (
    set "fld=%%~na"
    set "newfld=!fld:~0,1!"
    if not exist "!newfld!\*" (
        md "!newfld!"
    )
    echo to "!newfld!" move "%%a"
    move "%%a" "!newfld!"
)


goto fine


@echo off
setlocal

set "basename=."
echo basename = %basename%
for /F "tokens=1* delims=." %%a in ('dir /B /A-D ^| sort /R') do (
    echo.
    echo %%a.%%b    %%a
   set "filename=%%a"
   setlocal EnableDelayedExpansion
   echo !filename:~2!
   for /F "delims=" %%c in ("!basename!") do if "!filename:%%c=!" equ "!filename!" (
      set "basename=!filename!"
      echo md "!basename!"
   )
   echo move "!filename!.%%b" "!basename!"
   for /F "delims=" %%c in ("!basename!") do (
      endlocal
      set "basename=%%c
   )
)

:fine
