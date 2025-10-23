@echo off
echo ========================================
echo   AE QuickConsole Plugin V61
echo   TYPOGRAPHY ADJUSTMENT
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
echo [2/4] Copying new V61 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V61 files copied successfully
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
echo   V61 CHANGELOG - TYPOGRAPHY ADJUSTMENT
echo ========================================
echo.
echo TYPOGRAPHY IMPROVEMENT:
echo.
echo 1. SMALLER LIST TYPOGRAPHY:
echo   • Reduced effects list font size from 12px to 11px
echo   • More compact appearance
echo   • Better space utilization
echo   • Still readable and clear
echo   • Professional look maintained
echo.
echo 2. IMPROVED VISUAL DENSITY:
echo   • More effects visible in same space
echo   • Better information density
echo   • Cleaner, more compact list
echo   • Enhanced readability
echo   • Professional typography
echo.
echo 3. MAINTAINED READABILITY:
echo   • Font size still legible
echo   • Good contrast maintained
echo   • Clear text rendering
echo   • Professional appearance
echo   • User-friendly interface
echo.
echo FUNCTIONALITY PRESERVED:
echo.
echo ALL COMMANDS STILL WORKING:
echo.
echo DIRECT COMMANDS (one step):
echo   • select all         → Type in search bar → Enter
echo   • deselect all       → Type in search bar → Enter
echo   • unparent           → Type in search bar → Enter
echo   • untrack matte      → Type in search bar → Enter
echo   • label red          → Type in search bar → Enter
echo   • label blue         → Type in search bar → Enter
echo   • (all 16 label colors work directly)
echo   • precompose         → Type in search bar → Enter
echo   • duplicate          → Type in search bar → Enter
echo   • center anchor      → Type in search bar → Enter
echo   • fit to comp        → Type in search bar → Enter
echo   • reset transform    → Type in search bar → Enter
echo   • delete             → Type in search bar → Enter
echo   • normal             → Type in search bar → Enter
echo   • multiply           → Type in search bar → Enter
echo   • screen             → Type in search bar → Enter
echo   • overlay            → Type in search bar → Enter
echo   • soft light         → Type in search bar → Enter
echo   • hard light         → Type in search bar → Enter
echo   • add                → Type in search bar → Enter
echo   • difference         → Type in search bar → Enter
echo.
echo TWO-STEP COMMANDS (command + Enter, then value + Enter):
echo   • parent to          → Type in search bar → Enter → type number → Enter
echo   • track matte        → Type in search bar → Enter → type number → Enter
echo   • scale              → Type in search bar → Enter → type percentage → Enter
echo   • opacity            → Type in search bar → Enter → type value (0-100) → Enter
echo.
echo LAYER CREATION COMMANDS:
echo   • solid red          → Type in search bar → Enter
echo   • solid blue         → Type in search bar → Enter
echo   • text               → Type in search bar → Enter
echo   • light              → Type in search bar → Enter
echo   • camera             → Type in search bar → Enter
echo   • null               → Type in search bar → Enter
echo   • adjustment layer   → Type in search bar → Enter
echo.
echo EFFECTS:
echo   • Search for any effect name
echo   • Click on effect to apply it
echo   • Use Enter key to apply first visible effect
echo   • All effects still work perfectly
echo   • Smaller, more compact list display
echo.
echo CONFIGURATION MENU:
echo   • Click "⚙️ Config" button in header
echo   • Select "📤 Export Effects List" from menu
echo   • Menu closes automatically after selection
echo   • Click outside menu to close
echo.
echo USAGE EXAMPLES:
echo.
echo 1. SEARCH AND APPLY EFFECTS:
echo   • Type effect name in search bar
echo   • Click on effect to apply it
echo   • Use Enter key to apply first visible effect
echo   • More compact list with smaller typography
echo.
echo 2. USE COMMANDS:
echo   • Type "multiply" in search bar → Enter
echo   • Type "select all" in search bar → Enter
echo   • Type "solid red" in search bar → Enter
echo   • Smaller but still readable text
echo.
echo 3. TWO-STEP COMMANDS:
echo   • Type "parent to" in search bar → Enter → type "5" → Enter
echo   • Type "scale" in search bar → Enter → type "50" → Enter
echo   • Type "opacity" in search bar → Enter → type "75" → Enter
echo   • Compact interface with smaller fonts
echo.
echo 4. EXPORT EFFECTS:
echo   • Click "⚙️ Config" button in header
echo   • Click "📤 Export Effects List" in dropdown menu
echo   • Saves all effects to text file
echo.
echo EXPECTED RESULTS:
echo   • Smaller typography in effects list (11px)
echo   • More compact and professional appearance
echo   • Better space utilization
echo   • Still readable and clear
echo   • All functionality preserved
echo   • Enhanced visual density
echo   • Professional typography
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V61
echo ========================================
echo.
pause
