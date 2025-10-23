@echo off
echo ========================================
echo   AE QuickConsole Plugin V63
echo   CORRECT INITIAL DISPLAY
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
echo [2/4] Copying new V63 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V63 files copied successfully
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
echo   V63 CHANGELOG - CORRECT INITIAL DISPLAY
echo ========================================
echo.
echo CORRECT INITIAL DISPLAY BEHAVIOR:
echo.
echo 1. EMPTY LIST ON LOAD:
echo   • Effects list is empty when plugin loads
echo   • Clean, minimal interface on startup
echo   • No overwhelming list of effects initially
echo   • Better focus on search functionality
echo   • Professional, clean appearance
echo.
echo 2. SEARCH-DRIVEN DISPLAY:
echo   • Effects only appear when user starts typing
echo   • Real-time filtering as user types
echo   • Progressive disclosure of effects
echo   • Better user experience for searching
echo   • Focused, intentional interaction
echo.
echo 3. IMPROVED USER GUIDANCE:
echo   • Clear message: "Start typing to search effects and commands..."
echo   • Status shows: "Found X effects - Start typing to search"
echo   • Better user guidance and instructions
echo   • Clear indication of how to use the plugin
echo   • Professional user experience
echo.
echo 4. CLEAN INTERFACE:
echo   • Minimal, uncluttered interface on load
echo   • Focus on search bar functionality
echo   • Progressive disclosure of information
echo   • Better visual hierarchy
echo   • Professional plugin appearance
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
echo.
echo CONFIGURATION MENU:
echo   • Click "⚙️ Config" button in header
echo   • Select "📤 Export Effects List" from menu
echo   • Menu closes automatically after selection
echo   • Click outside menu to close
echo.
echo USAGE EXAMPLES:
echo.
echo 1. CLEAN STARTUP:
echo   • Plugin loads with empty effects list
echo   • Clean, minimal interface
echo   • Clear guidance to start typing
echo   • Professional appearance
echo.
echo 2. SEARCH AND DISCOVER:
echo   • Type in search bar to see effects
echo   • Real-time filtering as you type
echo   • Progressive disclosure of effects
echo   • Better search experience
echo.
echo 3. USE COMMANDS:
echo   • Type "multiply" in search bar → Enter
echo   • Type "select all" in search bar → Enter
echo   • Type "solid red" in search bar → Enter
echo   • All commands work with search-driven display
echo.
echo 4. TWO-STEP COMMANDS:
echo   • Type "parent to" in search bar → Enter → type "5" → Enter
echo   • Type "scale" in search bar → Enter → type "50" → Enter
echo   • Type "opacity" in search bar → Enter → type "75" → Enter
echo   • Commands work with search-driven interface
echo.
echo 5. EXPORT EFFECTS:
echo   • Click "⚙️ Config" button in header
echo   • Click "📤 Export Effects List" in dropdown menu
echo   • Saves all effects to text file
echo.
echo EXPECTED RESULTS:
echo   • Empty effects list on plugin load
echo   • Clean, minimal interface
echo   • Effects appear only when typing
echo   • Better search-driven experience
echo   • Professional, uncluttered appearance
echo   • Clear user guidance
echo   • Progressive disclosure of effects
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V63
echo ========================================
echo.
pause
