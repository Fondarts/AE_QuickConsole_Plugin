@echo off
echo ===============================================
echo   Command Console V66 - Spotlight UI
echo ===============================================
echo.
echo Installing V66 with Spotlight-style minimal interface...
echo.

REM Copy the updated files
echo Copying updated files...
copy "command_console_simple.html" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin\command_console_simple.html" /Y
copy "jsx\command_processor.jsx" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin\jsx\command_processor.jsx" /Y

echo.
echo ===============================================
echo   V66 CHANGELOG - Spotlight UI
echo ===============================================
echo.
echo NEW FEATURES:
echo - Complete UI redesign inspired by macOS Spotlight
echo - Minimal, floating interface without window borders
echo - Centered search bar with modern styling
echo - Backdrop blur effects and glassmorphism design
echo - Dynamic results container that appears on search
echo - Improved typography with system fonts
echo - Better visual hierarchy and spacing
echo - Modern scrollbar styling
echo - Enhanced hover and selection states
echo.
echo UI IMPROVEMENTS:
echo - Removed traditional window chrome
echo - Added floating search bar with rounded corners
echo - Implemented backdrop-filter blur effects
echo - Added subtle shadows and borders
echo - Improved color scheme with transparency
echo - Better responsive design
echo - Enhanced accessibility
echo.
echo TECHNICAL CHANGES:
echo - Updated HTML structure for Spotlight layout
echo - Complete CSS rewrite with modern properties
echo - Improved JavaScript for dynamic results display
echo - Better event handling and state management
echo - Enhanced visual feedback
echo.
echo ===============================================
echo   Installation Complete!
echo ===============================================
echo.
echo Please restart After Effects to use V66
echo.
echo Test the new Spotlight interface:
echo - Notice the minimal, floating design
echo - Try the centered search bar
echo - See the dynamic results container
echo - Experience the modern glassmorphism effects
echo - Test all existing commands and effects
echo.
pause
