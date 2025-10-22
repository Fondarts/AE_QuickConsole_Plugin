// AE Quick Console Plugin - Main JavaScript
(function() {
    'use strict';
    
    let csInterface = new CSInterface();
    let selectedSuggestionIndex = -1;
    let suggestions = [];
    
    // Command suggestions database
    const commandSuggestions = [
        // Layer operations
        "mute", "unmute", "hide", "show", "duplicate", "duplicate with properties",
        "shy", "unshy", "convert to 3d", "unconvert",
        "bring to front", "send to back", "reverse layers",
        
        // Transform operations
        "reset", "center anchor", "center in comp", "fit to comp", 
        "fit to comp width", "fit to comp height", "flip horizontal", "flip vertical",
        
        // Layer properties
        "solo", "unsolo", "toggle quality", "toggle motion blur", 
        "motion blur on", "motion blur off", "toggle frame blending", 
        "toggle adjustment", "toggle guide",
        
        // Render operations
        "add to render queue", "add to media encoder",
        
        // Blending modes
        "blending normal", "blending multiply", "blending screen", "blending overlay",
        "blending soft light", "blending hard light", "blending difference", 
        "blending exclusion", "blending color", "blending hue", "blending saturation",
        "blending luminosity", "blending dissolve", "blending darken", "blending lighten",
        "blending add", "blending subtract", "blending pin light", "blending color dodge",
        "blending color burn", "blending linear dodge", "blending linear burn",
        
        // Effects
        "remove effects", "toggle fx",
        
        // Composition settings
        "enable comp shy", "disable comp shy", "enable comp motion blur", "disable comp motion blur",
        
        // Commands with arguments
        "rename", "go to time", "change duration", "wiggle position",
        "parent to", "track matte to", "select",
        
        // Labels
        "label red", "label blue", "label green", "label purple", "label orange",
        
        // Create elements
        "solid red", "solid green", "solid blue", "solid black", "solid white",
        "solid yellow", "solid cyan", "solid magenta", "solid orange", "solid purple",
        "solid pink", "solid teal", "precomp name=New Comp", "solid 1920x1080 #ff0000 BG",
        "text Hello world", "null", "adjustment", "shape", "camera", "light",
        
        // Common effects
        "Gaussian Blur", "Glow", "Lumetri Color", "Curves", "Levels", "Hue/Saturation",
        "Turbulent Displace", "Noise", "Sharpen", "Drop Shadow", "Fill", "Fast Box Blur",
        "Invert", "Exposure", "Transform"
    ];
    
    // Initialize the plugin
    function init() {
        setupEventListeners();
        updateStatus("Ready - Select layers and enter commands");
    }
    
    // Setup all event listeners
    function setupEventListeners() {
        const commandInput = document.getElementById('command-input');
        const suggestionsList = document.getElementById('suggestions-list');
        
        // Input field events
        commandInput.addEventListener('input', handleInput);
        commandInput.addEventListener('keydown', handleKeyDown);
        commandInput.addEventListener('focus', showSuggestions);
        commandInput.addEventListener('blur', hideSuggestions);
        
        // Suggestion list events
        suggestionsList.addEventListener('click', handleSuggestionClick);
        
        // Button events
        document.querySelectorAll('.action-btn, .create-btn, .blending-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const command = this.getAttribute('data-command');
                executeCommand(command);
            });
        });
        
        // CSInterface events
        csInterface.addEventListener(CSInterface.THEME_COLOR_CHANGED_EVENT, onAppThemeColorChanged);
    }
    
    // Handle input changes
    function handleInput(event) {
        const query = event.target.value.toLowerCase().trim();
        filterSuggestions(query);
    }
    
    // Handle keyboard input
    function handleKeyDown(event) {
        const suggestionsContainer = document.getElementById('suggestions-container');
        const suggestionsList = document.getElementById('suggestions-list');
        
        switch(event.key) {
            case 'Enter':
                event.preventDefault();
                if (selectedSuggestionIndex >= 0 && suggestions[selectedSuggestionIndex]) {
                    executeCommand(suggestions[selectedSuggestionIndex]);
                } else {
                    executeCommand(document.getElementById('command-input').value);
                }
                break;
                
            case 'Escape':
                hideSuggestions();
                document.getElementById('command-input').blur();
                break;
                
            case 'ArrowDown':
                event.preventDefault();
                if (suggestions.length > 0) {
                    selectedSuggestionIndex = Math.min(selectedSuggestionIndex + 1, suggestions.length - 1);
                    updateSuggestionSelection();
                }
                break;
                
            case 'ArrowUp':
                event.preventDefault();
                if (suggestions.length > 0) {
                    selectedSuggestionIndex = Math.max(selectedSuggestionIndex - 1, 0);
                    updateSuggestionSelection();
                }
                break;
        }
    }
    
    // Filter suggestions based on input
    function filterSuggestions(query) {
        suggestions = commandSuggestions.filter(cmd => 
            cmd.toLowerCase().includes(query)
        ).slice(0, 20); // Limit to 20 suggestions
        
        displaySuggestions();
        selectedSuggestionIndex = -1;
    }
    
    // Display filtered suggestions
    function displaySuggestions() {
        const suggestionsList = document.getElementById('suggestions-list');
        const suggestionsContainer = document.getElementById('suggestions-container');
        
        suggestionsList.innerHTML = '';
        
        if (suggestions.length > 0) {
            suggestions.forEach((suggestion, index) => {
                const li = document.createElement('li');
                li.textContent = suggestion;
                li.setAttribute('data-index', index);
                suggestionsList.appendChild(li);
            });
            showSuggestions();
        } else {
            hideSuggestions();
        }
    }
    
    // Update suggestion selection highlighting
    function updateSuggestionSelection() {
        const items = document.querySelectorAll('#suggestions-list li');
        items.forEach((item, index) => {
            item.classList.toggle('selected', index === selectedSuggestionIndex);
        });
    }
    
    // Show suggestions dropdown
    function showSuggestions() {
        const suggestionsContainer = document.getElementById('suggestions-container');
        if (suggestions.length > 0) {
            suggestionsContainer.style.display = 'block';
        }
    }
    
    // Hide suggestions dropdown
    function hideSuggestions() {
        const suggestionsContainer = document.getElementById('suggestions-container');
        suggestionsContainer.style.display = 'none';
        selectedSuggestionIndex = -1;
    }
    
    // Handle suggestion click
    function handleSuggestionClick(event) {
        if (event.target.tagName === 'LI') {
            const index = parseInt(event.target.getAttribute('data-index'));
            executeCommand(suggestions[index]);
        }
    }
    
    // Execute command via JSX
    function executeCommand(command) {
        if (!command || !command.trim()) {
            updateStatus("No command entered");
            return;
        }
        
        updateStatus("Executing: " + command);
        
        // Clear input and hide suggestions
        document.getElementById('command-input').value = '';
        hideSuggestions();
        
        // Execute the command in After Effects
        csInterface.evalScript('executeCommand("' + escapeCommand(command) + '")', function(result) {
            if (result === 'EvalScript error.') {
                updateStatus("Error executing command");
            } else if (result && result.indexOf('QuickConsole:') === 0) {
                updateStatus("Error: " + result);
            } else {
                updateStatus("Command executed: " + (result || "success"));
            }
        });
    }
    
    // Escape command for JSX execution
    function escapeCommand(command) {
        return command.replace(/\\/g, '\\\\')
                     .replace(/"/g, '\\"')
                     .replace(/'/g, "\\'")
                     .replace(/\n/g, '\\n')
                     .replace(/\r/g, '\\r');
    }
    
    // Update status bar
    function updateStatus(message) {
        const statusText = document.getElementById('status-text');
        statusText.textContent = message;
        
        // Clear status after 3 seconds
        setTimeout(() => {
            statusText.textContent = "Ready";
        }, 3000);
    }
    
    // Handle theme color changes
    function onAppThemeColorChanged(event) {
        // Update UI colors based on After Effects theme
        const themeData = JSON.parse(window.__adobe_cep__.getHostEnvironment()).appSkinInfo;
        // You can add theme-specific styling here if needed
    }
    
    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
    
})();
