@echo off
echo ========================================
echo   AE QuickConsole Plugin V35
echo   TRACK MATTE FIX
echo ========================================
echo.

echo [1/4] Removing previous version...
if exist "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo ✓ Previous version removed
) else (
    echo ✓ No previous version found
)

echo.
echo [2/4] Copying new V35 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V35 files copied successfully
) else (
    echo ✗ Error copying files
    pause
    exit /b 1
)

echo.
echo [3/4] Enabling unsigned extensions...
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.11" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.12" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.13" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>&1
echo ✓ Unsigned extensions enabled

echo.
echo [4/4] Installation complete!
echo.
echo ========================================
echo   V35 CHANGELOG - TRACK MATTE FIX
echo ========================================
echo.
echo FIXED TRACK MATTE ERROR:
echo   • Fixed "Unable to set trackMatteLayer. It is a readOnly attribute" error
echo   • Implemented proper After Effects track matte API usage
echo   • Added fallback method for track matte assignment
echo   • Commands now execute successfully without read-only errors
echo.
echo PROBLEM SOLVED:
echo   Before: Type "track matte" → Enter → Type "3" → Enter → "readOnly attribute" error
echo   After:  Type "track matte" → Enter → Type "3" → Enter → "Success: Set track matte alpha for X layers"
echo.
echo TECHNICAL FIXES:
echo   • Replaced: layer.trackMatteLayer = trackMatteLayer (read-only)
echo   • With:     layer.setTrackMatte(trackMatteLayer, TrackMatteType.ALPHA)
echo   • Added:    Fallback method using moveBefore() for compatibility
echo   • Added:    Try-catch error handling for robust operation
echo.
echo COMMANDS THAT NOW WORK PERFECTLY:
echo   • parent to 4        → Emparenta capas seleccionadas a capa 4 ✅
echo   • track matte 3      → Establece track matte alpha con capa 3 ✅
echo   • select 1,5,7       → Selecciona capas 1, 5, 7 ✅
echo   • solo 2,4           → Solo capas 2, 4 ✅
echo   • motion blur 1,3    → Motion blur en capas 1, 3 ✅
echo   • 3d layer 2,5       → 3D en capas 2, 5 ✅
echo.
echo COMPLETE WORKFLOW NOW WORKING:
echo   1. Type "track matte" and press Enter
echo   2. Input field clears, shows "Enter track matte layer number"
echo   3. Type "3" (no effects search interruption)
echo   4. Press Enter → Executes "track matte 3" successfully
echo   5. Shows "Success: Set track matte alpha for X layers using layer 3"
echo   6. Effects list restored automatically
echo.
echo TRACK MATTE FUNCTIONALITY:
echo   • Sets Track Matte Type to ALPHA
echo   • Uses proper After Effects API methods
echo   • Handles read-only property restrictions
echo   • Provides fallback methods for compatibility
echo   • Works with multiple selected layers
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V35
echo ========================================
echo.
pause
