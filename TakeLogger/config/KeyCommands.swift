import AppKit
import SwiftUI

extension MainWindow {
    public func setKeyCommands() {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            
            // Do nothing when a dialogue is open
            if app.dialogueOpen { return event }
            
            // Take navigation
            if      event.keyCode       == Keycode.downArrow  { app.previousTake();           return event }
            else if event.keyCode       == Keycode.leftArrow  { app.previousTake();           return event }
            else if event.keyCode       == Keycode.upArrow    { app.nextTake();               return event }
            else if event.keyCode       == Keycode.rightArrow { app.nextTake();               return event }
            else if event.keyCode       == Keycode.returnKey  { app.newTake();                return event }
            else if event.keyCode       == Keycode.t          { app.setTakeNumber();          return event }
            
            // Take content
            else if !event.modifierFlags.contains(.shift) &&
                        event.keyCode   == Keycode.f          { app.addFS();                  return event }
            else if event.keyCode       == Keycode.g          { app.delFS();                  return event }
            else if event.modifierFlags.contains(.shift) &&
                        event.keyCode   == Keycode.f/*+SHIFT*/{ app.delFS();                  return event }
            else if event.keyCode       == Keycode.n          { app.addNotes();               return event }
            
            // Timer
            else if event.keyCode       == Keycode.space      { app.toggleTimer();            return event }
            else if event.keyCode       == Keycode.d          { app.setTime();                return event }
            else if event.keyCode       == Keycode.r          { app.resetTimer();             return event }
            
            // Other
            else if event.keyCode       == Keycode.l          { toggleTakeLogDisplay();       return event }
            else if event.keyCode       == Keycode.p          {
                if let url = URL(string: "takeLogger://producerWindow") {
                    NSWorkspace.shared.open(url)
                }; (); return event }
            
            // CSV Export/Import
            else if event.modifierFlags.contains(.command) &&
                        event.keyCode   == Keycode.s/* +CMD */{ app.exportToCSV();            return event }
            else if event.modifierFlags.contains(.command) &&
                        event.keyCode   == Keycode.o/* +CMD */{ app.importFromCSV();          return event }
            
            return event
        }
    }
}
    
