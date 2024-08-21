@echo off
set source=E:\
set destination=F:\

robocopy %source% %destination% /MIR /XO /R:5 /W:5 /LOG:E:\mirror.log

echo Backup completed.
pause
