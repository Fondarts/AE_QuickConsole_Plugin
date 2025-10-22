// Simple version for testing
(function() {
    'use strict';
    
    let csInterface = new CSInterface();
    
    function updateStatus(message) {
        const statusText = document.getElementById('status-text');
        if (statusText) {
            statusText.textContent = message;
        }
    }
    
    function executeCommand(command) {
        if (!command || !command.trim()) {
            updateStatus("No command entered");
            return;
        }
        
        updateStatus("Executing: " + command);
        
        // Simple command execution
        csInterface.evalScript('executeCommand("' + command + '")', function(result) {
            if (result === 'EvalScript error.') {
                updateStatus("Error executing command");
            } else {
                updateStatus("Result: " + result);
            }
        });
    }
    
    // Setup button events
    document.addEventListener('DOMContentLoaded', function() {
        const buttons = document.querySelectorAll('.action-btn, .create-btn, .blending-btn');
        buttons.forEach(btn => {
            btn.addEventListener('click', function() {
                const command = this.getAttribute('data-command');
                if (command) {
                    executeCommand(command);
                }
            });
        });
        
        // Input field
        const input = document.getElementById('command-input');
        if (input) {
            input.addEventListener('keydown', function(e) {
                if (e.key === 'Enter') {
                    executeCommand(this.value);
                    this.value = '';
                }
            });
        }
        
        updateStatus("Ready - Click buttons or type commands");
    });
    
})();

