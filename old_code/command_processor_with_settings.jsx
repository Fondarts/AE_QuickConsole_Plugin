// Command Console with Settings Support
// Handles command processing and shortcut management

(function() {
    'use strict';
    
    // Main command processor
    function processCommand(command) {
        try {
            if (!command || command === '') {
                return "Error: No command provided";
            }
            
            // Get selected layers
            var comp = app.project.activeItem;
            if (!comp || !(comp instanceof CompItem)) {
                return "Error: No active composition";
            }
            
            var selectedLayers = comp.selectedLayers;
            if (selectedLayers.length === 0) {
                return "Error: No layers selected";
            }
            
            var commandLower = command.toLowerCase();
            var result = "";
            
            // Process each selected layer
            for (var i = 0; i < selectedLayers.length; i++) {
                var layer = selectedLayers[i];
                var layerResult = processLayerCommand(layer, commandLower, command);
                if (layerResult) {
                    result += layerResult + " ";
                }
            }
            
            return result.trim() || "Command executed successfully";
            
        } catch (error) {
            return "Error: " + error.toString();
        }
    }
    
    // Process command for a single layer
    function processLayerCommand(layer, commandLower, originalCommand) {
        try {
            // Layer operations
            if (commandLower === "mute") {
                layer.enabled = false;
                return "Muted " + layer.name;
            }
            else if (commandLower === "unmute") {
                layer.enabled = true;
                return "Unmuted " + layer.name;
            }
            else if (commandLower === "solo") {
                layer.solo = true;
                return "Soloed " + layer.name;
            }
            else if (commandLower === "unsolo") {
                layer.solo = false;
                return "Unsoloed " + layer.name;
            }
            else if (commandLower === "duplicate") {
                var newLayer = layer.duplicate();
                return "Duplicated " + layer.name;
            }
            else if (commandLower === "delete") {
                var layerName = layer.name;
                layer.remove();
                return "Deleted " + layerName;
            }
            else if (commandLower === "hide") {
                layer.enabled = false;
                return "Hidden " + layer.name;
            }
            else if (commandLower === "show") {
                layer.enabled = true;
                return "Showed " + layer.name;
            }
            // Transform operations
            else if (commandLower === "reset") {
                resetLayerTransform(layer);
                return "Reset transform for " + layer.name;
            }
            // Create elements
            else if (commandLower === "null") {
                var nullLayer = layer.containingComp.layers.addNull();
                nullLayer.name = "Null " + (layer.containingComp.layers.length);
                return "Created null layer";
            }
            else if (commandLower === "adjustment") {
                var adjLayer = layer.containingComp.layers.addSolid([1, 1, 1], "Adjustment Layer", layer.containingComp.width, layer.containingComp.height, 1);
                adjLayer.adjustmentLayer = true;
                adjLayer.name = "Adjustment Layer";
                return "Created adjustment layer";
            }
            else if (commandLower === "shape") {
                var shapeLayer = layer.containingComp.layers.addShape();
                shapeLayer.name = "Shape Layer";
                return "Created shape layer";
            }
            else if (commandLower === "camera") {
                var camera = layer.containingComp.layers.addCamera("Camera", [layer.containingComp.width/2, layer.containingComp.height/2]);
                return "Created camera";
            }
            else if (commandLower === "light") {
                var light = layer.containingComp.layers.addLight("Light", [layer.containingComp.width/2, layer.containingComp.height/2]);
                return "Created light";
            }
            // Effects
            else {
                return addEffectToLayer(layer, originalCommand);
            }
            
        } catch (error) {
            return "Error processing " + layer.name + ": " + error.toString();
        }
    }
    
    // Reset layer transform properties
    function resetLayerTransform(layer) {
        try {
            if (layer.property("Transform")) {
                var transform = layer.property("Transform");
                
                if (transform.property("Position")) {
                    var pos = transform.property("Position");
                    if (pos.numKeys > 0) {
                        pos.removeKey(1);
                    }
                }
                
                if (transform.property("Scale")) {
                    var scale = transform.property("Scale");
                    if (scale.numKeys > 0) {
                        scale.removeKey(1);
                    }
                }
                
                if (transform.property("Rotation")) {
                    var rotation = transform.property("Rotation");
                    if (rotation.numKeys > 0) {
                        rotation.removeKey(1);
                    }
                }
                
                if (transform.property("Opacity")) {
                    var opacity = transform.property("Opacity");
                    if (opacity.numKeys > 0) {
                        opacity.removeKey(1);
                    }
                }
            }
        } catch (error) {
            // Ignore errors for properties that don't exist
        }
    }
    
    // Add effect to layer
    function addEffectToLayer(layer, effectName) {
        try {
            // Try to add the effect by name
            var effect = layer.Effects.addProperty(effectName);
            if (effect) {
                return "Added " + effectName + " to " + layer.name;
            }
        } catch (error) {
            // If exact name fails, try to find similar effects
            try {
                var effects = app.effects;
                for (var i = 1; i <= effects.length; i++) {
                    var effect = effects[i];
                    if (effect.name.toLowerCase().indexOf(effectName.toLowerCase()) !== -1) {
                        layer.Effects.addProperty(effect.name);
                        return "Added " + effect.name + " to " + layer.name;
                    }
                }
                return "Effect '" + effectName + "' not found";
            } catch (searchError) {
                return "Error adding effect: " + error.toString();
            }
        }
    }
    
    // Get After Effects shortcuts for conflict checking
    function getAfterEffectsShortcuts() {
        try {
            // This would ideally query After Effects for its current shortcuts
            // For now, return a comprehensive list of common AE shortcuts
            return [
                "Ctrl+N", "Ctrl+O", "Ctrl+S", "Ctrl+Z", "Ctrl+Y", "Ctrl+X", "Ctrl+C", "Ctrl+V",
                "Ctrl+A", "Ctrl+D", "Ctrl+Shift+D", "Ctrl+Alt+D", "Ctrl+Shift+A", "Ctrl+Alt+A",
                "Ctrl+Shift+C", "Ctrl+Alt+C", "Ctrl+Shift+V", "Ctrl+Alt+V", "Ctrl+Shift+Z",
                "Ctrl+1", "Ctrl+2", "Ctrl+3", "Ctrl+4", "Ctrl+5", "Ctrl+6", "Ctrl+7", "Ctrl+8", "Ctrl+9",
                "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12",
                "Space", "Enter", "Escape", "Tab", "Shift+Tab", "Delete", "Backspace",
                "Ctrl+Shift+N", "Ctrl+Alt+N", "Ctrl+Shift+O", "Ctrl+Alt+O",
                "Ctrl+Shift+S", "Ctrl+Alt+S", "Ctrl+Shift+Z", "Ctrl+Alt+Z",
                "Ctrl+Shift+X", "Ctrl+Alt+X", "Ctrl+Shift+C", "Ctrl+Alt+C",
                "Ctrl+Shift+V", "Ctrl+Alt+V", "Ctrl+Shift+A", "Ctrl+Alt+A",
                "Ctrl+Shift+D", "Ctrl+Alt+D", "Ctrl+Shift+F", "Ctrl+Alt+F",
                "Ctrl+Shift+G", "Ctrl+Alt+G", "Ctrl+Shift+H", "Ctrl+Alt+H",
                "Ctrl+Shift+I", "Ctrl+Alt+I", "Ctrl+Shift+J", "Ctrl+Alt+J",
                "Ctrl+Shift+K", "Ctrl+Alt+K", "Ctrl+Shift+L", "Ctrl+Alt+L",
                "Ctrl+Shift+M", "Ctrl+Alt+M", "Ctrl+Shift+N", "Ctrl+Alt+N",
                "Ctrl+Shift+O", "Ctrl+Alt+O", "Ctrl+Shift+P", "Ctrl+Alt+P",
                "Ctrl+Shift+Q", "Ctrl+Alt+Q", "Ctrl+Shift+R", "Ctrl+Alt+R",
                "Ctrl+Shift+S", "Ctrl+Alt+S", "Ctrl+Shift+T", "Ctrl+Alt+T",
                "Ctrl+Shift+U", "Ctrl+Alt+U", "Ctrl+Shift+V", "Ctrl+Alt+V",
                "Ctrl+Shift+W", "Ctrl+Alt+W", "Ctrl+Shift+X", "Ctrl+Alt+X",
                "Ctrl+Shift+Y", "Ctrl+Alt+Y", "Ctrl+Shift+Z", "Ctrl+Alt+Z"
            ];
        } catch (error) {
            return [];
        }
    }
    
    // Check if a shortcut conflicts with After Effects
    function checkShortcutConflict(shortcut) {
        try {
            var aeShortcuts = getAfterEffectsShortcuts();
            for (var i = 0; i < aeShortcuts.length; i++) {
                if (aeShortcuts[i].toLowerCase() === shortcut.toLowerCase()) {
                    return "CONFLICT";
                }
            }
            return "AVAILABLE";
        } catch (error) {
            return "ERROR";
        }
    }
    
    // Get plugin information
    function getPluginInfo() {
        try {
            return {
                name: "Command Console",
                version: "1.0.0",
                description: "Quick command interface for After Effects",
                author: "AE Quick Console",
                shortcuts: getAfterEffectsShortcuts()
            };
        } catch (error) {
            return {
                name: "Command Console",
                version: "1.0.0",
                description: "Quick command interface for After Effects",
                author: "AE Quick Console",
                shortcuts: []
            };
        }
    }
    
    // Expose functions to CEP
    window.processCommand = processCommand;
    window.checkShortcutConflict = checkShortcutConflict;
    window.getPluginInfo = getPluginInfo;
    window.getAfterEffectsShortcuts = getAfterEffectsShortcuts;
    
})();

