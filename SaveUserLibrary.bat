REM First mount the drive that will be used for the backup
net use P: \\DC1\Shared\1Backups 

REM Get Current Date
for /F "tokens=1,2,3 delims=_" %%i in ('PowerShell -Command "& {Get-Date -format "MM_dd_yyyy"}"') do (
    set MONTH=%%i
    set DAY=%%j
    set YEAR=%%k
)

REM Make a folder for this PC's user data to be put.
set SaveDirectory=%computername%-%MONTH%.%DAY%.%YEAR%
echo %SaveDirectory%
mkdir P:\%SaveDirectory%
Robocopy C:\Users\ P:\%SaveDirectory% /MIR /XA:SH /XD AppData /XJD /R:5 /W:15 /MT:32 /V /NP /LOG:Backup.log

REM Dismount backup drive
REM net use P: /Delete