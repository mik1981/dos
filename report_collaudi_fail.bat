set ts=%date:~6,4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%

forfiles /d +%date% /p S:\Archivio\DocProd\COLLAUDI\COJ286\REPORT /m *.rpt /c "cmd /c echo @fdate @ftime - @file && type @file | grep --color FAIL"
pause