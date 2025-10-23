// Simple Effect Scanner V57 - Only scans 2 specific folders
var allEffects = [];
var allEffectsWithPaths = [];

// Function to scan a single folder
function scanFolder(folderPath) {
    var effects = [];
    try {
        var folder = new Folder(folderPath);
        if (folder.exists) {
            var files = folder.getFiles();
            for (var i = 0; i < files.length; i++) {
                var file = files[i];
                if (file instanceof Folder) {
                    // Skip problematic folders
                    var folderName = file.name.toLowerCase();
                    if (folderName === "keyframe" || 
                        folderName === "extensions" || 
                        folderName === "format") {
                        continue; // Skip these folders
                    }
                    
                    // Recursively scan subfolders
                    var subEffects = scanFolder(file.fsName);
                    effects = effects.concat(subEffects);
                } else {
                    // Check if it's a plugin file
                    var fileName = file.name.toLowerCase();
                    if (fileName.indexOf(".aex") !== -1) {
                        var effectName = file.name.substring(0, file.name.indexOf(".aex"));
                        effectName = effectName.replace(/_/g, " ");
                        effectName = effectName.replace(/-/g, " ");
                        effectName = effectName.replace(/%20/g, " "); // Decode URL spaces
                        if (effectName && effectName !== "" && effectName.length > 1) {
                            effects.push({
                                name: effectName,
                                path: file.fsName
                            });
                        }
                    }
                }
            }
        }
    } catch (e) {
        // Ignore errors
    }
    return effects;
}

// Scan the 2 specific folders
function scanEffects() {
    allEffects = [];
    allEffectsWithPaths = [];
    
    // Scan folder 1
    var effects1 = scanFolder("C:/Program Files/Adobe/Adobe After Effects 2025/Support Files/Plug-ins");
    allEffectsWithPaths = allEffectsWithPaths.concat(effects1);
    
    // Scan folder 2
    var effects2 = scanFolder("C:/Program Files/Adobe/Common/Plug-ins/7.0/MediaCore");
    allEffectsWithPaths = allEffectsWithPaths.concat(effects2);
    
    // Remove duplicates and sort
    var uniqueEffects = [];
    var uniqueEffectsWithPaths = [];
    for (var i = 0; i < allEffectsWithPaths.length; i++) {
        var effect = allEffectsWithPaths[i];
        var found = false;
        for (var j = 0; j < uniqueEffects.length; j++) {
            if (uniqueEffects[j] === effect.name) {
                found = true;
                break;
            }
        }
        if (!found) {
            uniqueEffects.push(effect.name);
            uniqueEffectsWithPaths.push(effect);
        }
    }
    
    // Sort by name
    uniqueEffectsWithPaths.sort(function(a, b) {
        return a.name.localeCompare(b.name);
    });
    
    allEffects = uniqueEffects.sort();
    allEffectsWithPaths = uniqueEffectsWithPaths;
    
    // Post-processing: Fix CC effect names
    fixCCEffectNames();
    
    // Add layer creation commands to the list
    addLayerCommands();
    
    return allEffects;
}

// Test function
function testJSX() {
    return "JSX working - Found " + allEffects.length + " effects";
}

// Get effects count
function getEffectsCount() {
    return allEffects.length;
}

// Get effects list as string
function getEffectsList() {
    if (allEffects.length === 0) {
        return "No effects found";
    }
    return allEffects.join("\n");
}

// Apply effect to active layer or execute command
function applyEffect(effectName) {
    try {
        // Check if this is a layer creation command
        var parts = effectName.split(" ");
        var action = parts[0].toLowerCase();
        
        if (action === "solid" || action === "text" || action === "light" || 
            action === "camera" || action === "null" || action === "adjustment") {
            // This is a layer creation command, use processCreateCommand
            return processCreateCommand(effectName);
        } else if (action === "select" || action === "unselect" || action === "solo" || action === "unsolo" ||
                   action === "hide" || action === "show" || action === "mute" || action === "unmute" ||
                   action === "audio" || action === "lock" || action === "unlock" || action === "shy" ||
                   action === "unshy" || effectName === "motion blur" || effectName === "3d layer" ||
                   effectName === "parent to" || effectName === "track matte" || action === "scale" || action === "opacity" ||
                   action === "precompose" || action === "duplicate" || effectName === "center anchor" ||
                   effectName === "fit to comp" || effectName === "reset transform" || action === "delete" ||
                   action === "normal" || action === "multiply" || action === "screen" || action === "overlay" ||
                   action === "add" || action === "difference" || effectName === "soft light" || effectName === "hard light" ||
                   (parts.length >= 2 && parts[0].toLowerCase() === "label")) {
            // This is a layer property command that needs parameters
            if (effectName === "parent to") {
                return "Enter parent layer number (e.g., 5) and press Enter";
            } else if (effectName === "track matte") {
                return "Enter track matte layer number (e.g., 3) and press Enter";
            } else if (action === "scale") {
                return "Enter scale percentage (e.g., 50 or 200) and press Enter";
            } else if (action === "opacity") {
                return "Enter opacity value (0-100) and press Enter";
            } else if (parts.length >= 2 && parts[0].toLowerCase() === "label") {
                // Handle label commands directly in applyEffect
                return processLayerCommand(effectName);
            } else if (parts.length >= 2 && parts[0].toLowerCase() === "select" && parts[1].toLowerCase() === "all") {
                // Handle select all directly in applyEffect
                return processLayerCommand(effectName);
            } else if (parts.length >= 2 && parts[0].toLowerCase() === "deselect" && parts[1].toLowerCase() === "all") {
                // Handle deselect all directly in applyEffect
                return processLayerCommand(effectName);
            } else if (action === "precompose") {
                // Handle precompose directly in applyEffect
                return processLayerCommand(effectName);
            } else if (action === "duplicate") {
                // Handle duplicate directly in applyEffect
                return processLayerCommand(effectName);
            } else if (effectName === "center anchor") {
                // Handle center anchor directly in applyEffect
                return processLayerCommand(effectName);
            } else if (effectName === "fit to comp") {
                // Handle fit to comp directly in applyEffect
                return processLayerCommand(effectName);
            } else if (effectName === "reset transform") {
                // Handle reset transform directly in applyEffect
                return processLayerCommand(effectName);
            } else if (action === "delete") {
                // Handle delete directly in applyEffect
                return processLayerCommand(effectName);
            } else if (action === "normal" || action === "multiply" || action === "screen" || action === "overlay" ||
                       action === "add" || action === "difference") {
                // Handle blending mode commands directly in applyEffect
                return processLayerCommand(effectName);
            } else if (effectName === "soft light" || effectName === "hard light") {
                // Handle multi-word blending mode commands directly in applyEffect
                return processLayerCommand(effectName);
            }
            return "Enter layer numbers (e.g., 1,2,4) or press Enter for selected layers";
        }
        
        // This is a regular effect, apply to layer
        var comp = app.project.activeItem;
        if (!comp || !(comp instanceof CompItem)) {
            return "Error: Please select a composition first.";
        }
        
        var layer = comp.selectedLayers[0];
        if (!layer) {
            return "Error: Please select a layer first.";
        }
        
        app.beginUndoGroup("Apply Effect: " + effectName);
        
        try {
            // Try to apply the effect
            var effect = layer.effect.addProperty(effectName);
            return "Success: Effect '" + effectName + "' applied to layer.";
        } catch (e) {
            // If the effect name doesn't work, try some variations
            var variations = [];
            
            // Create variations safely
            try {
                variations.push(effectName.replace(/\s+/g, "")); // Remove all spaces
            } catch (e1) {}
            
            try {
                variations.push(effectName.replace(/\s+/g, "_")); // Replace spaces with underscores
            } catch (e2) {}
            
            try {
                variations.push(effectName.replace(/\s+/g, "-")); // Replace spaces with hyphens
            } catch (e3) {}
            
            try {
                var variation = effectName.replace(/\s+/g, "").replace(/([A-Z])/g, " $1");
                variation = variation.replace(/^\s+|\s+$/g, ""); // Trim manually
                variations.push(variation);
            } catch (e4) {}
            
            // Try each variation
            for (var i = 0; i < variations.length; i++) {
                try {
                    var variation = variations[i];
                    if (variation && variation !== effectName && variation.length > 0) {
                        layer.effect.addProperty(variation);
                        return "Success: Effect '" + variation + "' applied to layer (variation of '" + effectName + "').";
                    }
                } catch (e5) {
                    // Continue to next variation
                }
            }
            
            return "Error: Could not apply effect '" + effectName + "' with any variation. Original error: " + e.toString();
        } finally {
            app.endUndoGroup();
        }
        
    } catch (e) {
        return "Error: " + e.toString();
    }
}

