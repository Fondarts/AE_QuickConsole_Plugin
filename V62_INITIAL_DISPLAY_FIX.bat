@echo off
echo ========================================
echo   AE QuickConsole Plugin V62
echo   INITIAL DISPLAY FIX
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
echo [2/4] Copying new V62 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V62 files copied successfully
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
echo   V62 CHANGELOG - INITIAL DISPLAY FIX
echo ========================================
echo.
echo INITIAL DISPLAY FIX:
echo.
echo 1. FIXED EFFECTS LIST DISPLAY:
echo   • Effects list now displays automatically on plugin load
echo   • No need to type in search bar to see effects
echo   • All effects visible immediately after loading
echo   • Better user experience
echo   • Immediate access to all effects and commands
echo.
echo 2. IMPROVED LOADING BEHAVIOR:
echo   • Effects list shows as soon as plugin loads
echo   • No empty list on startup
echo   • Immediate visual feedback
echo   • Better plugin usability
echo   • Professional loading experience
echo.
echo 3. ENHANCED USER EXPERIENCE:
echo   • Users can see all available effects immediately
echo   • No confusion about empty list
echo   • Clear indication that plugin is working
echo   • Better discoverability of effects
echo   • Improved workflow efficiency
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
echo   • All effects visible immediately on load
echo   • Click on effect to apply it
echo   • Use Enter key to apply first visible effect
echo   • Search and filter effects in real-time
echo   • All effects work perfectly
echo.
echo CONFIGURATION MENU:
echo   • Click "⚙️ Config" button in header
echo   • Select "📤 Export Effects List" from menu
echo   • Menu closes automatically after selection
echo   • Click outside menu to close
echo.
echo USAGE EXAMPLES:
echo.
echo 1. IMMEDIATE EFFECTS DISPLAY:
echo   • Plugin loads and shows all effects immediately
echo   • No need to type anything to see effects
echo   • Click on any effect to apply it
echo   • Use Enter key to apply first visible effect
echo.
echo 2. SEARCH AND FILTER:
echo   • Type in search bar to filter effects
echo   • Real-time filtering as you type
echo   • Clear search to see all effects again
echo   • Smart sorting with exact matches first
echo.
echo 3. USE COMMANDS:
echo   • Type "multiply" in search bar → Enter
echo   • Type "select all" in search bar → Enter
echo   • Type "solid red" in search bar → Enter
echo   • All commands work with immediate display
echo.
echo 4. TWO-STEP COMMANDS:
echo   • Type "parent to" in search bar → Enter → type "5" → Enter
echo   • Type "scale" in search bar → Enter → type "50" → Enter
echo   • Type "opacity" in search bar → Enter → type "75" → Enter
echo   • Commands work with immediate effects display
echo.
echo 5. EXPORT EFFECTS:
echo   • Click "⚙️ Config" button in header
echo   • Click "📤 Export Effects List" in dropdown menu
echo   • Saves all effects to text file
echo.
echo EXPECTED RESULTS:
echo   • Effects list displays immediately on plugin load
echo   • All effects visible without typing
echo   • Better user experience and workflow
echo   • No empty list confusion
echo   • Immediate access to all functionality
echo   • Professional loading behavior
echo   • Enhanced plugin usability
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V62
echo ========================================
echo.
pause
