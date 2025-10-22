// Simple test JSX file
(function() {
    'use strict';
    
    function processCommand(command) {
        try {
            $.writeln("Simple test: Received command: " + command);
            
            if (!command || command === '') {
                return "Error: No command provided";
            }
            
            // Get active composition
            var comp = app.project.activeItem;
            if (!comp || !(comp instanceof CompItem)) {
                return "Error: No active composition";
            }
            
            var commandLower = command.toLowerCase();
            
            // Test simple commands
            if (commandLower === "test") {
                return "Test command executed successfully!";
            }
            
            if (commandLower === "null") {
                app.beginUndoGroup("Create Null");
                var nullLayer = comp.layers.addNull();
                nullLayer.name = "Test Null";
                app.endUndoGroup();
                return "Null layer created successfully!";
            }
            
            if (commandLower === "mute") {
                var selectedLayers = comp.selectedLayers;
                if (selectedLayers.length === 0) {
                    return "Error: No layers selected";
                }
                
                app.beginUndoGroup("Mute Layers");
                for (var i = 0; i < selectedLayers.length; i++) {
                    selectedLayers[i].audioEnabled = false;
                }
                app.endUndoGroup();
                return "Layers muted successfully!";
            }
            
            return "Unknown command: " + command;
            
        } catch (error) {
            return "Error: " + error.toString();
        }
    }
    
    // Expose function
    window.processCommand = processCommand;
    
    $.writeln("Simple test JSX loaded successfully");
    
})();
