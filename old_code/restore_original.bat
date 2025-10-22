@echo off
echo ========================================
echo AE Quick Console Plugin - Restore Original
echo ========================================
echo.

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "PLUGIN_NAME=AE_QuickConsole_Plugin"

echo Restoring original plugin configuration...
echo.

REM Define user CEP extensions directory
set "USER_CEP_DIR=%APPDATA%\Adobe\CEP\extensions"

REM Create original manifest
echo Creating original manifest...
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
echo           ^<MainPath^>./index.html^</MainPath^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<ScriptPath^>./jsx/working_hostscript.jsx^</ScriptPath^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^</Resources^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^<Lifecycle^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<AutoVisible^>true^</AutoVisible^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^</Lifecycle^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^<UI^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<Type^>Panel^</Type^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<Menu^>AE Quick Console^</Menu^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<Geometry^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo             ^<Size^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo               ^<Width^>400^</Width^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo               ^<Height^>500^</Height^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo             ^</Size^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo             ^<MinSize^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo               ^<Width^>300^</Width^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo               ^<Height^>400^</Height^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo             ^</MinSize^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo             ^<MaxSize^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo               ^<Width^>600^</Width^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo               ^<Height^>800^</Height^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo             ^</MaxSize^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^</Geometry^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^</UI^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo       ^</DispatchInfo^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo     ^</Extension^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo   ^</DispatchInfoList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo ^</ExtensionManifest^> >> "%SCRIPT_DIR%CSXS\manifest.xml"

echo Copying updated files to user directory...
xcopy "%SCRIPT_DIR%*" "%USER_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q

if %errorLevel% == 0 (
    echo.
    echo ========================================
    echo Plugin Restored Successfully!
    echo ========================================
    echo.
    echo The plugin has been restored to its original configuration.
    echo.
    echo Next steps:
    echo 1. Restart After Effects completely
    echo 2. Go to Window ^> Extensions ^> AE Quick Console
    echo 3. The plugin should now appear and work correctly
    echo.
) else (
    echo.
    echo ========================================
    echo Restoration failed!
    echo ========================================
    echo.
    echo There was an error copying the files.
    echo Please try again.
    echo.
)

echo Press any key to exit...
pause >nul

