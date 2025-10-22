@echo off
echo ========================================
echo AE Quick Console Plugin - Script Testing
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

echo Testing different JSX script versions...
echo.

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "PLUGIN_NAME=AE_QuickConsole_Plugin"

REM Define CEP extensions directories
set "SYSTEM_CEP_DIR=%PROGRAMDATA%\Adobe\CEP\extensions"
set "USER_CEP_DIR=%APPDATA%\Adobe\CEP\extensions"

echo Step 1: Testing basic script...
echo.

REM Update manifest to use basic test
echo Updating manifest to use basic test script...
copy "%SCRIPT_DIR%CSXS\manifest.xml" "%SCRIPT_DIR%CSXS\manifest_backup.xml" >nul

REM Create a simple manifest for testing
echo ^<?xml version="1.0" encoding="UTF-8"?^> > "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo ^<ExtensionManifest Version="7.0" ExtensionBundleId="com.quickconsole.ae" ExtensionBundleVersion="1.0.0" ExtensionBundleName="AE Quick Console" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo   ^<ExtensionList^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo     ^<Extension Id="com.quickconsole.ae.panel" Version="1.0.0"/^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo   ^</ExtensionList^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo   ^<ExecutionEnvironment^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo     ^<HostList^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo       ^<Host Name="AEFT" Version="[13.0,99.9]"/^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo     ^</HostList^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo     ^<LocaleList^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo       ^<Locale Code="All"/^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo     ^</LocaleList^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo     ^<RequiredRuntimeList^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo       ^<RequiredRuntime Name="CSXS" Version="9.0"/^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo     ^</RequiredRuntimeList^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo   ^</ExecutionEnvironment^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo   ^<DispatchInfoList^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo     ^<Extension Id="com.quickconsole.ae.panel"^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo       ^<DispatchInfo^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo         ^<Resources^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo           ^<MainPath^>./index.html^</MainPath^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo           ^<ScriptPath^>./jsx/basic_test.jsx^</ScriptPath^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo         ^</Resources^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo         ^<Lifecycle^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo           ^<AutoVisible^>true^</AutoVisible^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo         ^</Lifecycle^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo         ^<UI^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo           ^<Type^>Panel^</Type^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo           ^<Menu^>AE Quick Console^</Menu^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo         ^</UI^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo       ^</DispatchInfo^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo     ^</Extension^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo   ^</DispatchInfoList^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"
echo ^</ExtensionManifest^> >> "%SCRIPT_DIR%CSXS\manifest_test.xml"

copy "%SCRIPT_DIR%CSXS\manifest_test.xml" "%SCRIPT_DIR%CSXS\manifest.xml" >nul

echo Updating plugin installations...
echo.

REM Update system installation
if exist "%SYSTEM_CEP_DIR%\%PLUGIN_NAME%" (
    echo Updating system installation...
    xcopy "%SCRIPT_DIR%*" "%SYSTEM_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q
    if %errorLevel% == 0 (
        echo [OK] System installation updated with basic test
    ) else (
        echo [ERROR] System installation update failed
    )
)

REM Update user installation
if exist "%USER_CEP_DIR%\%PLUGIN_NAME%" (
    echo Updating user installation...
    xcopy "%SCRIPT_DIR%*" "%USER_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q
    if %errorLevel% == 0 (
        echo [OK] User installation updated with basic test
    ) else (
        echo [ERROR] User installation update failed
    )
)

echo.
echo ========================================
echo Basic Test Installation Complete!
echo ========================================
echo.

echo The plugin now uses a basic test script.
echo.
echo Next steps:
echo 1. Restart After Effects completely
echo 2. Open the plugin (Window ^> Extensions ^> AE Quick Console)
echo 3. Try clicking a button - it should work without syntax errors
echo 4. If it works, we'll update to the full script
echo.

echo Press any key to continue to full script installation...
pause >nul

echo.
echo Step 2: Installing full working script...
echo.

REM Restore original manifest
copy "%SCRIPT_DIR%CSXS\manifest_backup.xml" "%SCRIPT_DIR%CSXS\manifest.xml" >nul

REM Update to use working script
echo Updating manifest to use working script...
powershell -Command "(Get-Content '%SCRIPT_DIR%CSXS\manifest.xml') -replace 'simple_hostscript.jsx', 'working_hostscript.jsx' | Set-Content '%SCRIPT_DIR%CSXS\manifest.xml'"

echo Updating plugin installations with working script...
echo.

REM Update system installation
if exist "%SYSTEM_CEP_DIR%\%PLUGIN_NAME%" (
    echo Updating system installation...
    xcopy "%SCRIPT_DIR%*" "%SYSTEM_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q
    if %errorLevel% == 0 (
        echo [OK] System installation updated with working script
    ) else (
        echo [ERROR] System installation update failed
    )
)

REM Update user installation
if exist "%USER_CEP_DIR%\%PLUGIN_NAME%" (
    echo Updating user installation...
    xcopy "%SCRIPT_DIR%*" "%USER_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q
    if %errorLevel% == 0 (
        echo [OK] User installation updated with working script
    ) else (
        echo [ERROR] User installation update failed
    )
)

echo.
echo ========================================
echo Full Script Installation Complete!
echo ========================================
echo.

echo The plugin now uses the full working script.
echo.
echo Final steps:
echo 1. Restart After Effects completely
echo 2. Test all the plugin commands
echo 3. Everything should work now!
echo.

echo Press any key to exit...
pause >nul