// Process layer selection commands
function processLayerCommand(command) {
    try {
        // Validate command parameter
        if (!command || typeof command !== 'string') {
            return "Error: Invalid command parameter.";
        }
        
        var comp = app.project.activeItem;
        if (!comp || !(comp instanceof CompItem)) {
            return "Error: Please select a composition first.";
        }
        
        var layers = comp.layers;
        if (layers.length === 0) {
            return "Error: No layers in composition.";
        }
        
        // Parse command - handle trim safely
        var trimmedCommand = command.replace(/^\s+|\s+$/g, ''); // Manual trim
        if (trimmedCommand === '') {
            return "Error: Empty command.";
        }
        
        var parts = trimmedCommand.split(" ");
        var action = parts[0].toLowerCase();
        
        // Check for two-word commands
        if (parts.length >= 2) {
            var twoWordCommand = (parts[0] + " " + parts[1]).toLowerCase();
            if (twoWordCommand === "motion blur" || twoWordCommand === "3d layer" ||
                twoWordCommand === "parent to" || twoWordCommand === "track matte") {
                action = twoWordCommand;
            }
        }
        
        app.beginUndoGroup(action.charAt(0).toUpperCase() + action.substring(1) + " Layers");
        
        if (action === "select") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: select 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            // Convert to layer indices (After Effects uses 1-based indexing)
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, ''); // Manual trim
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num); // After Effects uses 1-based indexing
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            // Select specified layers (add to selection)
            for (var j = 0; j < layerIndices.length; j++) {
                layers[layerIndices[j]].selected = true;
            }
            return "Success: Selected layers " + layerNumbers;
            
        } else if (action === "unselect") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: unselect 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            // Convert to layer indices (After Effects uses 1-based indexing)
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, ''); // Manual trim
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num); // After Effects uses 1-based indexing
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            // Unselect specified layers
            for (var k = 0; k < layerIndices.length; k++) {
                layers[layerIndices[k]].selected = false;
            }
            return "Success: Unselected layers " + layerNumbers;
            
        } else if (action === "solo") {
            var layerIndices = [];
            
            if (parts.length >= 2) {
                // Solo specified layers
                var layerNumbers = parts[1];
                var numbers = layerNumbers.split(",");
                
                // Convert to layer indices (After Effects uses 1-based indexing)
                for (var i = 0; i < numbers.length; i++) {
                    var numStr = numbers[i].replace(/^\s+|\s+$/g, ''); // Manual trim
                    var num = parseInt(numStr);
                    if (num >= 1 && num <= layers.length) {
                        layerIndices.push(num); // After Effects uses 1-based indexing
                    } else {
                        return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                    }
                }
            } else {
                // Solo selected layers
                for (var l = 0; l < layers.length; l++) {
                    if (layers[l + 1].selected) { // After Effects uses 1-based indexing
                        layerIndices.push(l + 1); // Store 1-based index
                    }
                }
                if (layerIndices.length === 0) {
                    return "Error: No layers selected. Please select layers first or specify layer numbers.";
                }
            }
            
            // Solo specified layers (hide all others) - using Adobe's Layer.solo property
            for (var m = 1; m <= layers.length; m++) {
                layers[m].solo = false; // First, unsolo all layers (1-based indexing)
            }
            for (var n = 0; n < layerIndices.length; n++) {
                layers[layerIndices[n]].solo = true; // Then solo specified layers
            }
            
            if (parts.length >= 2) {
                return "Success: Solo layers " + parts[1];
            } else {
                return "Success: Solo selected layers";
            }
            
        } else if (action === "unsolo") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: unsolo 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            // Convert to layer indices (After Effects uses 1-based indexing)
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, ''); // Manual trim
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num); // After Effects uses 1-based indexing
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            // Unsolo specified layers
            for (var o = 0; o < layerIndices.length; o++) {
                layers[layerIndices[o]].solo = false;
            }
            return "Success: Unsolo layers " + layerNumbers;
            
        } else if (action === "hide") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: hide 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, '');
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num);
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            for (var h = 0; h < layerIndices.length; h++) {
                layers[layerIndices[h]].enabled = false;
            }
            return "Success: Hide layers " + layerNumbers;
            
        } else if (action === "show") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: show 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, '');
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num);
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            for (var s = 0; s < layerIndices.length; s++) {
                layers[layerIndices[s]].enabled = true;
            }
            return "Success: Show layers " + layerNumbers;
            
        } else if (action === "mute") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: mute 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, '');
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num);
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            for (var m = 0; m < layerIndices.length; m++) {
                layers[layerIndices[m]].audioEnabled = false;
            }
            return "Success: Mute layers " + layerNumbers;
            
        } else if (action === "unmute") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: unmute 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, '');
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num);
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            for (var u = 0; u < layerIndices.length; u++) {
                layers[layerIndices[u]].audioEnabled = true;
            }
            return "Success: Unmute layers " + layerNumbers;
            
        } else if (action === "audio") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: audio 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, '');
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num);
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            for (var a = 0; a < layerIndices.length; a++) {
                layers[layerIndices[a]].audioEnabled = true;
            }
            return "Success: Enable audio for layers " + layerNumbers;
            
        } else if (action === "lock") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: lock 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, '');
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num);
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            for (var l = 0; l < layerIndices.length; l++) {
                layers[layerIndices[l]].locked = true;
            }
            return "Success: Lock layers " + layerNumbers;
            
        } else if (action === "unlock") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: unlock 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, '');
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num);
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            for (var ul = 0; ul < layerIndices.length; ul++) {
                layers[layerIndices[ul]].locked = false;
            }
            return "Success: Unlock layers " + layerNumbers;
            
        } else if (action === "shy") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: shy 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, '');
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num);
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            for (var sh = 0; sh < layerIndices.length; sh++) {
                layers[layerIndices[sh]].shy = true;
            }
            return "Success: Shy layers " + layerNumbers;
            
        } else if (action === "unshy") {
            if (parts.length < 2) {
                return "Error: Please specify layer numbers. Example: unshy 1,5,7";
            }
            
            var layerNumbers = parts[1];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, '');
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num);
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            for (var ush = 0; ush < layerIndices.length; ush++) {
                layers[layerIndices[ush]].shy = false;
            }
            return "Success: Unshy layers " + layerNumbers;
            
        } else if (action === "motion blur") {
            if (parts.length < 3) {
                return "Error: Please specify layer numbers. Example: motion blur 1,5,7";
            }
            
            var layerNumbers = parts[2];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, '');
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num);
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            for (var mb = 0; mb < layerIndices.length; mb++) {
                layers[layerIndices[mb]].motionBlur = true;
            }
            return "Success: Enable motion blur for layers " + layerNumbers;
            
        } else if (action === "3d layer") {
            if (parts.length < 3) {
                return "Error: Please specify layer numbers. Example: 3d layer 1,5,7";
            }
            
            var layerNumbers = parts[2];
            var numbers = layerNumbers.split(",");
            var layerIndices = [];
            
            for (var i = 0; i < numbers.length; i++) {
                var numStr = numbers[i].replace(/^\s+|\s+$/g, '');
                var num = parseInt(numStr);
                if (num >= 1 && num <= layers.length) {
                    layerIndices.push(num);
                } else {
                    return "Error: Layer " + num + " does not exist. Composition has " + layers.length + " layers.";
                }
            }
            
            for (var d3 = 0; d3 < layerIndices.length; d3++) {
                layers[layerIndices[d3]].threeDLayer = true;
            }
            return "Success: Enable 3D for layers " + layerNumbers;
            
        } else if (action === "parent to") {
            if (parts.length < 3) {
                return "Error: Please specify parent layer number. Example: parent to 5";
            }
            
            var parentNumber = parseInt(parts[2]);
            if (isNaN(parentNumber) || parentNumber < 1 || parentNumber > layers.length) {
                return "Error: Parent layer " + parentNumber + " does not exist. Composition has " + layers.length + " layers.";
            }
            
            var parentLayer = layers[parentNumber];
            var selectedLayers = comp.selectedLayers;
            
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to parent.";
            }
            
            var parentedCount = 0;
            for (var p = 0; p < selectedLayers.length; p++) {
                var layer = selectedLayers[p];
                if (layer !== parentLayer) { // Don't parent a layer to itself
                    layer.parent = parentLayer;
                    parentedCount++;
                }
            }
            
            return "Success: Parented " + parentedCount + " layers to layer " + parentNumber;
            
        } else if (action === "track matte") {
            if (parts.length < 3) {
                return "Error: Please specify track matte layer number. Example: track matte 3";
            }
            
            var trackMatteNumber = parseInt(parts[2]);
            if (isNaN(trackMatteNumber) || trackMatteNumber < 1 || trackMatteNumber > layers.length) {
                return "Error: Track matte layer " + trackMatteNumber + " does not exist. Composition has " + layers.length + " layers.";
            }
            
            var trackMatteLayer = layers[trackMatteNumber];
            var selectedLayers = comp.selectedLayers;
            
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to set track matte.";
            }
            
            var trackMatteCount = 0;
            for (var tm = 0; tm < selectedLayers.length; tm++) {
                var layer = selectedLayers[tm];
                if (layer !== trackMatteLayer) { // Don't set track matte to itself
                    try {
                        // Set track matte type first
                        layer.trackMatteType = TrackMatteType.ALPHA;
                        // Use the correct method to set track matte layer
                        layer.setTrackMatte(trackMatteLayer, TrackMatteType.ALPHA);
                        trackMatteCount++;
                    } catch (e) {
                        // If setTrackMatte doesn't work, try alternative method
                        try {
                            layer.trackMatteType = TrackMatteType.ALPHA;
                            // Alternative: move the track matte layer above and set relationship
                            trackMatteLayer.moveBefore(layer);
                            trackMatteCount++;
                        } catch (e2) {
                            // Continue with other layers if this one fails
                        }
                    }
                }
            }
            
            return "Success: Set track matte alpha for " + trackMatteCount + " layers using layer " + trackMatteNumber;
            
        } else if (action === "unparent") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to unparent.";
            }
            
            var unparentedCount = 0;
            for (var up = 0; up < selectedLayers.length; up++) {
                var layer = selectedLayers[up];
                if (layer.parent) {
                    layer.parent = null;
                    unparentedCount++;
                }
            }
            
            return "Success: Unparented " + unparentedCount + " layers";
            
        } else if (action === "untrack matte") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to remove track matte.";
            }
            
            var untrackedCount = 0;
            for (var ut = 0; ut < selectedLayers.length; ut++) {
                var layer = selectedLayers[ut];
                if (layer.trackMatteType !== TrackMatteType.NO_TRACK_MATTE) {
                    layer.trackMatteType = TrackMatteType.NO_TRACK_MATTE;
                    untrackedCount++;
                }
            }
            
            return "Success: Removed track matte from " + untrackedCount + " layers";
            
        } else if (action === "select" && parts[1] === "all") {
            // Rebuilt from scratch - simple approach
            var selectedCount = 0;
            for (var i = 1; i <= comp.numLayers; i++) {
                try {
                    comp.layer(i).selected = true;
                    selectedCount++;
                } catch (e) {
                    // Skip problematic layers
                }
            }
            return "Success: Selected " + selectedCount + " layers";
            
        } else if (action === "deselect" && parts[1] === "all") {
            // Rebuilt from scratch - simple approach
            var deselectedCount = 0;
            for (var i = 1; i <= comp.numLayers; i++) {
                try {
                    comp.layer(i).selected = false;
                    deselectedCount++;
                } catch (e) {
                    // Skip problematic layers
                }
            }
            return "Success: Deselected " + deselectedCount + " layers";
            
        } else if (action === "label" || (parts.length >= 2 && parts[0].toLowerCase() === "label")) {
            if (parts.length < 2) {
                return "Error: Please specify label color. Example: label red";
            }
            
            // Handle multi-word label colors
            var labelColor;
            if (parts.length >= 3 && parts[1].toLowerCase() === "sea" && parts[2].toLowerCase() === "foam") {
                labelColor = "sea foam";
            } else if (parts.length >= 3 && parts[1].toLowerCase() === "dark" && parts[2].toLowerCase() === "green") {
                labelColor = "dark green";
            } else {
                labelColor = parts[1].toLowerCase();
            }
            
            var labelMap = {
                "none": 0, "red": 1, "yellow": 2, "aqua": 3, "pink": 4, "lavender": 5,
                "peach": 6, "sea foam": 7, "blue": 8, "green": 9, "purple": 10,
                "orange": 11, "brown": 12, "fuchsia": 13, "cyan": 14, "sandstone": 15, "dark green": 16
            };
            
            var labelValue = labelMap[labelColor];
            if (labelValue === undefined) {
                return "Error: Unknown label color '" + labelColor + "'. Use: none, red, yellow, aqua, pink, lavender, peach, sea foam, blue, green, purple, orange, brown, fuchsia, cyan, sandstone, dark green";
            }
            
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to label.";
            }
            
            for (var l = 0; l < selectedLayers.length; l++) {
                selectedLayers[l].label = labelValue;
            }
            
            return "Success: Set label '" + labelColor + "' for " + selectedLayers.length + " layers";
            
        } else if (action === "scale") {
            if (parts.length < 2) {
                return "Error: Please specify scale percentage. Example: scale 50";
            }
            
            var scaleValue = parseFloat(parts[1]);
            if (isNaN(scaleValue) || scaleValue <= 0) {
                return "Error: Invalid scale value. Use a positive number (e.g., 50 for 50%)";
            }
            
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to scale.";
            }
            
            var scaledCount = 0;
            for (var s = 0; s < selectedLayers.length; s++) {
                var layer = selectedLayers[s];
                var scale = layer.property("Transform").property("Scale");
                if (scale && scale.numKeys === 0) {
                    scale.setValue([scaleValue, scaleValue]);
                    scaledCount++;
                }
            }
            
            return "Success: Set scale to " + scaleValue + "% for " + scaledCount + " layers";
            
        } else if (action === "opacity") {
            if (parts.length < 2) {
                return "Error: Please specify opacity value (0-100). Example: opacity 50";
            }
            
            var opacityValue = parseFloat(parts[1]);
            if (isNaN(opacityValue) || opacityValue < 0 || opacityValue > 100) {
                return "Error: Invalid opacity value. Use a number between 0 and 100";
            }
            
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to set opacity.";
            }
            
            var opacityCount = 0;
            for (var o = 0; o < selectedLayers.length; o++) {
                var layer = selectedLayers[o];
                var opacity = layer.property("Transform").property("Opacity");
                if (opacity && opacity.numKeys === 0) {
                    opacity.setValue(opacityValue);
                    opacityCount++;
                }
            }
            
            return "Success: Set opacity to " + opacityValue + "% for " + opacityCount + " layers";
            
        } else if (action === "precompose") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to precompose.";
            }
            
            // Get the name for the new composition
            var compName = "Pre-comp " + (new Date().getTime());
            if (parts.length >= 2) {
                compName = parts.slice(1).join(" "); // Join all parts after "precompose"
            }
            
            try {
                // Get layer indices from selected layers
                var layerIndices = [];
                for (var i = 0; i < selectedLayers.length; i++) {
                    layerIndices.push(selectedLayers[i].index);
                }
                
                // Precompose selected layers using correct API
                var newComp = comp.layers.precompose(layerIndices, compName);
                return "Success: Precomposed " + selectedLayers.length + " layers into '" + compName + "'";
            } catch (e) {
                return "Error: Could not precompose layers. " + e.toString();
            }
            
        } else if (action === "duplicate") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to duplicate.";
            }
            
            try {
                var duplicatedCount = 0;
                for (var d = 0; d < selectedLayers.length; d++) {
                    var layer = selectedLayers[d];
                    layer.duplicate();
                    duplicatedCount++;
                }
                return "Success: Duplicated " + duplicatedCount + " layers";
            } catch (e) {
                return "Error: Could not duplicate layers. " + e.toString();
            }
            
        } else if (action === "center" && parts[1] === "anchor") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to center anchor.";
            }
            
            try {
                var centeredCount = 0;
                for (var ca = 0; ca < selectedLayers.length; ca++) {
                    var layer = selectedLayers[ca];
                    var transform = layer.property("Transform");
                    var anchorPoint = transform.property("Anchor Point");
                    var position = transform.property("Position");
                    
                    if (anchorPoint && position) {
                        // Get current anchor point and position
                        var currentAnchor = anchorPoint.value;
                        var currentPosition = position.value;
                        
                        // Get layer dimensions
                        var width = layer.width;
                        var height = layer.height;
                        
                        // Calculate new anchor point (center of layer)
                        var newAnchor = [width / 2, height / 2];
                        
                        // Calculate the difference
                        var anchorDiff = [newAnchor[0] - currentAnchor[0], newAnchor[1] - currentAnchor[1]];
                        
                        // Set new anchor point
                        anchorPoint.setValue(newAnchor);
                        
                        // Adjust position to compensate for anchor point change
                        var newPosition = [currentPosition[0] + anchorDiff[0], currentPosition[1] + anchorDiff[1]];
                        position.setValue(newPosition);
                        
                        centeredCount++;
                    }
                }
                return "Success: Centered anchor point for " + centeredCount + " layers";
            } catch (e) {
                return "Error: Could not center anchor point. " + e.toString();
            }
            
        } else if (action === "fit" && parts[1] === "to" && parts[2] === "comp") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to fit to comp.";
            }
            
            try {
                var fittedCount = 0;
                for (var fc = 0; fc < selectedLayers.length; fc++) {
                    var layer = selectedLayers[fc];
                    var transform = layer.property("Transform");
                    var scale = transform.property("Scale");
                    var position = transform.property("Position");
                    
                    if (scale && position) {
                        // Get composition and layer dimensions
                        var compWidth = comp.width;
                        var compHeight = comp.height;
                        var layerWidth = layer.width;
                        var layerHeight = layer.height;
                        
                        // Calculate scale to fit composition
                        var scaleX = (compWidth / layerWidth) * 100;
                        var scaleY = (compHeight / layerHeight) * 100;
                        var uniformScale = Math.min(scaleX, scaleY);
                        
                        // Set scale
                        scale.setValue([uniformScale, uniformScale]);
                        
                        // Center layer in composition
                        var centerX = compWidth / 2;
                        var centerY = compHeight / 2;
                        position.setValue([centerX, centerY]);
                        
                        fittedCount++;
                    }
                }
                return "Success: Fitted and centered " + fittedCount + " layers to composition";
            } catch (e) {
                return "Error: Could not fit layers to composition. " + e.toString();
            }
            
        } else if (action === "reset" && parts[1] === "transform") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to reset transform.";
            }
            
            try {
                var resetCount = 0;
                for (var rt = 0; rt < selectedLayers.length; rt++) {
                    var layer = selectedLayers[rt];
                    var transform = layer.property("Transform");
                    
                    // Reset position to center
                    var position = transform.property("Position");
                    if (position) {
                        position.setValue([comp.width / 2, comp.height / 2]);
                    }
                    
                    // Reset scale to 100%
                    var scale = transform.property("Scale");
                    if (scale) {
                        scale.setValue([100, 100]);
                    }
                    
                    // Reset rotation to 0
                    var rotation = transform.property("Rotation");
                    if (rotation) {
                        rotation.setValue(0);
                    }
                    
                    // Reset opacity to 100%
                    var opacity = transform.property("Opacity");
                    if (opacity) {
                        opacity.setValue(100);
                    }
                    
                    resetCount++;
                }
                return "Success: Reset transform for " + resetCount + " layers";
            } catch (e) {
                return "Error: Could not reset transform. " + e.toString();
            }
            
        } else if (action === "delete") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to delete.";
            }
            
            try {
                var deletedCount = 0;
                for (var d = 0; d < selectedLayers.length; d++) {
                    var layer = selectedLayers[d];
                    layer.remove();
                    deletedCount++;
                }
                return "Success: Deleted " + deletedCount + " layers";
            } catch (e) {
                return "Error: Could not delete layers. " + e.toString();
            }
            
        } else if (action === "normal") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to set blending mode.";
            }
            
            try {
                var setCount = 0;
                for (var n = 0; n < selectedLayers.length; n++) {
                    var layer = selectedLayers[n];
                    layer.blendingMode = BlendingMode.NORMAL;
                    setCount++;
                }
                return "Success: Set blending mode to Normal for " + setCount + " layers";
            } catch (e) {
                return "Error: Could not set blending mode. " + e.toString();
            }
            
        } else if (action === "multiply") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to set blending mode.";
            }
            
            try {
                var setCount = 0;
                for (var m = 0; m < selectedLayers.length; m++) {
                    var layer = selectedLayers[m];
                    layer.blendingMode = BlendingMode.MULTIPLY;
                    setCount++;
                }
                return "Success: Set blending mode to Multiply for " + setCount + " layers";
            } catch (e) {
                return "Error: Could not set blending mode. " + e.toString();
            }
            
        } else if (action === "screen") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to set blending mode.";
            }
            
            try {
                var setCount = 0;
                for (var s = 0; s < selectedLayers.length; s++) {
                    var layer = selectedLayers[s];
                    layer.blendingMode = BlendingMode.SCREEN;
                    setCount++;
                }
                return "Success: Set blending mode to Screen for " + setCount + " layers";
            } catch (e) {
                return "Error: Could not set blending mode. " + e.toString();
            }
            
        } else if (action === "overlay") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to set blending mode.";
            }
            
            try {
                var setCount = 0;
                for (var o = 0; o < selectedLayers.length; o++) {
                    var layer = selectedLayers[o];
                    layer.blendingMode = BlendingMode.OVERLAY;
                    setCount++;
                }
                return "Success: Set blending mode to Overlay for " + setCount + " layers";
            } catch (e) {
                return "Error: Could not set blending mode. " + e.toString();
            }
            
        } else if (action === "soft" && parts[1] === "light") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to set blending mode.";
            }
            
            try {
                var setCount = 0;
                for (var sl = 0; sl < selectedLayers.length; sl++) {
                    var layer = selectedLayers[sl];
                    layer.blendingMode = BlendingMode.SOFT_LIGHT;
                    setCount++;
                }
                return "Success: Set blending mode to Soft Light for " + setCount + " layers";
            } catch (e) {
                return "Error: Could not set blending mode. " + e.toString();
            }
            
        } else if (action === "hard" && parts[1] === "light") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to set blending mode.";
            }
            
            try {
                var setCount = 0;
                for (var hl = 0; hl < selectedLayers.length; hl++) {
                    var layer = selectedLayers[hl];
                    layer.blendingMode = BlendingMode.HARD_LIGHT;
                    setCount++;
                }
                return "Success: Set blending mode to Hard Light for " + setCount + " layers";
            } catch (e) {
                return "Error: Could not set blending mode. " + e.toString();
            }
            
        } else if (action === "add") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to set blending mode.";
            }
            
            try {
                var setCount = 0;
                for (var a = 0; a < selectedLayers.length; a++) {
                    var layer = selectedLayers[a];
                    layer.blendingMode = BlendingMode.ADD;
                    setCount++;
                }
                return "Success: Set blending mode to Add for " + setCount + " layers";
            } catch (e) {
                return "Error: Could not set blending mode. " + e.toString();
            }
            
        } else if (action === "difference") {
            var selectedLayers = comp.selectedLayers;
            if (!selectedLayers || selectedLayers.length === 0) {
                return "Error: No layers selected. Please select layers to set blending mode.";
            }
            
            try {
                var setCount = 0;
                for (var d = 0; d < selectedLayers.length; d++) {
                    var layer = selectedLayers[d];
                    layer.blendingMode = BlendingMode.DIFFERENCE;
                    setCount++;
                }
                return "Success: Set blending mode to Difference for " + setCount + " layers";
            } catch (e) {
                return "Error: Could not set blending mode. " + e.toString();
            }
            
        } else {
            return "Error: Unknown command '" + action + "'. Use: select, unselect, solo, unsolo, hide, show, mute, unmute, audio, lock, unlock, shy, unshy, motion blur, 3d layer, parent to, track matte, unparent, untrack matte, select all, deselect all, label, scale, opacity, precompose, duplicate, center anchor, fit to comp, reset transform, delete, normal, multiply, screen, overlay, soft light, hard light, add, difference";
        }
        
                } catch (e) {
        return "Error: " + e.toString();
    } finally {
        app.endUndoGroup();
    }
}

