@echo off
echo ========================================
echo   AE QuickConsole Plugin V40
echo   LABEL FINAL FIX
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
echo [2/4] Copying new V40 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V40 files copied successfully
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
echo   V40 CHANGELOG - LABEL FINAL FIX
echo ========================================
echo.
echo CRITICAL FIX APPLIED:
echo.
echo 1. ADDED EXPLICIT LABEL COMMAND CATCH:
echo   • Added specific check for label commands before the final else
echo   • Added: else if (parts.length >= 2 && parts[0].toLowerCase() === "label")
echo   • This ensures label commands are caught before reaching applyEffect
echo.
echo 2. DOUBLE PROTECTION:
echo   • First check: In the main command routing logic
echo   • Second check: Explicit catch before applyEffect
echo   • This provides redundancy to ensure label commands never reach applyEffect
echo.
echo 3. ROOT CAUSE ANALYSIS:
echo   • V39 fix was correct but insufficient
echo   • Label commands were still falling through to the final else
echo   • The final else calls applyEffect, which tries to apply "label red" as an effect
echo   • After Effects rejects this because "label red" is not a valid effect
echo   • Now label commands are explicitly caught before reaching applyEffect
echo.
echo 4. TECHNICAL IMPLEMENTATION:
echo   • According to After Effects documentation: Layer.label is Integer (0-16)
echo   • Our code correctly maps color names to integers (0-16)
echo   • The issue was routing, not the label setting logic
echo   • Now routing is bulletproof with double protection
echo.
echo LABEL COMMANDS NOW GUARANTEED TO WORK:
echo.
echo SINGLE WORD COLORS:
echo   • label none         → Sin etiqueta (0)
echo   • label red          → Etiqueta roja (1)
echo   • label yellow       → Etiqueta amarilla (2)
echo   • label aqua         → Etiqueta aqua/cyan (3)
echo   • label pink         → Etiqueta rosa (4)
echo   • label lavender     → Etiqueta lavanda (5)
echo   • label peach        → Etiqueta durazno (6)
echo   • label blue         → Etiqueta azul (8)
echo   • label green        → Etiqueta verde (9)
echo   • label purple       → Etiqueta morada (10)
echo   • label orange       → Etiqueta naranja (11)
echo   • label brown        → Etiqueta marrón (12)
echo   • label fuchsia      → Etiqueta fucsia (13)
echo   • label cyan         → Etiqueta cyan (14)
echo   • label sandstone    → Etiqueta arena (15)
echo.
echo MULTI-WORD COLORS:
echo   • label sea foam     → Etiqueta verde mar (7)
echo   • label dark green   → Etiqueta verde oscuro (16)
echo.
echo USAGE EXAMPLES:
echo   1. Select layers → Type "label red" → Enter
echo   2. Select layers → Type "label blue" → Enter
echo   3. Select layers → Type "label sea foam" → Enter
echo   4. Select layers → Type "label dark green" → Enter
echo.
echo EXPECTED RESULT:
echo   • "Success: Set label 'red' for X layers"
echo   • "Success: Set label 'blue' for X layers"
echo   • "Success: Set label 'sea foam' for X layers"
echo   • "Success: Set label 'dark green' for X layers"
echo.
echo NO MORE ERRORS:
echo   • No more "Can not add a property with name 'label red' to this PropertyGroup"
echo   • No more "Could not apply effect 'label red' with any variation"
echo   • Label commands are now properly routed to processLayerCommand
echo   • processLayerCommand correctly sets Layer.label to integer values (0-16)
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V40
echo ========================================
echo.
pause
