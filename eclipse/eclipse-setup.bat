color 02

cls

@CHOICE /c:Y /m "Write / overwrite local eclipse and workspace folders"

IF ERRORLEVEL ==2 GOTO END

@findstr /c:/workspace .gitignore || echo /workspace>>.gitignore

for /f %%a in ('hostname') do (set "name=%%~a")

robocopy ./eclipse-php-2025-03-R-win32-x86_64 ./eclipse-%name% /s /e /mir /log+:eclipse-copy-log.txt

robocopy ./workspace-default ./workspace /s /e /mir /log+:eclipse-copy-log.txt

findstr /c:/eclipse-%name% .gitignore 

if errorlevel 1 echo /eclipse-%name%>>.gitignore

del eclipse-copy-log.txt

for /f %%a in ('cd') do (set "dir=%%~a")

tools\shortcut /f:..\eclipse.lnk /A:C /t:%dir%\eclipse-%name%\eclipse.exe /w:%dir%\eclipse-%name%

cd..

for /f %%a in ('cd') do (set "dir=%%~a")

eclipse\tools\shortcut /f:xampp-control.lnk /A:C /t:%dir%\xampp-control.exe /w:%dir%

copy xampp-control.lnk %USERPROFILE%\Desktop\xampp-control.lnk

copy eclipse.lnk %USERPROFILE%\Desktop\eclipse.lnk

:END