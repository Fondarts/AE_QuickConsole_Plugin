@echo off
echo ========================================
echo Command Console with Settings Installer
echo ========================================
echo.

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running with administrator privileges...
) else (
    echo WARNING: Not running as administrator. Some operations may fail.
    echo.
)

REM Get After Effects installation path
set "AE_PATH="
for /f "tokens=*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Adobe\After Effects" /s /k /f "InstallPath" 2^>nul ^| findstr "InstallPath"') do (
    for /f "tokens=3*" %%j in ("%%i") do set "AE_PATH=%%j %%k"
)

if "%AE_PATH%"=="" (
    echo ERROR: After Effects installation not found in registry.
    echo Please make sure After Effects is properly installed.
    pause
    exit /b 1
)

echo Found After Effects at: %AE_PATH%
echo.

REM Set plugin paths
set "PLUGIN_SOURCE=%~dp0"
set "PLUGIN_DEST=%AE_PATH%\CEP\extensions\AE_QuickConsole_Plugin"

echo Installing Command Console with Settings...
echo Source: %PLUGIN_SOURCE%
echo Destination: %PLUGIN_DEST%
echo.

REM Create destination directory
if not exist "%PLUGIN_DEST%" (
    echo Creating plugin directory...
    mkdir "%PLUGIN_DEST%" 2>nul
    if errorlevel 1 (
        echo ERROR: Failed to create plugin directory.
        echo Please run as administrator or check permissions.
        pause
        exit /b 1
    )
)

REM Copy plugin files
echo Copying plugin files...
xcopy "%PLUGIN_SOURCE%*" "%PLUGIN_DEST%\" /E /I /Y /Q >nul 2>nul
if errorlevel 1 (
    echo ERROR: Failed to copy plugin files.
    echo Please check permissions and try again.
    pause
    exit /b 1
)

echo Plugin files copied successfully.
echo.

REM Enable unsigned extensions
echo Enabling unsigned extensions...
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.9" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.10" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.11" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.12" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.13" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.14" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.15" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.16" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.17" /v PlayerDebugMode /t REG_SZ /d "1" /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.18" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.19" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.20" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul

echo Registry entries updated.
echo.

REM Verify installation
echo Verifying installation...
if exist "%PLUGIN_DEST%\CSXS\manifest.xml" (
    echo ✓ Manifest file found
) else (
    echo ✗ Manifest file missing
    echo Installation failed!
    pause
    exit /b 1
)

if exist "%PLUGIN_DEST%\command_console_with_settings.html" (
    echo ✓ Main HTML file found
) else (
    echo ✗ Main HTML file missing
    echo Installation failed!
    pause
    exit /b 1
)

if exist "%PLUGIN_DEST%\jsx\command_processor_with_settings.jsx" (
    echo ✓ JSX script found
) else (
    echo ✗ JSX script missing
    echo Installation failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Installation completed successfully!
echo ========================================
echo.
echo The Command Console with Settings has been installed.
echo.
echo Next steps:
echo 1. Restart After Effects completely
echo 2. Go to Window ^> Extensions ^> Command Console with Settings
echo 3. Click the settings button (⚙️) to configure shortcuts
echo 4. Set your preferred keyboard shortcut
echo 5. The plugin will check for conflicts with After Effects shortcuts
echo.
echo Features:
echo - Command input with suggestions
echo - Settings panel with shortcut configuration
echo - Conflict detection with After Effects shortcuts
echo - Auto-focus and suggestion toggles
echo - Persistent settings storage
echo.
echo If the plugin doesn't appear:
echo 1. Make sure After Effects is completely restarted
echo 2. Check Window ^> Extensions menu
echo 3. Run this installer again as administrator
echo.
pause

