import SwiftUI

extension MainWindow {
    public func toggleTakeLogDisplay() {
        app.showTakeLog.toggle()
    }
    
    public func toggleProducerWindow() {
        if app.producerWindowOpen {
            if let window = NSApplication.shared.windows.first(where: { $0.title == "Producer Window" }) {
                window.close()
                app.producerWindowOpen = false
            }
        } else if !app.producerWindowOpen {
            if let url = URL(string: "takeLogger://producerWindow") {
                NSWorkspace.shared.open(url)
                app.producerWindowOpen = true
            }
        }
    }
}