// Process layer creation commands
function processCreateCommand(command) {
    try {
        // Validate command parameter
        if (!command || typeof command !== 'string') {
            return "Error: Invalid command parameter.";
        }
        
        var comp = app.project.activeItem;
        if (!comp || !(comp instanceof CompItem)) {
            return "Error: Please select a composition first.";
        }
        
        // Parse command - handle trim safely
        var trimmedCommand = command.replace(/^\s+|\s+$/g, ''); // Manual trim
        if (trimmedCommand === '') {
            return "Error: Empty command.";
        }
        
        var parts = trimmedCommand.split(" ");
        var action = parts[0].toLowerCase();
        
        app.beginUndoGroup("Create " + action.charAt(0).toUpperCase() + action.substring(1));
        
        if (action === "solid") {
            var color = [1, 1, 1]; // Default white
            var name = "Solid";
            
            if (parts.length >= 2) {
                var colorName = parts[1].toLowerCase();
                
                // Define colors
                var colors = {
                    "red": [1, 0, 0],
                    "blue": [0, 0, 1],
                    "yellow": [1, 1, 0],
                    "black": [0, 0, 0],
                    "white": [1, 1, 1],
                    "purple": [0.5, 0, 0.5]
                };
                
                if (colors[colorName]) {
                    color = colors[colorName];
                    name = "Solid " + colorName.charAt(0).toUpperCase() + colorName.substring(1);
                } else if (colorName.match(/^[0-9a-fA-F]{6}$/)) {
                    // Hexadecimal color
                    var hex = colorName;
                    var r = parseInt(hex.substr(0, 2), 16) / 255;
                    var g = parseInt(hex.substr(2, 2), 16) / 255;
                    var b = parseInt(hex.substr(4, 2), 16) / 255;
                    color = [r, g, b];
                    name = "Solid #" + hex.toUpperCase();
                } else {
                    return "Error: Unknown color '" + colorName + "'. Use: red, blue, yellow, black, white, purple, or hex (e.g., 11B159)";
                }
            }
            
            // Create solid layer
            var solid = comp.layers.addSolid(color, name, comp.width, comp.height, comp.pixelAspect);
            return "Success: Created " + name + " layer";
            
        } else if (action === "text") {
            // Create text layer
            var textLayer = comp.layers.addText("Text");
            return "Success: Created text layer";
            
        } else if (action === "light") {
            // Create light layer
            var light = comp.layers.addLight("Light", [0, 0]);
            return "Success: Created light layer";
            
        } else if (action === "camera") {
            // Create camera layer
            var camera = comp.layers.addCamera("Camera", [0, 0]);
            return "Success: Created camera layer";
            
        } else if (action === "null") {
            // Create null layer
            var nullLayer = comp.layers.addNull();
            return "Success: Created null layer";
            
        } else if (action === "adjustment" || action === "adjustmentlayer") {
            // Create adjustment layer
            var adjLayer = comp.layers.addSolid([1, 1, 1], "Adjustment Layer", comp.width, comp.height, comp.pixelAspect);
            adjLayer.adjustmentLayer = true;
            return "Success: Created adjustment layer";
            
        } else {
            return "Error: Unknown create command '" + action + "'. Use: solid, text, light, camera, null, or adjustment";
        }
        
    } catch (e) {
        return "Error: " + e.toString();
    } finally {
            app.endUndoGroup();
    }
}

