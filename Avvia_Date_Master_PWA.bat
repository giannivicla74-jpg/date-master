@echo off
title Date Master PWA - GC CodeLab
echo ========================================================
echo   Date Master PWA - Avvio con Installabilita Completa
echo ========================================================
echo.
echo Avvio del server locale su porta 8080...
start http://localhost:8080/index.html
npx -y http-server -p 8080 -c-1
pause
