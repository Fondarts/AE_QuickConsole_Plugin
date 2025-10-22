@echo off
echo Installing AE Quick Console Plugin...
echo.

REM Get the current directory (where this script is located)
set "CURRENT_DIR=%~dp0"
set "PLUGIN_NAME=AE_QuickConsole_Plugin"

REM Copy plugin to After Effects extensions folder
set "AE_EXTENSIONS=%APPDATA%\Adobe\CEP\extensions"

REM Create extensions directory if it doesn't exist
if not exist "%AE_EXTENSIONS%" (
    mkdir "%AE_EXTENSIONS%"
)

REM Copy plugin files from current directory
if exist "%CURRENT_DIR%" (
    xcopy "%CURRENT_DIR%" "%AE_EXTENSIONS%\%PLUGIN_NAME%" /E /I /Y
    echo Plugin copied to: %AE_EXTENSIONS%\%PLUGIN_NAME%
    echo Source directory: %CURRENT_DIR%
) else (
    echo Error: Current directory not found!
    echo Current directory: %CURRENT_DIR%
    pause
    exit /b 1
)

echo.
echo Installation complete!
echo.
echo To test the plugin:
echo 1. Open After Effects
echo 2. Go to Window ^> Extensions ^> Command Console with Settings
echo 3. Create a new composition with some layers
echo 4. Select layers and try commands like: mute, unmute, duplicate, reset
echo 5. Try creating elements: null, adjustment, shape, camera, light
echo 6. Try effects: Gaussian Blur, Glow, etc.
echo.
echo If commands don't work, check the After Effects Info panel for error messages.
echo.
pause