// Export effects list with paths
function exportEffectsList() {
    try {
        if (allEffectsWithPaths.length === 0) {
            return "Error: No effects found to export.";
        }
        
        var fileName = "AE_Effects_List_V01_" + new Date().getFullYear() + "_" + (new Date().getMonth() + 1) + "_" + new Date().getDate() + ".txt";
        var desktopPath = Folder.desktop.fsName;
        var filePath = desktopPath + "/" + fileName;
        var file = new File(filePath);
        
        if (file.open("w")) {
            file.write("After Effects Effects List V01\n");
            file.write("==============================\n");
            file.write("Fecha: " + new Date().toString() + "\n");
            file.write("Total effects: " + allEffectsWithPaths.length + "\n\n");
            
            for (var i = 0; i < allEffectsWithPaths.length; i++) {
                var effect = allEffectsWithPaths[i];
                file.write((i + 1) + ". " + effect.name + "\n");
                file.write("   Path: " + effect.path + "\n\n");
            }
            
            file.close();
            return "Success: Effects list exported to " + fileName + " on desktop.";
        } else {
            return "Error: Could not create export file.";
        }
        
                } catch (e) {
        return "Error exporting effects: " + e.toString();
    }
}

// Function to fix CC effect names after scanning
function fixCCEffectNames() {
    // Known CC effects that need "CC " prefix
    var ccEffectsMap = {
        "Composite": "CC Composite",
        "Bubbles": "CC Bubbles", 
        "BallAction": "CC Ball Action",
        "Ball Action": "CC Ball Action",
        "BendIt": "CC Bend It",
        "Bend It": "CC Bend It",
        "Bender": "CC Bender",
        "Blobbylize": "CC Blobbylize",
        "Block Load": "CC Block Load",
        "Burn Film": "CC Burn Film",
        "Color Neutralizer": "CC Color Neutralizer",
        "Color Offset": "CC Color Offset",
        "Cylinder": "CC Cylinder",
        "Environment": "CC Environment",
        "Flo Motion": "CC Flo Motion",
        "Force Motion Blur": "CC Force Motion Blur",
        "Glass": "CC Glass",
        "Griddler": "CC Griddler",
        "HexTile": "CC HexTile",
        "Histogram": "CC Histogram",
        "Image Wipe": "CC Image Wipe",
        "Kaleida": "CC Kaleida",
        "Lens": "CC Lens",
        "Light Burst 2.5": "CC Light Burst 2.5",
        "Light Rays": "CC Light Rays",
        "Light Sweep": "CC Light Sweep",
        "Page Turn": "CC Page Turn",
        "Particle Systems II": "CC Particle Systems II",
        "Particle World": "CC Particle World",
        "Pixel Polly": "CC Pixel Polly",
        "Power Pin": "CC Power Pin",
        "Radial Blur": "CC Radial Blur",
        "Radial Fast Blur": "CC Radial Fast Blur",
        "Radial ScaleWipe": "CC Radial ScaleWipe",
        "RepeTile": "CC RepeTile",
        "Ripple Pulse": "CC Ripple Pulse",
        "Scale Wipe": "CC Scale Wipe",
        "Scatterize": "CC Scatterize",
        "Simple Wire Removal": "CC Simple Wire Removal",
        "Slant": "CC Slant",
        "Smear": "CC Smear",
        "Sphere": "CC Sphere",
        "Split": "CC Split",
        "Split2": "CC Split2",
        "Spotlight": "CC Spotlight",
        "Star Burst": "CC Star Burst",
        "Threshold": "CC Threshold",
        "Threshold RGB": "CC Threshold RGB",
        "Threads": "CC Threads",
        "Time Blend": "CC Time Blend",
        "Time Blend FX": "CC Time Blend FX",
        "Toner": "CC Toner",
        "Twister": "CC Twister",
        "Vector Blur": "CC Vector Blur",
        "Warpo": "CC Warpo",
        "Wave Warp": "CC Wave Warp",
        "Wide Time": "CC Wide Time",
        "Wireframe": "CC Wireframe"
    };
    
    // Additional effects that need spacing fixes
    var additionalEffectsMap = {
        "3DGlasses": "3D Glasses",
        "3DCameraTracker": "3D Camera Tracker",
        "3DGlasses": "3D Glasses",
        "AddGrain": "Add Grain",
        "ApplyColorLUT": "Apply Color Lut",
        "AuxChannelExtract": "3D Channel Extract",
        "AudioSpectrum": "Audio Spectrum",
        "AudioWaveform": "Audio Waveform",
        "AutoColor": "Auto Color",
        "AutoContrast": "Auto Contrast",
        "AutoLevels": "Auto Levels",
        "BevelAlpha": "Bevel Alpha",
        "BevelEdges": "Bevel Edges",
        "BezWarp New": "Bezier Warp",
        "Bilateral": "Bilateral Blur",
        "BilateralBlur": "Bilateral Blur",
        "BlockLoad": "CC Block Load",
        "BoxBlur": "Box Blur",
        "BurnFilm": "CC Burn Film",
        "BrightnessContrast": "Brightness & Contrast",
        "BrushStrokes": "Brush Strokes",
        "CameraLensBlur": "Camera Lens Blur",
        "CannedWarp": "CC Canned Warp",
        "ChangeColor": "Change Color",
        "ChangeToColor": "Change to Color",
        "ChannelBlur": "Channel Blur",
        "CineonEffect": "Cineon Converter",
        "Color Balance 2": "Color Balance",
        "ColorBalance": "Color Balance",
        "Color Diff": "Color Difference Key",
        "ColorDifferenceKey": "Color Difference Key",
        "Color Emboss": "Color Emboss",
        "ColorEmboss": "Color Emboss",
        "Color HLS": "Hue & Saturation",
        "ColorKey": "Color Key",
        "ColorLink": "Color Link",
        "ColorNeutralizer": "CC Color Neutralizer",
        "ColorOffset": "CC Color Offset",
        "ColorRange": "Color Range",
        "ColorShift": "Color Shift",
        "CompoundBlur": "Compound Blur",
        "CornerPin": "Corner Pin",
        "DepthMatte": "Depth Matte",
        "DepthOfField": "Depth of Field",
        "DifferenceMatte": "Difference Matte",
        "DirectionalBlur": "Directional Blur",
        "DropShadow": "Drop Shadow",
        "DustScratches": "Dust & Scratches",
        "ExpressionControls": "Expression Controls",
        "FastBlur": "Fast Blur",
        "GaussianBlur": "Gaussian Blur",
        "Glow": "Glow",
        "GradientWipe": "Gradient Wipe",
        "HueSaturation": "Hue & Saturation",
        "InnerShadow": "Inner Shadow",
        "LensFlare": "Lens Flare",
        "Levels": "Levels",
        "LinearWipe": "Linear Wipe",
        "MotionBlur": "Motion Blur",
        "Noise": "Noise",
        "NoiseHLS": "Noise HLS",
        "NoiseHLSAuto": "Noise HLS Auto",
        "Offset": "Offset",
        "OpticalCompensation": "Optical Compensation",
        "ParticlePlayground": "Particle Playground",
        "PathText": "Path Text",
        "Posterize": "Posterize",
        "RadialBlur": "Radial Blur",
        "RadialWipe": "Radial Wipe",
        "ReduceInterlaceFlicker": "Reduce Interlace Flicker",
        "Ripple": "Ripple",
        "Shatter": "Shatter",
        "Sharpen": "Sharpen",
        "ShiftChannels": "Shift Channels",
        "Spherize": "Spherize",
        "Text": "Text",
        "TimeDisplacement": "Time Displacement",
        "Tint": "Tint",
        "TurbulentDisplace": "Turbulent Displace",
        "Twirl": "Twirl",
        "UnsharpMask": "Unsharp Mask",
        "VectorPaint": "Vector Paint",
        "VenetianBlinds": "Venetian Blinds",
        "WaveWarp": "Wave Warp",
        "Wiggler": "Wiggler"
    };
    
    // Audio effects mapping (based on After Effects Plugin Match Names)
    var audioEffectsMap = {
        "Aud BT": "Bass & Treble",
        "Aud Delay": "Delay", 
        "Aud Flange": "Flange & Chorus",
        "Aud HiLo": "High-Low Pass",
        "Aud Mixer": "Stereo Mixer",
        "Aud Modulator": "Modulator",
        "Aud ParamEQ": "Parametric EQ",
        "Aud Reverb": "Reverb",
        "Aud Reverse": "Backwards",
        "Aud Tone": "Tone",
        "AudSpect": "Audio Spectrum",
        "AudWave": "Audio Waveform"
    };
    
    // Update allEffects array
    for (var i = 0; i < allEffects.length; i++) {
        var effectName = allEffects[i];
        if (ccEffectsMap[effectName]) {
            allEffects[i] = ccEffectsMap[effectName];
        } else if (additionalEffectsMap[effectName]) {
            allEffects[i] = additionalEffectsMap[effectName];
        } else if (audioEffectsMap[effectName]) {
            allEffects[i] = audioEffectsMap[effectName];
        }
    }
    
    // Update allEffectsWithPaths array
    for (var j = 0; j < allEffectsWithPaths.length; j++) {
        var effect = allEffectsWithPaths[j];
        if (ccEffectsMap[effect.name]) {
            effect.name = ccEffectsMap[effect.name];
        } else if (additionalEffectsMap[effect.name]) {
            effect.name = additionalEffectsMap[effect.name];
        } else if (audioEffectsMap[effect.name]) {
            effect.name = audioEffectsMap[effect.name];
        }
    }
}

