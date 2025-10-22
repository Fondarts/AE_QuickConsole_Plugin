@echo off
echo ========================================
echo After Effects Restart Helper
echo ========================================
echo.

echo Checking for running After Effects processes...
echo.

REM Check if After Effects is running
tasklist /FI "IMAGENAME eq AfterFX.exe" 2>NUL | find /I /N "AfterFX.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo After Effects is currently running.
    echo.
    echo This script will:
    echo 1. Close After Effects
    echo 2. Wait 5 seconds
    echo 3. Start After Effects again
    echo.
    echo Press any key to continue or close this window to cancel...
    pause >nul
    
    echo Closing After Effects...
    taskkill /F /IM "AfterFX.exe" >nul 2>&1
    
    echo Waiting 5 seconds...
    timeout /t 5 /nobreak >nul
    
    echo Starting After Effects...
    start "" "C:\Program Files\Adobe\Adobe After Effects 2024\Support Files\AfterFX.exe"
    
    REM Try alternative paths if the above doesn't work
    if %errorLevel% neq 0 (
        echo Trying alternative After Effects path...
        start "" "C:\Program Files\Adobe\Adobe After Effects 2023\Support Files\AfterFX.exe"
    )
    
    if %errorLevel% neq 0 (
        echo Trying alternative After Effects path...
        start "" "C:\Program Files\Adobe\Adobe After Effects 2022\Support Files\AfterFX.exe"
    )
    
    if %errorLevel% neq 0 (
        echo Could not find After Effects in standard locations.
        echo Please start After Effects manually.
    )
    
) else (
    echo After Effects is not currently running.
    echo.
    echo Starting After Effects...
    start "" "C:\Program Files\Adobe\Adobe After Effects 2024\Support Files\AfterFX.exe"
    
    REM Try alternative paths if the above doesn't work
    if %errorLevel% neq 0 (
        echo Trying alternative After Effects path...
        start "" "C:\Program Files\Adobe\Adobe After Effects 2023\Support Files\AfterFX.exe"
    )
    
    if %errorLevel% neq 0 (
        echo Trying alternative After Effects path...
        start "" "C:\Program Files\Adobe\Adobe After Effects 2022\Support Files\AfterFX.exe"
    )
    
    if %errorLevel% neq 0 (
        echo Could not find After Effects in standard locations.
        echo Please start After Effects manually.
    )
)

echo.
echo ========================================
echo After Effects restart complete!
echo ========================================
echo.

echo Now check Window ^> Extensions ^> AE Quick Console
echo.

echo Press any key to exit...
pause >nul

