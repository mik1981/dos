function date2epoch(myDate)
    Set dateTime = CreateObject("WbemScripting.SWbemDateTime")
    dateTime.SetVarDate (myDate)
    date2epoch = DateDiff("s", "01/01/1970 00:00:00", CDate(dateTime.GetVarDate (false)))
end function


function epoch2date(myEpoch)
    epoch2date = DateAdd("s", myEpoch, "01/01/1970 00:00:00")
end function

Wscript.echo Now() & " is " & date2epoch(Now())

unittime=1651831308
Wscript.echo unittime & " is " & epoch2date(unittime)