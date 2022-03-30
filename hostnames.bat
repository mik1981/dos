@echo off
@for /L %%N in (1,1,255) do (
    @title subnet %* - ping 192.168.%1.%%N...
    @ping -a -n 1 192.168.%1.%%N | grep "\[192.168" 
)