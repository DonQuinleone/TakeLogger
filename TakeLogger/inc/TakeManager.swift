import SwiftUI

extension ContentView {
    
    // Take log setup
    
    public func logInitialTake() {
        takeLog.append((take: takeNumber, fs: falseStarts, notes: userNote))
    }
    
    public func addLogEntry() {
        takeLog.append((take: takeNumber, fs: falseStarts, notes: ""))
        userNote = ""
        falseStarts = 0
    }
    
    // Take navigation
    
    public func previousTake() {
        takeNumber = max(1, takeNumber - 1)
        scrollToTake = takeNumber
    }
    
    public func nextTake() {
        takeNumber += 1
        if !takeLog.contains(where: { $0.take == takeNumber }) {
            addLogEntry()
        }
        takeLog.sort { $0.take > $1.take }
        scrollToTake = takeNumber
    }

    public func newTake() {
        takeNumber = latestTakeNumber()
        nextTake()
    }
    
    // Dialogues
    
    public func setTakeNumber() {
        dialogueOpen = true
        let alert = NSAlert()
        alert.messageText = "Set take number"
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        
        let input = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        alert.accessoryView = input
        
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            if let newTakeNumber = Int(input.stringValue) {
                takeNumber = min(newTakeNumber, latestTakeNumber())
                scrollToTake = takeNumber
            }
        }
        dialogueOpen = false
    }
    
    // Take content
    
    public func addFS() {
        if let index = takeLog.firstIndex(where: { $0.take == takeNumber }) {
            takeLog[index].fs += 1
        }
    }
    
    public func delFS() {
        if let index = takeLog.firstIndex(where: { $0.take == takeNumber }) {
            takeLog[index].fs = max(0, takeLog[index].fs - 1)
        }
    }
    
    public func addNotes() {
        dialogueOpen = true
        let alert = NSAlert()
        alert.messageText = "Add notes for take \(takeNumber)"
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        
        let input = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        input.stringValue = "\(userNote)"
        alert.accessoryView = input
        
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            userNote = input.stringValue
            if let index = takeLog.firstIndex(where: { $0.take == takeNumber }) {
                takeLog[index].notes = userNote
            }
        }
        dialogueOpen = false
    }
    
    // Helper functions
    
    public func latestTakeNumber() -> Int {
        return takeLog.max(by: { $0.take < $1.take })?.take ?? 0
    }
    
}
