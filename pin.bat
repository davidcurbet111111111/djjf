@echo off
setlocal enabledelayedexpansion

:: Generate 4-digit PIN (1000–9999)
set /a pin=%random% %% 9000 + 1000

echo =========================
echo   GENERATED PIN: !pin!
echo =========================

endlocal
