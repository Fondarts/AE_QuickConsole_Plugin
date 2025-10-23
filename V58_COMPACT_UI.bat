@echo off
echo ========================================
echo   AE QuickConsole Plugin V58
echo   COMPACT UI
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
echo [2/4] Copying new V58 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V58 files copied successfully
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
echo   V58 CHANGELOG - COMPACT UI
echo ========================================
echo.
echo COMPACT UI IMPROVEMENTS:
echo.
echo 1. REDUCED VISIBLE ENTRIES:
echo   • Effects list now shows only 10 entries (was 12)
echo   • Reduced max-height from 400px to 280px
echo   • More compact list display
echo   • Better space utilization
echo.
echo 2. SMALLER TYPOGRAPHY:
echo   • Effect items: 12px font size (was default)
echo   • Search input: 12px font size (was 14px)
echo   • Command input: 11px font size (was 12px)
echo   • Execute button: 11px font size (was 12px)
echo   • Export button: 12px font size (was 14px)
echo   • Status bar: 12px font size (was default)
echo   • Title: 20px font size (was default)
echo.
echo 3. REDUCED PADDING AND MARGINS:
echo   • Effects list padding: 10px (was 15px)
echo   • Effect items padding: 6px 10px (was 8px 12px)
echo   • Search input padding: 10px (was 12px)
echo   • Command input padding: 6px 10px (was 8px 12px)
echo   • Execute button padding: 6px 12px (was 8px 16px)
echo   • Export button padding: 10px 20px (was 12px 24px)
echo   • Status bar padding: 8px (was 10px)
echo.
echo 4. OPTIMIZED SPACING:
echo   • Search section margin: 8px (was 10px)
echo   • Command section margin: 10px (was 15px)
echo   • Command section gap: 8px (was 10px)
echo   • Status margin: 8px (was 10px)
echo   • Export section margin: 10px (was 15px)
echo   • Title margin-bottom: 15px (was default)
echo.
echo 5. VISUAL IMPROVEMENTS:
echo   • More compact overall appearance
echo   • Better space efficiency
echo   • Maintained readability with smaller fonts
echo   • Consistent spacing throughout
echo   • Professional compact design
echo.
echo FUNCTIONALITY PRESERVED:
echo.
echo ALL COMMANDS STILL WORKING:
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
echo   • Now shows only 10 entries at once (more compact)
echo.
echo 2. USE COMMANDS:
echo   • Type "multiply" in search bar → Enter
echo   • Type "select all" in search bar → Enter
echo   • Type "solid red" in search bar → Enter
echo   • Smaller fonts but still readable
echo.
echo 3. TWO-STEP COMMANDS:
echo   • Type "parent to" → Enter → type "5" → Enter
echo   • Type "scale" → Enter → type "50" → Enter
echo   • Type "opacity" → Enter → type "75" → Enter
echo   • Compact input fields
echo.
echo 4. COMMAND INPUT SECTION:
echo   • Use separate command input for direct commands
echo   • Type command and click Execute button
echo   • Or press Enter in command input field
echo   • Smaller but functional buttons
echo.
echo EXPECTED RESULTS:
echo   • More compact interface
echo   • Only 10 effects visible at once
echo   • Smaller but readable typography
echo   • Better space utilization
echo   • All functionality preserved
echo   • Professional compact appearance
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V58
echo ========================================
echo.
pause
