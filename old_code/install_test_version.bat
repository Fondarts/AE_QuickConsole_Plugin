@echo off
echo ========================================
echo AE Quick Console Plugin - Test Version
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

echo Installing test version of the plugin...
echo.

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "PLUGIN_NAME=AE_QuickConsole_Plugin"

REM Define CEP extensions directories
set "SYSTEM_CEP_DIR=%PROGRAMDATA%\Adobe\CEP\extensions"
set "USER_CEP_DIR=%APPDATA%\Adobe\CEP\extensions"

echo Creating test version manifest...
echo.

REM Create a simple manifest for testing
echo ^<?xml version="1.0" encoding="UTF-8"?^> > "%SCRIPT_DIR%CSXS\manifest.xml"
echo ^<ExtensionManifest Version="7.0" ExtensionBundleId="com.quickconsole.ae" ExtensionBundleVersion="1.0.0" ExtensionBundleName="AE Quick Console" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo   ^<ExtensionList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo     ^<Extension Id="com.quickconsole.ae.panel" Version="1.0.0"/^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo   ^</ExtensionList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo   ^<ExecutionEnvironment^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo     ^<HostList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo       ^<Host Name="AEFT" Version="[13.0,99.9]"/^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo     ^</HostList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo     ^<LocaleList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo       ^<Locale Code="All"/^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo     ^</LocaleList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo     ^<RequiredRuntimeList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo       ^<RequiredRuntime Name="CSXS" Version="9.0"/^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo     ^</RequiredRuntimeList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo   ^</ExecutionEnvironment^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo   ^<DispatchInfoList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo     ^<Extension Id="com.quickconsole.ae.panel"^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo       ^<DispatchInfo^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^<Resources^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<MainPath^>./simple_test.html^</MainPath^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<ScriptPath^>./jsx/working_hostscript.jsx^</ScriptPath^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^</Resources^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^<Lifecycle^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<AutoVisible^>true^</AutoVisible^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^</Lifecycle^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^<UI^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<Type^>Panel^</Type^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<Menu^>AE Quick Console^</Menu^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^</UI^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo       ^</DispatchInfo^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo     ^</Extension^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo   ^</DispatchInfoList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo ^</ExtensionManifest^> >> "%SCRIPT_DIR%CSXS\manifest.xml"

echo Updating plugin installations...
echo.

REM Update system installation
if exist "%SYSTEM_CEP_DIR%\%PLUGIN_NAME%" (
    echo Updating system installation...
    xcopy "%SCRIPT_DIR%*" "%SYSTEM_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q
    if %errorLevel% == 0 (
        echo [OK] System installation updated
    ) else (
        echo [ERROR] System installation update failed
    )
)

REM Update user installation
if exist "%USER_CEP_DIR%\%PLUGIN_NAME%" (
    echo Updating user installation...
    xcopy "%SCRIPT_DIR%*" "%USER_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q
    if %errorLevel% == 0 (
        echo [OK] User installation updated
    ) else (
        echo [ERROR] User installation update failed
    )
)

echo.
echo ========================================
echo Test Version Installation Complete!
echo ========================================
echo.

echo The plugin now uses a simplified test version.
echo.
echo Next steps:
echo 1. Restart After Effects completely
echo 2. Open the plugin (Window ^> Extensions ^> AE Quick Console)
echo 3. Test the buttons - they should work without syntax errors
echo.
echo If this works, we can restore the full version.
echo.

echo Press any key to exit...
pause >nul

