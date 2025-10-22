// Command Processor v1.1 - Ultra Simple Test Version
// This version only tests basic JSX communication

// Test function - should return immediately
function testJSX() {
    return "JSX v1.1 is working!";
}

// Function to get effects count
function getEffectsCount() {
    return 150; // Hardcoded number for testing
}

// Simple command processor
function processCommand(command) {
    var cmd = command.toLowerCase().trim();
    
    if (cmd === "test") {
        return "Plugin v1.1 is working! JSX communication successful.";
    }
    
    if (cmd === "list effects") {
        return "Effects list not implemented in v1.1 - testing communication only.";
    }
    
    return "Command '" + command + "' received in v1.1. Communication working!";
}
