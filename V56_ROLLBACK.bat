@echo off
echo ========================================
echo   AE QuickConsole Plugin V56
echo   ROLLBACK FROM V57
echo ========================================
echo.

echo [1/4] Removing V57 version...
if exist "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo ✓ V57 version removed
) else (
    echo ✓ No previous version found
)

echo.
echo [2/4] Copying V56 rollback files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V56 files copied successfully
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
echo [4/4] Rollback complete!
echo.
echo ========================================
echo   V56 ROLLBACK - RESTORED SIMPLE UI
echo ========================================
echo.
echo ROLLBACK COMPLETED:
echo.
echo 1. RESTORED SIMPLE UI:
echo   • Reverted to V56 simple interface
echo   • Clean, functional design
echo   • No complex navigation tabs
echo   • Simple search and command interface
echo   • Original working layout
echo.
echo 2. SIMPLE INTERFACE FEATURES:
echo   • Single search bar for effects and commands
echo   • Separate command input section
echo   • Simple effects list display
echo   • Status bar for feedback
echo   • Export button for effects list
echo.
echo 3. FUNCTIONALITY RESTORED:
echo   • All V56 commands working
echo   • Effect scanning and application
echo   • Layer manipulation commands
echo   • Blending mode commands
echo   • Two-step command system
echo   • Enter key shortcuts
echo.
echo COMMANDS AVAILABLE:
echo.
echo DIRECT COMMANDS (one step):
echo   • select all         → Selects all layers
echo   • deselect all       → Deselects all layers
echo   • unparent           → Removes parent from selected layers
echo   • untrack matte      → Removes track matte from selected layers
echo   • label red          → Sets red label on selected layers
echo   • label blue         → Sets blue label on selected layers
echo   • (all 16 label colors work directly)
echo   • precompose         → Precomposes selected layers
echo   • duplicate          → Duplicates selected layers
echo   • center anchor      → Centers anchor point WITHOUT moving layer
echo   • fit to comp        → Fits AND centers selected layers to composition
echo   • reset transform    → Resets transform properties
echo   • delete             → Deletes selected layers
echo   • normal             → Sets Normal blending mode
echo   • multiply           → Sets Multiply blending mode
echo   • screen             → Sets Screen blending mode
echo   • overlay            → Sets Overlay blending mode
echo   • soft light         → Sets Soft Light blending mode
echo   • hard light         → Sets Hard Light blending mode
echo   • add                → Sets Add blending mode
echo   • difference         → Sets Difference blending mode
echo.
echo TWO-STEP COMMANDS (command + Enter, then value + Enter):
echo   • parent to          → Enter → layer number → Enter
echo   • track matte        → Enter → layer number → Enter
echo   • scale              → Enter → percentage → Enter
echo   • opacity            → Enter → value (0-100) → Enter
echo.
echo LAYER CREATION COMMANDS:
echo   • solid red          → Creates red solid layer
echo   • solid blue         → Creates blue solid layer
echo   • text               → Creates text layer
echo   • light              → Creates light layer
echo   • camera             → Creates camera layer
echo   • null               → Creates null layer
echo   • adjustment layer   → Creates adjustment layer
echo.
echo USAGE EXAMPLES:
echo.
echo 1. SEARCH AND APPLY EFFECTS:
echo   • Type effect name in search bar
echo   • Click on effect to apply it
echo   • Use Enter key to apply first visible effect
echo.
echo 2. USE COMMANDS:
echo   • Type "multiply" in search bar → Enter
echo   • Type "select all" in search bar → Enter
echo   • Type "solid red" in search bar → Enter
echo.
echo 3. TWO-STEP COMMANDS:
echo   • Type "parent to" → Enter → type "5" → Enter
echo   • Type "scale" → Enter → type "50" → Enter
echo   • Type "opacity" → Enter → type "75" → Enter
echo.
echo 4. COMMAND INPUT SECTION:
echo   • Use separate command input for direct commands
echo   • Type command and click Execute button
echo   • Or press Enter in command input field
echo.
echo EXPECTED RESULTS:
echo   • Simple, clean interface restored
echo   • All V56 functionality working
echo   • No complex UI elements
echo   • Fast and responsive
echo   • Easy to use and understand
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V56
echo ========================================
echo.
pause
