@echo off

set pspadPgm="C:\Users\Pasinelli\Desktop\Archivio\proglink\_programmi\Varie\Editor\PSPad Editor5.5.1\PSPad.exe"

if not exist %pspadPgm% (
    echo il programma "%pspadFile%" non esiste
    goto end
)

set /a argC=0
for %%x in (%*) do Set /A argC+=1

if "%1"=="-h" goto help

set file=%1
set arg1=%1

for /f "delims=£" %%i in ('C:\Users\Pasinelli\Desktop\Archivio\Script\dos\cbecho.exe -b') do (
    if exist %%i (
        echo nella clipboard c'e':  %%i
        set file=%%i

    ) else (
        echo nella clipboard non c'e' un file:  %%i

    )
)

REM set file=%file:/=\%

if %argC%==0 (
        set /a arg1isNmb=0

        if exist %file% (
            echo lunch file da cb: PSPad.exe %file%
            %pspadPgm% %file%
            goto end
        )

) else (
            echo b
    set /a arg1isNmb=%1

    if "%arg1:~0,1%"=="-" (
        if exist %file% (
            echo lunch file da cb alla riga %1: PSPad.exe %file% %1
            %pspadPgm% %file% %1
            goto end
        )

    ) else (

        if "%arg1isNmb%"=="%arg1%" (
            if exist %file% (
                echo lunch file da cb alla riga %1: PSPad.exe %file% -%1
                %pspadPgm% %file% -%1
                goto end
            )

        ) else (

            if %argC%==2 (
                if exist %file% (
                    echo lunch file da cb: PSPad.exe %file% %1
                    %pspadPgm% %file% %1
                    goto end
                )

            ) else (
                if exist %file% (
                    echo lunch file da cb: PSPad.exe %file%
                    %pspadPgm% %file%
                    goto end
                )

            )
        )
    )
)


if %argC%==0 goto help

if %argC%==1 (
    if exist %file% (
        echo lunch: PSPad.exe %file% %1

REM         if "%%1:~0,1%"=="-" (
REM             %pspadPgm% %file% %1
REM
REM         ) else (
REM             echo aggiunto "-" per salto a linea richiesta
            %pspadPgm% %file% -%1
REM         )

    ) else if exist %1 (
        echo lunch: PSPad.exe %1
        %pspadPgm% %1

    ) else (
        echo *******  il file ... %file% ... o il file ...  %1 ... non esistono  *******
    )


    goto end

)

if %argC%==2 (
    echo avvio dei file %1 e %2...
    if "%%2:~0,1%"=="-" (
        %pspadPgm% %*

    ) else (
        rem echo aggiunto "-" per salto a linea richiesta
        %pspadPgm% %1 -%2
    )

)

if %argC%>2 (
    echo avvio dei %argC files...
    %pspadPgm% %*
)

goto end


:help

echo.
echo esempi:
echo        pspad prova.txt -30           -- salta alla riga 30 del file prova.txt
echo        pspad prova.txt 30            -- salta alla riga 30 del file prova.txt
echo        pspad -30                     -- salta alla riga 30 del file presente negli appunti di windows
echo        pspad prova.txt               -- apre il file prova.txt normalmente
echo.


:end