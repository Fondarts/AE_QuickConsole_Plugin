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

REM Try multiple methods to find After Effects
set "AE_PATH="
set "AE_FOUND=0"

echo Searching for After Effects installation...

REM Method 1: Check common installation paths
if exist "C:\Program Files\Adobe\Adobe After Effects 2024\AfterFX.exe" (
    set "AE_PATH=C:\Program Files\Adobe\Adobe After Effects 2024"
    set "AE_FOUND=1"
    echo Found After Effects at: C:\Program Files\Adobe\Adobe After Effects 2024
    goto :found_ae
)
if exist "C:\Program Files\Adobe\Adobe After Effects 2023\AfterFX.exe" (
    set "AE_PATH=C:\Program Files\Adobe\Adobe After Effects 2023"
    set "AE_FOUND=1"
    echo Found After Effects at: C:\Program Files\Adobe\Adobe After Effects 2023
    goto :found_ae
)
if exist "C:\Program Files\Adobe\Adobe After Effects 2022\AfterFX.exe" (
    set "AE_PATH=C:\Program Files\Adobe\Adobe After Effects 2022"
    set "AE_FOUND=1"
    echo Found After Effects at: C:\Program Files\Adobe\Adobe After Effects 2022
    goto :found_ae
)
if exist "C:\Program Files\Adobe\Adobe After Effects 2021\AfterFX.exe" (
    set "AE_PATH=C:\Program Files\Adobe\Adobe After Effects 2021"
    set "AE_FOUND=1"
    echo Found After Effects at: C:\Program Files\Adobe\Adobe After Effects 2021
    goto :found_ae
)
if exist "C:\Program Files\Adobe\Adobe After Effects 2020\AfterFX.exe" (
    set "AE_PATH=C:\Program Files\Adobe\Adobe After Effects 2020"
    set "AE_FOUND=1"
    echo Found After Effects at: C:\Program Files\Adobe\Adobe After Effects 2020
    goto :found_ae
)

REM Method 2: Check registry
echo Checking registry...
for /f "tokens=*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Adobe\After Effects" /s /k /f "InstallPath" 2^>nul ^| findstr "InstallPath"') do (
    for /f "tokens=3*" %%j in ("%%i") do (
        set "AE_PATH=%%j %%k"
        set "AE_FOUND=1"
        echo Found After Effects in registry: %%j %%k
        goto :found_ae
    )
)

REM Method 3: Check user registry
for /f "tokens=*" %%i in ('reg query "HKEY_CURRENT_USER\SOFTWARE\Adobe\After Effects" /s /k /f "InstallPath" 2^>nul ^| findstr "InstallPath"') do (
    for /f "tokens=3*" %%j in ("%%i") do (
        set "AE_PATH=%%j %%k"
        set "AE_FOUND=1"
        echo Found After Effects in user registry: %%j %%k
        goto :found_ae
    )
)

REM Method 4: Search for AfterFX.exe
echo Searching for AfterFX.exe...
for /f "delims=" %%i in ('where /r "C:\Program Files" AfterFX.exe 2^>nul') do (
    for %%j in ("%%i") do (
        set "AE_PATH=%%~dpj"
        set "AE_FOUND=1"
        echo Found After Effects at: %%~dpj
        goto :found_ae
    )
)

for /f "delims=" %%i in ('where /r "C:\Program Files (x86)" AfterFX.exe 2^>nul') do (
    for %%j in ("%%i") do (
        set "AE_PATH=%%~dpj"
        set "AE_FOUND=1"
        echo Found After Effects at: %%~dpj
        goto :found_ae
    )
)

:found_ae
if %AE_FOUND%==0 (
    echo.
    echo ERROR: After Effects installation not found.
    echo.
    echo Please ensure After Effects is installed in one of these locations:
    echo - C:\Program Files\Adobe\Adobe After Effects 2024
    echo - C:\Program Files\Adobe\Adobe After Effects 2023
    echo - C:\Program Files\Adobe\Adobe After Effects 2022
    echo - C:\Program Files\Adobe\Adobe After Effects 2021
    echo - C:\Program Files\Adobe\Adobe After Effects 2020
    echo.
    echo Or run this installer as administrator.
    echo.
    pause
    exit /b 1
)

echo.
echo After Effects found at: %AE_PATH%
echo.

REM Set plugin paths
set "PLUGIN_SOURCE=%~dp0"
set "PLUGIN_DEST=%AE_PATH%\CEP\extensions\AE_QuickConsole_Plugin"
set "USER_PLUGIN_DEST=%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"

echo Installing Command Console with Settings...
echo Source: %PLUGIN_SOURCE%
echo System Destination: %PLUGIN_DEST%
echo User Destination: %USER_PLUGIN_DEST%
echo.

REM Try system installation first
echo Attempting system installation...
if not exist "%PLUGIN_DEST%" (
    echo Creating system plugin directory...
    mkdir "%PLUGIN_DEST%" 2>nul
    if errorlevel 1 (
        echo System installation failed. Trying user installation...
        goto :user_install
    )
)

echo Copying plugin files to system location...
xcopy "%PLUGIN_SOURCE%*" "%PLUGIN_DEST%\" /E /I /Y /Q >nul 2>nul
if errorlevel 1 (
    echo System installation failed. Trying user installation...
    goto :user_install
)

echo System installation successful!
goto :enable_extensions

:user_install
echo.
echo Attempting user installation...
if not exist "%USER_PLUGIN_DEST%" (
    echo Creating user plugin directory...
    mkdir "%USER_PLUGIN_DEST%" 2>nul
    if errorlevel 1 (
        echo ERROR: Failed to create user plugin directory.
        echo Please run as administrator or check permissions.
        pause
        exit /b 1
    )
)

echo Copying plugin files to user location...
xcopy "%PLUGIN_SOURCE%*" "%USER_PLUGIN_DEST%\" /E /I /Y /Q >nul 2>nul
if errorlevel 1 (
    echo ERROR: Failed to copy plugin files.
    echo Please check permissions and try again.
    pause
    exit /b 1
)

echo User installation successful!
set "PLUGIN_DEST=%USER_PLUGIN_DEST%"

:enable_extensions
echo.
echo Enabling unsigned extensions...
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.9" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.10" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.11" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.12" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.13" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.14" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.15" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.16" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.17" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>nul
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
echo Installation location: %PLUGIN_DEST%
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
