@echo off
echo ========================================
echo Test Different JSX Versions
echo ========================================
echo.

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "PLUGIN_NAME=AE_QuickConsole_Plugin"

echo Testing different JSX versions to find the syntax error...
echo.

REM Define user CEP extensions directory
set "USER_CEP_DIR=%APPDATA%\Adobe\CEP\extensions"

echo Test 1: JSX without #target
echo Creating manifest for test_no_target.jsx...

echo ^<?xml version="1.0" encoding="UTF-8"?^> > "%SCRIPT_DIR%CSXS\manifest.xml"
echo ^<ExtensionManifest Version="7.0" ExtensionBundleId="com.quickconsole.ae" ExtensionBundleVersion="1.0.0" ExtensionBundleName="Test No Target" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
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
echo           ^<Menu^>Test No Target^</Menu^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^</UI^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo       ^</DispatchInfo^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo     ^</Extension^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo   ^</DispatchInfoList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo ^</ExtensionManifest^> >> "%SCRIPT_DIR%CSXS\manifest.xml"

echo Copying files...
xcopy "%SCRIPT_DIR%*" "%USER_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q

echo.
echo ========================================
echo Test 1 Complete: No Target JSX
echo ========================================
echo.
echo 1. Restart After Effects
echo 2. Go to Window ^> Extensions ^> Test No Target
echo 3. Test the button
echo 4. If it works, the problem is with #target aftereffects
echo 5. If it fails, the problem is elsewhere
echo.

echo Press any key to continue to Test 2...
pause >nul

echo.
echo Test 2: JSX with simple #target
echo Creating manifest for test_simple_target.jsx...

echo ^<?xml version="1.0" encoding="UTF-8"?^> > "%SCRIPT_DIR%CSXS\manifest.xml"
echo ^<ExtensionManifest Version="7.0" ExtensionBundleId="com.quickconsole.ae" ExtensionBundleVersion="1.0.0" ExtensionBundleName="Test Simple Target" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
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
echo           ^<ScriptPath^>./jsx/test_simple_target.jsx^</ScriptPath^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^</Resources^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^<Lifecycle^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<AutoVisible^>true^</AutoVisible^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^</Lifecycle^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^<UI^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<Type^>Panel^</Type^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo           ^<Menu^>Test Simple Target^</Menu^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo         ^</UI^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo       ^</DispatchInfo^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo     ^</Extension^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo   ^</DispatchInfoList^> >> "%SCRIPT_DIR%CSXS\manifest.xml"
echo ^</ExtensionManifest^> >> "%SCRIPT_DIR%CSXS\manifest.xml"

echo Copying files...
xcopy "%SCRIPT_DIR%*" "%USER_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q

echo.
echo ========================================
echo Test 2 Complete: Simple Target JSX
echo ========================================
echo.
echo 1. Restart After Effects
echo 2. Go to Window ^> Extensions ^> Test Simple Target
echo 3. Test the button
echo 4. This will help us identify the exact problem
echo.

echo Press any key to exit...
pause >nul

