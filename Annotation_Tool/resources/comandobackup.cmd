@echo off

FOR /F "tokens=1,2,3 delims=/ " %%a in ("%DATE%") do (
set DIA=%%a
set MES=%%b
set ANO=%%c
)

FOR /F "tokens=1,2,3 delims=:, " %%a in ("%TIME%") do (
set H=%%a
set M=%%b
set S=%%c
)

set FORMATO=%ANO%_%MES%_%DIA%__%H%_%M%_%S%

echo %FORMATO%
c:\xampp\mysql\bin\mysqldump.exe --user=root --host=localhost --port=3306 --result-file="c:\backup\backup.%FORMATO%.sql" --default-character-set=utf8 --databases "annotationtool"