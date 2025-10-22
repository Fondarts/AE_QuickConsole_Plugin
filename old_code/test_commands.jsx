#target aftereffects
// Test script to verify command console functionality

(function() {
    try {
        // Test if the processCommand function is available
        if (typeof processCommand === 'undefined') {
            alert("Error: processCommand function not found. Make sure the plugin is loaded correctly.");
            return;
        }
        
        // Test basic command
        var result = processCommand("null");
        alert("Test result: " + result);
        
        // Test with selected layers
        var comp = app.project.activeItem;
        if (comp && comp instanceof CompItem && comp.selectedLayers.length > 0) {
            var result2 = processCommand("mute");
            alert("Mute test result: " + result2);
        } else {
            alert("No layers selected for layer command test");
        }
        
    } catch (error) {
        alert("Test error: " + error.toString());
    }
})();
