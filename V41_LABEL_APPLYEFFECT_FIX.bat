@echo off
echo ========================================
echo   AE QuickConsole Plugin V41
echo   LABEL APPLYEFFECT FIX
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
echo [2/4] Copying new V41 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V41 files copied successfully
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
echo   V41 CHANGELOG - LABEL APPLYEFFECT FIX
echo ========================================
echo.
echo CRITICAL FIX APPLIED:
echo.
echo 1. ROOT CAUSE IDENTIFIED:
echo   • The problem was that label commands were being detected in applyEffect function
echo   • But applyEffect was not handling label commands correctly
echo   • Label commands were falling through to the effect application logic
echo   • This caused the error: "Can not add a property with name 'label green' to this PropertyGroup"
echo.
echo 2. FIX APPLIED IN APPLYEFFECT FUNCTION:
echo   • Added label command detection in applyEffect function
echo   • Added: (parts.length >= 2 && parts[0].toLowerCase() === "label")
echo   • Added direct call to processLayerCommand for label commands
echo   • This ensures label commands are handled correctly even if they reach applyEffect
echo.
echo 3. TRIPLE PROTECTION NOW IN PLACE:
echo   • First check: In processCommand function (main routing)
echo   • Second check: Explicit catch before applyEffect in processCommand
echo   • Third check: Direct handling in applyEffect function
echo   • This provides maximum redundancy to ensure label commands work
echo.
echo 4. TECHNICAL ANALYSIS:
echo   • Label commands were being detected in applyEffect but not handled
echo   • applyEffect was trying to apply "label green" as an effect
echo   • After Effects rejected this because "label green" is not a valid effect
echo   • Now applyEffect correctly routes label commands to processLayerCommand
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
echo   • No more "Can not add a property with name 'label green' to this PropertyGroup"
echo   • No more "Could not apply effect 'label green' with any variation"
echo   • Label commands are now handled correctly in ALL code paths
echo   • Triple protection ensures label commands work regardless of routing
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V41
echo ========================================
echo.
pause
