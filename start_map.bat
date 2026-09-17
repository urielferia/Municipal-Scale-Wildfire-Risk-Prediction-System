@echo off
title Tayun-Fire ? Wildfire Risk Map
cd /d "%~dp0"

echo.
echo  ================================================
echo   Tayun-Fire ? Mexico Wildfire Risk Map
echo  ================================================
echo.

REM ?? Activate the virtual environment
if not exist "venv\Scripts\activate.bat" (
    echo  [ERROR] Virtual environment not found.
    echo  Run:  python -m venv venv ^&^& venv\Scripts\pip install -r requirements.txt
    pause
    exit /b 1
)

echo  [1/3] Activating virtual environment...
call venv\Scripts\activate.bat

REM ?? Verify Flask is installed
python -c "import flask" 2^>nul
if errorlevel 1 (
    echo  [2/3] Installing dependencies from requirements.txt...
    pip install -r requirements.txt
) else (
    echo  [2/3] Dependencies OK.
)

REM ?? Start Flask server without watchdog reload to avoid restart loop
echo  [3/3] Starting Flask server...
echo.
echo  ------------------------------------------------
echo   Open your browser at:  http://127.0.0.1:5000
echo  ------------------------------------------------
echo.
echo  Press Ctrl+C to stop the server.
echo.

REM Open Chrome after 2 seconds so Flask has time to boot
start "" /b cmd /c "timeout /t 2 /nobreak ^>nul ^&^& start chrome http://127.0.0.1:5000"

REM Run Flask without --debug to avoid watchdog restart loop on stdlib files
python app.py

pause