// Add layer creation commands to the effects list
function addLayerCommands() {
    var layerCommands = [
        "solid red",
        "solid blue", 
        "solid yellow",
        "solid black",
        "solid white",
        "solid purple",
        "solid green",
        "solid orange",
        "solid pink",
        "solid cyan",
        "solid magenta",
        "solid gray",
        "text",
        "light",
        "camera",
        "null",
        "adjustment layer",
        "select",
        "solo",
        "unselect",
        "unsolo",
        "hide",
        "show",
        "mute",
        "unmute",
        "audio",
        "lock",
        "unlock",
        "shy",
        "unshy",
        "motion blur",
        "3d layer",
        "parent to",
        "track matte",
        "unparent",
        "untrack matte",
        "select all",
        "deselect all",
        "label none",
        "label red",
        "label yellow",
        "label aqua",
        "label pink",
        "label lavender",
        "label peach",
        "label sea foam",
        "label blue",
        "label green",
        "label purple",
        "label orange",
        "label brown",
        "label fuchsia",
        "label cyan",
        "label sandstone",
        "label dark green",
        "scale",
        "opacity",
        "precompose",
        "duplicate",
        "center anchor",
        "fit to comp",
        "reset transform",
        "delete",
        "normal",
        "multiply",
        "screen",
        "overlay",
        "soft light",
        "hard light",
        "add",
        "difference"
    ];
    
    // Add commands to the effects list
    for (var i = 0; i < layerCommands.length; i++) {
        allEffects.push(layerCommands[i]);
        allEffectsWithPaths.push({
            name: layerCommands[i],
            path: "COMMAND: " + layerCommands[i]
        });
    }
    
    // Re-sort the list
    allEffects.sort();
    allEffectsWithPaths.sort(function(a, b) {
        return a.name.localeCompare(b.name);
    });
}

