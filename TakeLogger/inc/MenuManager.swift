import SwiftUI

public struct MenuManager: Commands {
    var app: AppState

    public var body: some Commands {
        
        // TakeLogger Menu
        CommandGroup(replacing: CommandGroupPlacement.systemServices)   { EmptyView() }
        CommandGroup(replacing: CommandGroupPlacement.appVisibility)    { EmptyView() }
        
        // File Menu
        CommandGroup(replacing: CommandGroupPlacement.newItem) {
            Button("Save as CSV"){app.exportToCSV()}.keyboardShortcut("s", modifiers: [.command])
            Button("Open CSV"){app.importFromCSV()}.keyboardShortcut("o", modifiers: [.command])
        }
        
        CommandMenu("Takes") {
            Button("Previous Take"){app.previousTake()}.keyboardShortcut(.leftArrow, modifiers: [])
            Button("Next Take"){app.nextTake()}.keyboardShortcut(.rightArrow, modifiers: [])
            Button("New Take"){app.newTake()}.keyboardShortcut(.return, modifiers: [])
            Divider()
            Button("Set Take Number"){app.setTakeNumber()}.keyboardShortcut("t", modifiers: [])
            Divider()
            Button("Add False Start"){app.addFS()}.keyboardShortcut("f", modifiers: [])
            Button("Remove False Start"){app.delFS()}.keyboardShortcut("f", modifiers: [.shift])
            Divider()
            Button("Set Notes"){app.addNotes()}.keyboardShortcut("n", modifiers: [])
        }
        
        CommandMenu("Timer") {
            Button("Toggle Timer"){app.toggleTimer()}.keyboardShortcut(.space, modifiers: [])
            Button("Set Remaining Duration"){app.setTime()}.keyboardShortcut("d", modifiers: [])
            Button("Reset to 90 Minutes"){app.resetTimer()}.keyboardShortcut("r", modifiers: [])
        }
        
        // Edit Menu
        CommandGroup(replacing: CommandGroupPlacement.undoRedo)         { EmptyView() }
        CommandGroup(replacing: CommandGroupPlacement.pasteboard)       { EmptyView() }
        CommandGroup(replacing: CommandGroupPlacement.textEditing)      { EmptyView() }
        
        // View Menu
        CommandGroup(replacing: CommandGroupPlacement.sidebar) {
            Button("Toggle Take Log"){app.toggleTakeLogDisplay()}.keyboardShortcut("l", modifiers: [])
            Button("Toggle Producer Window"){app.toggleProducerWindow()}.keyboardShortcut("p", modifiers: [])
        }
        
        // Help Menu
        CommandGroup(replacing: CommandGroupPlacement.help) {
            Button("View Repository & Documentation") {
                NSWorkspace.shared.open(URL(string: "https://github.com/DonQuinleone/TakeLogger")!)
            }
        }
    }
}
