@echo off
echo ========================================
echo   AE QuickConsole Plugin V33
echo   PENDING COMMAND FIX
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
echo [2/4] Copying new V33 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V33 files copied successfully
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
echo   V33 CHANGELOG - PENDING COMMAND FIX
echo ========================================
echo.
echo FIXED CRITICAL ISSUE:
echo   • Commands no longer interrupt when typing parameters
echo   • filterEffects() now ignores input when pendingCommand exists
echo   • Effects list properly restored after command execution
echo.
echo PROBLEM SOLVED:
echo   Before: Type "parent to" → Enter → Type "4" → Shows effects with "4" in name
echo   After:  Type "parent to" → Enter → Type "4" → Executes "parent to 4" command
echo.
echo HOW IT WORKS NOW:
echo   1. Type "parent to" and press Enter
echo   2. Input field clears, shows "Enter parent layer number"
echo   3. Type "4" (no effects search happens)
echo   4. Press Enter → Executes "parent to 4" command
echo   5. Effects list restored automatically
echo.
echo COMMANDS THAT NOW WORK CORRECTLY:
echo   • parent to 4        → Emparenta a capa 4
echo   • track matte 3      → Track matte con capa 3
echo   • select 1,5,7       → Selecciona capas 1, 5, 7
echo   • solo 2,4           → Solo capas 2, 4
echo   • motion blur 1,3    → Motion blur en capas 1, 3
echo   • 3d layer 2,5       → 3D en capas 2, 5
echo.
echo TECHNICAL FIXES:
echo   • Added pendingCommand check in filterEffects()
echo   • Added effects list restoration in executePendingCommand()
echo   • Improved command flow and user experience
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V33
echo ========================================
echo.
pause
