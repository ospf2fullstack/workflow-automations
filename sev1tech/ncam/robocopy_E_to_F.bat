@echo off
set source=E:\NCAM
set destination=D:\NCAM

robocopy %source% %destination% /MIR /XO /R:5 /W:5 /LOG:E:\mirror.log

echo Backup completed.
pause
