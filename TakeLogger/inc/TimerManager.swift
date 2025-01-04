import SwiftUI

extension ContentView {
        
    var timerColor: Color {
        if !timerOn {
            return .yellow
        } else if timeRemaining < 0 {
            return .red
        } else if timeRemaining < 300 { // 5 Minutes
            return .orange
        } else {
            return .green
        }
    }
    
    public func timerValue(timeInSeconds : Int) -> String {
        let hours = timeInSeconds / 3600
        let minutes = (timeInSeconds % 3600) / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    public func updateCurrentTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        currentTime = formatter.string(from: Date())
    }
    
    public func setTime() {
        dialogueOpen = true
        let alert = NSAlert()
        alert.messageText = "Set timer value (in minutes)"
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        
        let input = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        alert.accessoryView = input
        
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            if let newTimerValue = Int(input.stringValue) {
                timeRemaining = newTimerValue * 60 // Convert to seconds
            }
        }
        dialogueOpen = false
    }
    
    public func resetTimer() {
        timeRemaining = 5400
    }
    
    
    public func toggleTimer() {
        timerOn.toggle()
    }
}
