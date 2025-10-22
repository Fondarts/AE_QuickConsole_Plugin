@echo off
echo ========================================
echo Install JSX Without Target
echo ========================================
echo.

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "PLUGIN_NAME=AE_QuickConsole_Plugin"

echo Installing JSX without #target aftereffects...
echo.

REM Define user CEP extensions directory
set "USER_CEP_DIR=%APPDATA%\Adobe\CEP\extensions"

echo Creating manifest for no-target JSX...
echo.

REM Create manifest for no-target JSX
echo ^<?xml version="1.0" encoding="UTF-8"?^> > "%SCRIPT_DIR%CSXS\manifest.xml"
echo ^<ExtensionManifest Version="7.0" ExtensionBundleId="com.quickconsole.ae" ExtensionBundleVersion="1.0.0" ExtensionBundleName="No Target Test" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
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
echo           ^<MainPath^>./test_basic.html^</MainPath^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<ScriptPath^>./jsx/test_no_target.jsx^</ScriptPath^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^</Resources^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^<Lifecycle^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<AutoVisible^>true^</AutoVisible^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^</Lifecycle^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^<UI^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<Type^>Panel^</Type^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<Menu^>No Target Test^</Menu^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<Geometry^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo             ^<Size^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo               ^<Width^>400^</Width^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo               ^<Height^>300^</Height^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo             ^</Size^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^</Geometry^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^</UI^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo       ^</DispatchInfo^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo     ^</Extension^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo   ^</DispatchInfoList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo ^</ExtensionManifest^> >> "%SCRIPT_DIR%CSXS\manifest.xml"

echo Copying files to user directory...
xcopy "%SCRIPT_DIR%*" "%USER_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q

if %errorLevel% == 0 (
    echo.
    echo ========================================
    echo No Target Test Installed Successfully!
    echo ========================================
    echo.
    echo The plugin now uses JSX WITHOUT #target aftereffects.
    echo.
    echo Next steps:
    echo 1. Restart After Effects completely
    echo 2. Go to Window ^> Extensions ^> No Target Test
    echo 3. Click "Test Basic Communication" button
    echo.
    echo If this works, we know the problem is with #target aftereffects
    echo and we can create a working version without it.
    echo.
) else (
    echo.
    echo ========================================
    echo Installation failed!
    echo ========================================
    echo.
    echo There was an error copying the files.
    echo Please try again.
    echo.
)

echo Press any key to exit...
pause >nul