// Process command from HTML interface
function processCommand(command) {
    try {
        if (!command || typeof command !== 'string') {
            return "Error: Invalid command parameter.";
        }
        
        var trimmedCommand = command.replace(/^\s+|\s+$/g, ''); // Manual trim
        if (trimmedCommand === '') {
            return "Error: Empty command.";
        }
        
        var parts = trimmedCommand.split(" ");
        var action = parts[0].toLowerCase();
        
        // Check for multi-word commands
        if (parts.length >= 2) {
            var twoWordCommand = (parts[0] + " " + parts[1]).toLowerCase();
            if (twoWordCommand === "motion blur" || twoWordCommand === "3d layer" || twoWordCommand === "parent to" || twoWordCommand === "track matte" ||
                twoWordCommand === "select all" || twoWordCommand === "deselect all" || twoWordCommand === "untrack matte" ||
                twoWordCommand === "center anchor" || twoWordCommand === "reset transform" ||
                parts[0].toLowerCase() === "label") {
                action = twoWordCommand;
            }
        }
        
        // Check for three-word commands
        if (parts.length >= 3) {
            var threeWordCommand = (parts[0] + " " + parts[1] + " " + parts[2]).toLowerCase();
            if (threeWordCommand === "fit to comp") {
                action = threeWordCommand;
            }
        }
        
        // Handle layer commands that need parameters
        if (action === "parent to" || action === "track matte" || action === "scale" || action === "opacity") {
            return processLayerCommand(command);
        } else if (action === "select" || action === "unselect" || action === "solo" || action === "unsolo" ||
                   action === "hide" || action === "show" || action === "mute" || action === "unmute" ||
                   action === "audio" || action === "lock" || action === "unlock" || action === "shy" ||
                   action === "unshy" || action === "motion blur" || action === "3d layer" || action === "unparent" ||
                   action === "untrack matte" || action === "deselect all" || action === "select all" ||
                   action === "precompose" || action === "duplicate" || action === "center anchor" ||
                   action === "fit to comp" || action === "reset transform" || action === "delete" ||
                   action === "normal" || action === "multiply" || action === "screen" || action === "overlay" ||
                   action === "add" || action === "difference" || (parts.length >= 2 && parts[0].toLowerCase() === "label") ||
                   (parts.length >= 2 && parts[0].toLowerCase() === "soft" && parts[1].toLowerCase() === "light") ||
                   (parts.length >= 2 && parts[0].toLowerCase() === "hard" && parts[1].toLowerCase() === "light")) {
            return processLayerCommand(command);
        } else if (action === "solid" || action === "text" || action === "light" || 
                   action === "camera" || action === "null" || action === "adjustment") {
            return processCreateCommand(command);
        } else if (action === "list" && parts[1] === "effects") {
            return exportEffectsList();
        } else if (parts.length >= 2 && parts[0].toLowerCase() === "label") {
            // Handle label commands specifically
            return processLayerCommand(command);
        } else {
            // Try to apply as effect
            return applyEffect(command);
        }
        
    } catch (e) {
        return "Error: " + e.toString();
    }
}

// Initialize scanning
scanEffects();