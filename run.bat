@echo off
setlocal
cd /d "%~dp0"

if not exist ".venv\Scripts\python.exe" (
    echo Creating virtual environment...
    py -m venv .venv
    if errorlevel 1 goto :error
)

echo Installing dependencies...
.venv\Scripts\python.exe -m pip install -r requirements.txt
if errorlevel 1 goto :error

start "" http://127.0.0.1:5000
.venv\Scripts\python.exe ue_blueprint_debloater.py
exit /b 0

:error
echo.
echo Failed to start UE Blueprint Debloater.
pause
exit /b 1
