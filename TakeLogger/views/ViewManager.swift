import SwiftUI

extension AppState {
    public func toggleTakeLogDisplay() {
        showTakeLog.toggle()
    }
    
    public func toggleProducerWindow() {
        if producerWindowOpen {
            if let window = NSApplication.shared.windows.first(where: { $0.title == "Producer Window" }) {
                window.close()
                producerWindowOpen = false
            }
        } else if !producerWindowOpen {
            if let url = URL(string: "takeLogger://producerWindow") {
                NSWorkspace.shared.open(url)
                producerWindowOpen = true
            }
        }
    }
}
