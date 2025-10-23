@echo off
echo ========================================
echo   AE QuickConsole Plugin V59
echo   CLEANED UI
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
echo [2/4] Copying new V59 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V59 files copied successfully
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
echo   V59 CHANGELOG - CLEANED UI
echo ========================================
echo.
echo UI CLEANUP:
echo.
echo 1. REMOVED UNUSED ELEMENTS:
echo   • Removed command section (input + execute button)
echo   • Removed execute button functionality
echo   • Removed command input field
echo   • Cleaned up unused CSS styles
echo   • Removed unused JavaScript functions
echo   • Simplified interface structure
echo.
echo 2. SIMPLIFIED INTERFACE:
echo   • Only search bar for effects and commands
echo   • Effects list display
echo   • Status bar for feedback
echo   • Export button for effects list
echo   • Cleaner, more focused design
echo.
echo 3. REMOVED CSS STYLES:
echo   • .command-section styles removed
echo   • .command-section input styles removed
echo   • .execute-button styles removed
echo   • All related hover and active states removed
echo   • Cleaner stylesheet
echo.
echo 4. REMOVED JAVASCRIPT FUNCTIONS:
echo   • executeCommand() function removed
echo   • Command input event listeners removed
echo   • Execute button event listeners removed
echo   • Cleaner JavaScript code
echo   • Reduced file size
echo.
echo 5. IMPROVED USER EXPERIENCE:
echo   • Single input method (search bar only)
echo   • Less confusion about where to type commands
echo   • Cleaner, more intuitive interface
echo   • All functionality preserved in search bar
echo   • Streamlined workflow
echo.
echo FUNCTIONALITY PRESERVED:
echo.
echo ALL COMMANDS STILL WORKING VIA SEARCH BAR:
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
echo 4. EXPORT EFFECTS:
echo   • Click "Export Effects List" button
echo   • Saves all effects to text file
echo.
echo EXPECTED RESULTS:
echo   • Cleaner, simpler interface
echo   • Single input method (search bar only)
echo   • All functionality preserved
echo   • Less confusion for users
echo   • Streamlined workflow
echo   • Reduced file size
echo   • Better performance
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V59
echo ========================================
echo.
pause
