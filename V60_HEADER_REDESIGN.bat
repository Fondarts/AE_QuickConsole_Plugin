@echo off
echo ========================================
echo   AE QuickConsole Plugin V60
echo   HEADER REDESIGN
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
echo [2/4] Copying new V60 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V60 files copied successfully
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
echo   V60 CHANGELOG - HEADER REDESIGN
echo ========================================
echo.
echo HEADER REDESIGN:
echo.
echo 1. REMOVED MAIN TITLE:
echo   • Removed "Simple Effect Scanner" title from main content
echo   • Cleaner main content area
echo   • More space for effects list
echo   • Simplified interface
echo.
echo 2. NEW HEADER BAR:
echo   • Added professional header bar at top
echo   • Dark grey background (#3a3a3a)
echo   • Clean border separation
echo   • Professional appearance
echo.
echo 3. COMMAND CONSOLE TITLE:
echo   • "Command Console" title in header
echo   • White text, professional font
echo   • Left-aligned in header
echo   • Clean typography
echo.
echo 4. VERSION BADGE:
echo   • Version number moved to header
echo   • Green badge design (#4CAF50)
echo   • Black text on green background
echo   • Compact and professional
echo   • Shows "V60" next to title
echo.
echo 5. CONFIGURATION BUTTON:
echo   • Added "⚙️ Config" button in header
echo   • Right-aligned in header
echo   • Dark grey background (#555)
echo   • Hover effects
echo   • Professional styling
echo.
echo 6. CONFIGURATION MENU:
echo   • Dropdown menu from config button
echo   • Dark theme matching interface
echo   • Rounded corners and borders
echo   • Smooth animations
echo   • Click outside to close
echo.
echo 7. EXPORT EFFECTS IN MENU:
echo   • Moved "Export Effects List" to config menu
echo   • "📤 Export Effects List" menu item
echo   • Removed from bottom of interface
echo   • More organized layout
echo   • Cleaner main content
echo.
echo 8. IMPROVED LAYOUT:
echo   • More space for effects list
echo   • Professional header design
echo   • Better organization of functions
echo   • Cleaner main content area
echo   • Modern interface design
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
echo.
echo NEW CONFIGURATION MENU:
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
echo.
echo 2. USE COMMANDS:
echo   • Type "multiply" in search bar → Enter
echo   • Type "select all" in search bar → Enter
echo   • Type "solid red" in search bar → Enter
echo.
echo 3. TWO-STEP COMMANDS:
echo   • Type "parent to" in search bar → Enter → type "5" → Enter
echo   • Type "scale" in search bar → Enter → type "50" → Enter
echo   • Type "opacity" in search bar → Enter → type "75" → Enter
echo.
echo 4. EXPORT EFFECTS (NEW LOCATION):
echo   • Click "⚙️ Config" button in header
echo   • Click "📤 Export Effects List" in dropdown menu
echo   • Saves all effects to text file
echo.
echo EXPECTED RESULTS:
echo   • Professional header with Command Console title
echo   • Version badge (V60) in header
echo   • Configuration button with dropdown menu
echo   • Export Effects List moved to config menu
echo   • More space for effects list
echo   • Cleaner, more organized interface
echo   • All functionality preserved
echo   • Modern, professional appearance
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V60
echo ========================================
echo.
pause
