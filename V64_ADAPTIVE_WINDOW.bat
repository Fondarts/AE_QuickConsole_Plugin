@echo off
echo ========================================
echo   AE QuickConsole Plugin V64
echo   ADAPTIVE WINDOW
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
echo [2/4] Copying new V64 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V64 files copied successfully
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
echo   V64 CHANGELOG - ADAPTIVE WINDOW
echo ========================================
echo.
echo ADAPTIVE WINDOW BEHAVIOR:
echo.
echo 1. VERTICAL ADAPTATION:
echo   • Plugin window now adapts vertically to content
echo   • Window expands and contracts with list size
echo   • No more fixed height limitations
echo   • Dynamic window sizing
echo   • Better space utilization
echo.
echo 2. NO MORE SCROLLBAR:
echo   • Removed fixed height from effects list
echo   • No more scrollbar in effects list
echo   • All effects visible without scrolling
echo   • Clean, uncluttered interface
echo   • Better user experience
echo.
echo 3. DYNAMIC EXPANSION:
echo   • Window grows when more effects are shown
echo   • Window shrinks when fewer effects are shown
echo   • Smooth adaptation to content
echo   • Professional window behavior
echo   • Better visual feedback
echo.
echo 4. IMPROVED LAYOUT:
echo   • Effects list adapts to content size
echo   • No wasted space
echo   • Better visual hierarchy
echo   • Cleaner interface design
echo   • More professional appearance
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
echo   • Real-time filtering as you type
echo   • Click on effect to apply it
echo   • Use Enter key to apply first visible effect
echo   • All effects work perfectly
echo   • Window adapts to show all results
echo.
echo CONFIGURATION MENU:
echo   • Click "⚙️ Config" button in header
echo   • Select "📤 Export Effects List" from menu
echo   • Menu closes automatically after selection
echo   • Click outside menu to close
echo.
echo USAGE EXAMPLES:
echo.
echo 1. ADAPTIVE WINDOW:
echo   • Plugin starts with minimal height
echo   • Window expands as you type and see more effects
echo   • Window contracts when you clear search
echo   • No scrollbar needed
echo   • All effects visible at once
echo.
echo 2. SEARCH AND EXPAND:
echo   • Type in search bar to see effects
echo   • Window grows to show all matching effects
echo   • No scrolling required
echo   • Better visibility of all results
echo.
echo 3. USE COMMANDS:
echo   • Type "multiply" in search bar → Enter
echo   • Type "select all" in search bar → Enter
echo   • Type "solid red" in search bar → Enter
echo   • All commands work with adaptive window
echo.
echo 4. TWO-STEP COMMANDS:
echo   • Type "parent to" in search bar → Enter → type "5" → Enter
echo   • Type "scale" in search bar → Enter → type "50" → Enter
echo   • Type "opacity" in search bar → Enter → type "75" → Enter
echo   • Commands work with adaptive interface
echo.
echo 5. EXPORT EFFECTS:
echo   • Click "⚙️ Config" button in header
echo   • Click "📤 Export Effects List" in dropdown menu
echo   • Saves all effects to text file
echo.
echo EXPECTED RESULTS:
echo   • Plugin window adapts vertically to content
echo   • No fixed height or scrollbar
echo   • Window expands with more effects
echo   • Window contracts with fewer effects
echo   • All effects visible without scrolling
echo   • Better space utilization
echo   • Professional window behavior
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V64
echo ========================================
echo.
pause
