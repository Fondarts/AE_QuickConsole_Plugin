@echo off
echo ========================================
echo AE Quick Console Plugin - Diagnostic Tool
echo ========================================
echo.

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [OK] Running with administrator privileges
) else (
    echo [ERROR] This script requires administrator privileges
    echo Please right-click and select "Run as administrator"
    pause
    exit /b 1
)

echo.
echo Checking plugin installation...
echo.

REM Define paths
set "CEP_DIR=%PROGRAMDATA%\Adobe\CEP\extensions"
set "PLUGIN_NAME=AE_QuickConsole_Plugin"
set "PLUGIN_PATH=%CEP_DIR%\%PLUGIN_NAME%"

echo CEP Extensions Directory: %CEP_DIR%
echo Plugin Path: %PLUGIN_PATH%
echo.

REM Check if CEP directory exists
if exist "%CEP_DIR%" (
    echo [OK] CEP extensions directory exists
) else (
    echo [ERROR] CEP extensions directory does not exist
    echo Creating directory...
    mkdir "%CEP_DIR%"
    if %errorLevel% == 0 (
        echo [OK] CEP directory created
    ) else (
        echo [ERROR] Failed to create CEP directory
        pause
        exit /b 1
    )
)

REM Check if plugin directory exists
if exist "%PLUGIN_PATH%" (
    echo [OK] Plugin directory exists
) else (
    echo [ERROR] Plugin directory does not exist
    echo Expected location: %PLUGIN_PATH%
    pause
    exit /b 1
)

REM Check if manifest.xml exists
if exist "%PLUGIN_PATH%\CSXS\manifest.xml" (
    echo [OK] manifest.xml found
) else (
    echo [ERROR] manifest.xml not found
    echo Expected location: %PLUGIN_PATH%\CSXS\manifest.xml
)

REM Check if index.html exists
if exist "%PLUGIN_PATH%\index.html" (
    echo [OK] index.html found
) else (
    echo [ERROR] index.html not found
    echo Expected location: %PLUGIN_PATH%\index.html
)

REM Check if hostscript.jsx exists
if exist "%PLUGIN_PATH%\jsx\hostscript.jsx" (
    echo [OK] hostscript.jsx found
) else (
    echo [ERROR] hostscript.jsx not found
    echo Expected location: %PLUGIN_PATH%\jsx\hostscript.jsx
)

REM Check if main.js exists
if exist "%PLUGIN_PATH%\js\main.js" (
    echo [OK] main.js found
) else (
    echo [ERROR] main.js not found
    echo Expected location: %PLUGIN_PATH%\js\main.js
)

REM Check if CSInterface.js exists
if exist "%PLUGIN_PATH%\js\lib\CSInterface.js" (
    echo [OK] CSInterface.js found
) else (
    echo [ERROR] CSInterface.js not found
    echo Expected location: %PLUGIN_PATH%\js\lib\CSInterface.js
)

echo.
echo Checking registry settings...
echo.

REM Check registry settings for CSXS versions
for /L %%i in (9,1,20) do (
    reg query "HKEY_CURRENT_USER\Software\Adobe\CSXS.%%i" /v "PlayerDebugMode" >nul 2>&1
    if %errorLevel% == 0 (
        for /f "tokens=3" %%a in ('reg query "HKEY_CURRENT_USER\Software\Adobe\CSXS.%%i" /v "PlayerDebugMode" 2^>nul ^| find "PlayerDebugMode"') do (
            if "%%a"=="0x1" (
                echo [OK] CSXS.%%i PlayerDebugMode = 1
            ) else (
                echo [WARNING] CSXS.%%i PlayerDebugMode = %%a
            )
        )
    ) else (
        echo [WARNING] CSXS.%%i PlayerDebugMode not set
    )
)

echo.
echo Checking After Effects installation...
echo.

REM Check for After Effects installations
set "AE_FOUND=0"

REM Check common After Effects installation paths
for %%p in (
    "%PROGRAMFILES%\Adobe\Adobe After Effects 2024"
    "%PROGRAMFILES%\Adobe\Adobe After Effects 2023"
    "%PROGRAMFILES%\Adobe\Adobe After Effects 2022"
    "%PROGRAMFILES%\Adobe\Adobe After Effects 2021"
    "%PROGRAMFILES%\Adobe\Adobe After Effects 2020"
    "%PROGRAMFILES%\Adobe\Adobe After Effects CC 2019"
    "%PROGRAMFILES%\Adobe\Adobe After Effects CC 2018"
    "%PROGRAMFILES%\Adobe\Adobe After Effects CC 2017"
    "%PROGRAMFILES%\Adobe\Adobe After Effects CC 2015.3"
    "%PROGRAMFILES%\Adobe\Adobe After Effects CC 2015"
    "%PROGRAMFILES%\Adobe\Adobe After Effects CC 2014"
) do (
    if exist "%%p" (
        echo [OK] Found After Effects: %%p
        set "AE_FOUND=1"
    )
)

if %AE_FOUND% == 0 (
    echo [WARNING] No After Effects installation found in common locations
)

echo.
echo ========================================
echo Diagnostic Summary
echo ========================================
echo.

REM List all files in plugin directory
echo Plugin directory contents:
dir "%PLUGIN_PATH%" /b

echo.
echo ========================================
echo Recommendations
echo ========================================
echo.

echo 1. If any files are missing, re-run install.bat
echo 2. If registry settings are wrong, run enable_unsigned_extensions.reg
echo 3. Restart After Effects completely
echo 4. Check Window ^> Extensions menu
echo 5. If still not working, try installing to user directory:
echo    %APPDATA%\Adobe\CEP\extensions\%PLUGIN_NAME%
echo.

echo Press any key to exit...
pause >nul

