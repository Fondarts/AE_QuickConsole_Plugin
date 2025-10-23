@echo off
echo ===============================================
echo   Command Console V67 - Borderless Window
echo ===============================================
echo.
echo Installing V67 with borderless window interface...
echo.

REM Copy the updated files
echo Copying updated files...
copy "command_console_simple.html" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin\command_console_simple.html" /Y
copy "CSXS\manifest.xml" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin\CSXS\manifest.xml" /Y

echo.
echo ===============================================
echo   V67 CHANGELOG - Borderless Window
echo ===============================================
echo.
echo NEW FEATURES:
echo - Borderless window interface
echo - Transparent background with no visible borders
echo - Full window coverage with centered content
echo - Improved window geometry settings
echo - Better responsive design for different window sizes
echo.
echo UI IMPROVEMENTS:
echo - Removed all visible window borders and outlines
echo - Made entire window background transparent
echo - Centered spotlight interface within window
echo - Added proper window sizing constraints
echo - Enhanced visual integration with After Effects
echo.
echo TECHNICAL CHANGES:
echo - Updated manifest.xml with better geometry settings
echo - Added CSS to hide window chrome and borders
echo - Implemented full viewport coverage
echo - Added webkit-app-region properties
echo - Enhanced container positioning and sizing
echo.
echo ===============================================
echo   Installation Complete!
echo ===============================================
echo.
echo Please restart After Effects to use V67
echo.
echo Test the borderless interface:
echo - Notice the transparent, borderless window
echo - See the centered spotlight interface
echo - Try resizing the window
echo - Experience the seamless integration
echo - Test all existing commands and effects
echo.
pause
