@echo off
echo ========================================
echo   AE QuickConsole Plugin V34
echo   PARENT COMMAND FIX
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
echo [2/4] Copying new V34 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V34 files copied successfully
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
echo   V34 CHANGELOG - PARENT COMMAND FIX
echo ========================================
echo.
echo FIXED CRITICAL BUG:
echo   • "parent to" command now properly recognized in processLayerCommand
echo   • Fixed action detection from "parent" to "parent to"
echo   • Commands now execute successfully without "Unknown command" error
echo.
echo PROBLEM SOLVED:
echo   Before: Type "parent to" → Enter → Type "4" → Enter → "Unknown command 'parent to'"
echo   After:  Type "parent to" → Enter → Type "4" → Enter → "Success: Parented X layers to layer 4"
echo.
echo TECHNICAL FIX:
echo   • Changed: action === "parent" 
echo   • To:      action === "parent to"
echo   • This ensures proper command recognition for two-word commands
echo.
echo COMMANDS THAT NOW WORK PERFECTLY:
echo   • parent to 4        → Emparenta capas seleccionadas a capa 4
echo   • track matte 3      → Establece track matte alpha con capa 3
echo   • select 1,5,7       → Selecciona capas 1, 5, 7
echo   • solo 2,4           → Solo capas 2, 4
echo   • motion blur 1,3    → Motion blur en capas 1, 3
echo   • 3d layer 2,5       → 3D en capas 2, 5
echo.
echo COMPLETE WORKFLOW NOW WORKING:
echo   1. Type "parent to" and press Enter
echo   2. Input field clears, shows "Enter parent layer number"
echo   3. Type "4" (no effects search interruption)
echo   4. Press Enter → Executes "parent to 4" successfully
echo   5. Shows "Success: Parented X layers to layer 4"
echo   6. Effects list restored automatically
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V34
echo ========================================
echo.
pause
