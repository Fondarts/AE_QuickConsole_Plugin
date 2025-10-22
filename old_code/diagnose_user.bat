@echo off
echo ========================================
echo Plugin Diagnostic - User Level
echo ========================================
echo.

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "PLUGIN_NAME=AE_QuickConsole_Plugin"

echo Checking plugin installation...
echo.

REM Define user CEP extensions directory
set "USER_CEP_DIR=%APPDATA%\Adobe\CEP\extensions"
set "PLUGIN_PATH=%USER_CEP_DIR%\%PLUGIN_NAME%"

echo User CEP Directory: %USER_CEP_DIR%
echo Plugin Path: %PLUGIN_PATH%
echo.

REM Check if user CEP directory exists
if exist "%USER_CEP_DIR%" (
    echo [OK] User CEP extensions directory exists
) else (
    echo [ERROR] User CEP extensions directory does not exist
    echo Creating directory...
    mkdir "%USER_CEP_DIR%"
    if %errorLevel% == 0 (
        echo [OK] User CEP directory created
    ) else (
        echo [ERROR] Failed to create user CEP directory
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

REM Check if HTML file exists
if exist "%PLUGIN_PATH%\solid_creator.html" (
    echo [OK] solid_creator.html found
) else (
    echo [ERROR] solid_creator.html not found
    echo Expected location: %PLUGIN_PATH%\solid_creator.html
)

REM Check if JSX file exists
if exist "%PLUGIN_PATH%\jsx\solid_creator.jsx" (
    echo [OK] solid_creator.jsx found
) else (
    echo [ERROR] solid_creator.jsx not found
    echo Expected location: %PLUGIN_PATH%\jsx\solid_creator.jsx
)

echo.
echo Checking manifest.xml content...
echo.

REM Check manifest content
if exist "%PLUGIN_PATH%\CSXS\manifest.xml" (
    echo Manifest content:
    type "%PLUGIN_PATH%\CSXS\manifest.xml"
    echo.
) else (
    echo [ERROR] Cannot read manifest.xml
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

echo 1. If manifest.xml is missing or incorrect, the plugin won't appear
echo 2. If PlayerDebugMode is not set to 1, unsigned extensions won't work
echo 3. After Effects must be restarted after any changes
echo 4. Check After Effects console for error messages
echo.

echo Press any key to exit...
pause >nul

