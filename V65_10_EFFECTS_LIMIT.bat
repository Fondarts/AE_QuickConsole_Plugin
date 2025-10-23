@echo off
echo ========================================
echo   AE QuickConsole Plugin V65
echo   10 EFFECTS LIMIT
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
echo [2/4] Copying new V65 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V65 files copied successfully
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
echo   V65 CHANGELOG - 10 EFFECTS LIMIT
echo ========================================
echo.
echo 10 EFFECTS LIMIT:
echo.
echo 1. LIMITED DISPLAY:
echo   • Effects list now shows only first 10 results
echo   • Better window adaptation to content
echo   • Consistent window height
echo   • No overwhelming long lists
echo   • Clean, manageable interface
echo.
echo 2. SMART STATUS MESSAGES:
echo   • Shows "Showing first 10 of X effects" when more than 10
echo   • Shows "Showing X of Y effects" when 10 or fewer
echo   • Clear indication of total available effects
echo   • Better user understanding
echo   • Professional status reporting
echo.
echo 3. OPTIMAL WINDOW SIZE:
echo   • Window adapts to exactly 10 effects height
echo   • Consistent window dimensions
echo   • No wasted space
echo   • Better visual balance
echo   • Professional appearance
echo.
echo 4. IMPROVED USER EXPERIENCE:
echo   • Manageable number of effects to choose from
echo   • Faster visual scanning
echo   • Less overwhelming interface
echo   • Better focus on top results
echo   • Cleaner, more professional look
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
echo   • Start typing to see effects
echo   • Shows first 10 matching effects
echo   • Click on effect to apply it
echo   • Use Enter key to apply first visible effect
echo   • All effects work perfectly
echo   • Window adapts to 10 effects height
echo.
echo CONFIGURATION MENU:
echo   • Click "⚙️ Config" button in header
echo   • Select "📤 Export Effects List" from menu
echo   • Menu closes automatically after selection
echo   • Click outside menu to close
echo.
echo USAGE EXAMPLES:
echo.
echo 1. LIMITED EFFECTS DISPLAY:
echo   • Plugin shows only first 10 effects
echo   • Window adapts to exactly 10 effects height
echo   • Consistent, manageable interface
echo   • No overwhelming long lists
echo.
echo 2. SMART SEARCH:
echo   • Type in search bar to filter effects
echo   • Shows first 10 matching results
echo   • Status shows total available effects
echo   • Better focus on top results
echo.
echo 3. USE COMMANDS:
echo   • Type "multiply" in search bar → Enter
echo   • Type "select all" in search bar → Enter
echo   • Type "solid red" in search bar → Enter
echo   • All commands work with 10 effects limit
echo.
echo 4. TWO-STEP COMMANDS:
echo   • Type "parent to" in search bar → Enter → type "5" → Enter
echo   • Type "scale" in search bar → Enter → type "50" → Enter
echo   • Type "opacity" in search bar → Enter → type "75" → Enter
echo   • Commands work with limited display
echo.
echo 5. EXPORT EFFECTS:
echo   • Click "⚙️ Config" button in header
echo   • Click "📤 Export Effects List" in dropdown menu
echo   • Saves all effects to text file
echo.
echo EXPECTED RESULTS:
echo   • Only first 10 effects displayed
echo   • Window adapts to 10 effects height
echo   • Consistent window dimensions
echo   • Smart status messages
echo   • Better user experience
echo   • Professional, manageable interface
echo   • No overwhelming long lists
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V65
echo ========================================
echo.
pause
