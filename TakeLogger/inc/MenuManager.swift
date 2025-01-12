import SwiftUI

public struct MenuManager: Commands {
    public var body: some Commands {
        
        // TakeLogger Menu
        CommandGroup(replacing: CommandGroupPlacement.systemServices)   { EmptyView() }
        CommandGroup(replacing: CommandGroupPlacement.appVisibility)    { EmptyView() }
        
        // File Menu
        CommandGroup(replacing: CommandGroupPlacement.newItem) {
            Button("Save as CSV"){}.keyboardShortcut("s", modifiers: [.command])
            Button("Open CSV"){}.keyboardShortcut("o", modifiers: [.command])
        }
        
        CommandMenu("Takes") {
            Button("Previous Take"){}.keyboardShortcut(.leftArrow, modifiers: [])
            Button("Next Take"){}.keyboardShortcut(.rightArrow, modifiers: [])
            Button("New Take"){}.keyboardShortcut(.return, modifiers: [])
            Divider()
            Button("Set Take Number"){}.keyboardShortcut("t", modifiers: [])
            Divider()
            Button("Add False Start"){}.keyboardShortcut("f", modifiers: [])
            Button("Remove False Start"){}.keyboardShortcut("f", modifiers: [.shift])
            Divider()
            Button("Set Notes"){}.keyboardShortcut("n", modifiers: [])
        }
        
        CommandMenu("Timer") {
            Button("Toggle Timer"){}.keyboardShortcut(.space, modifiers: [])
            Button("Set Remaining Duration"){}.keyboardShortcut("d", modifiers: [])
            Button("Reset to 90 Minutes"){}.keyboardShortcut("r", modifiers: [])
        }
        
        // Edit Menu
        CommandGroup(replacing: CommandGroupPlacement.undoRedo)         { EmptyView() }
        CommandGroup(replacing: CommandGroupPlacement.pasteboard)       { EmptyView() }
        CommandGroup(replacing: CommandGroupPlacement.textEditing)      { EmptyView() }
        
        // View Menu
        CommandGroup(replacing: CommandGroupPlacement.sidebar) {
            Button("Toggle Take Log"){}.keyboardShortcut("l", modifiers: [])
            Button("Toggle Producer Window"){}.keyboardShortcut("p", modifiers: [])
        }
        
        // Help Menu
        CommandGroup(replacing: CommandGroupPlacement.help) {
            Button("View Repository & Documentation") {
                NSWorkspace.shared.open(URL(string: "https://github.com/DonQuinleone/TakeLogger")!)
            }
        }
    }
}
