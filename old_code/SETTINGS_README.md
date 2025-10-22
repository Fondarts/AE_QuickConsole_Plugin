# Command Console with Settings - User Guide

## Overview
The Command Console with Settings is an enhanced version of the After Effects plugin that includes a comprehensive settings panel for customizing the plugin behavior and managing keyboard shortcuts.

## New Features

### ⚙️ Settings Panel
- **Access**: Click the gear (⚙️) button in the top-right corner of the plugin
- **Persistent Storage**: All settings are saved locally and persist between After Effects sessions
- **Real-time Updates**: Changes take effect immediately

### ⌨️ Keyboard Shortcut Management
- **Custom Shortcuts**: Set your own keyboard shortcut to open the console
- **Conflict Detection**: Automatically checks if your shortcut conflicts with After Effects built-in shortcuts
- **Visual Feedback**: 
  - ✅ Green: Shortcut is available
  - ⚠️ Red: Potential conflict with After Effects
  - 🔵 Blue: Currently recording shortcut

### 🎛️ Configuration Options

#### Keyboard Shortcut
- Click in the shortcut field and press your desired key combination
- The plugin will automatically detect and display the shortcut
- Conflict checking happens in real-time

#### Auto-focus Input
- **Enabled**: Input field automatically gets focus when console opens
- **Disabled**: Manual click required to start typing
- **Default**: Enabled

#### Show Suggestions
- **Enabled**: Command suggestions appear as you type
- **Disabled**: No suggestions shown
- **Default**: Enabled

## Installation

1. Run `install_with_settings.bat` as administrator
2. Restart After Effects completely
3. Go to `Window > Extensions > Command Console with Settings`
4. Click the settings button (⚙️) to configure

## Usage

### Basic Commands
- **Layer Operations**: `mute`, `unmute`, `solo`, `unsolo`, `duplicate`, `delete`, `hide`, `show`
- **Transform**: `reset`
- **Create Elements**: `null`, `adjustment`, `shape`, `camera`, `light`
- **Effects**: Any effect name (e.g., `Gaussian Blur`, `Glow`, `Lumetri Color`)

### Settings Workflow
1. Open the plugin
2. Click the settings button (⚙️)
3. Set your preferred keyboard shortcut
4. Configure auto-focus and suggestions
5. Click "Save Settings"
6. Use your custom shortcut to open the console

## Shortcut Conflict Detection

The plugin includes a comprehensive database of After Effects shortcuts to prevent conflicts:

### Common AE Shortcuts Checked
- **File Operations**: `Ctrl+N`, `Ctrl+O`, `Ctrl+S`, `Ctrl+Z`, `Ctrl+Y`
- **Edit Operations**: `Ctrl+X`, `Ctrl+C`, `Ctrl+V`, `Ctrl+A`, `Ctrl+D`
- **Layer Operations**: `Ctrl+Shift+D`, `Ctrl+Alt+D`, `Ctrl+Shift+A`
- **Function Keys**: `F1` through `F12`
- **Special Keys**: `Space`, `Enter`, `Escape`, `Tab`, `Delete`, `Backspace`
- **Extended Combinations**: `Ctrl+Shift+*`, `Ctrl+Alt+*` combinations

### Conflict Resolution
- **Red Warning**: The shortcut conflicts with After Effects
- **Green Check**: The shortcut is available
- **Recommendation**: Choose a different combination if conflicts are detected

## Technical Details

### File Structure
```
AE_QuickConsole_Plugin/
├── command_console_with_settings.html    # Main UI with settings
├── jsx/command_processor_with_settings.jsx  # Enhanced JSX engine
├── CSXS/manifest.xml                     # Updated manifest
├── install_with_settings.bat             # Installation script
└── SETTINGS_README.md                    # This documentation
```

### Settings Storage
- Settings are stored in browser localStorage
- Key: `commandConsoleSettings`
- Format: JSON object with shortcut, autoFocus, and showSuggestions properties

### Browser Compatibility
- Uses modern JavaScript features
- Compatible with CEP's embedded browser
- Local storage for persistent settings

## Troubleshooting

### Plugin Not Appearing
1. Restart After Effects completely
2. Check `Window > Extensions` menu
3. Run installer as administrator
4. Verify registry entries are set

### Settings Not Saving
1. Check browser console for errors
2. Verify localStorage is available
3. Try refreshing the plugin panel

### Shortcut Not Working
1. Check for conflicts in settings panel
2. Verify shortcut is properly set
3. Test with different key combinations
4. Restart After Effects after setting shortcut

### Commands Not Executing
1. Ensure layers are selected
2. Check for composition errors
3. Verify JSX script is loaded
4. Check After Effects console for errors

## Advanced Configuration

### Custom Shortcuts
- Use `Ctrl+Shift+*` combinations for best compatibility
- Avoid single keys or common combinations
- Test shortcuts in After Effects before setting

### Performance Tips
- Disable suggestions if not needed
- Use auto-focus for faster workflow
- Keep shortcut combinations simple

## Support

For issues or feature requests:
1. Check this documentation first
2. Verify installation steps
3. Test with default settings
4. Report specific error messages

## Version History

### v1.1.0 (Current)
- Added settings panel with gear button
- Implemented keyboard shortcut management
- Added conflict detection with After Effects shortcuts
- Persistent settings storage
- Auto-focus and suggestions toggles
- Enhanced UI with modal settings

### v1.0.0
- Basic command console functionality
- Layer operations and effects
- Simple HTML interface

