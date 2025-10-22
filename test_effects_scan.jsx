#target aftereffects
// Test script to check effects scanning

(function() {
    try {
        alert("Testing effects scan...");
        
        // Check if app.effects exists
        if (!app.effects) {
            alert("Error: app.effects is not available");
            return;
        }
        
        alert("app.effects.length = " + app.effects.length);
        
        // Try to access first few effects
        var effects = [];
        var maxCheck = Math.min(10, app.effects.length);
        
        for (var i = 1; i <= maxCheck; i++) {
            try {
                var effect = app.effects[i];
                if (effect && effect.name) {
                    effects.push(effect.name);
                    $.writeln("Effect " + i + ": " + effect.name);
                }
            } catch (e) {
                $.writeln("Error accessing effect " + i + ": " + e.toString());
            }
        }
        
        alert("Found " + effects.length + " effects. Check Info panel for details.");
        
        if (effects.length > 0) {
            alert("First few effects: " + effects.slice(0, 5).join(", "));
        }
        
    } catch (error) {
        alert("Test error: " + error.toString());
    }
})();
