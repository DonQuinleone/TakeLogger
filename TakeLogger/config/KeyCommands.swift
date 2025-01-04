import AppKit
import SwiftUI

extension ContentView {
    public func setKeyCommands() {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            
            // Do nothing when a dialogue is open
            if dialogueOpen { return event }
            
            // Take navigation
            if      event.keyCode       == Keycode.downArrow  { previousTake();           return nil }
            else if event.keyCode       == Keycode.leftArrow  { previousTake();           return nil }
            else if event.keyCode       == Keycode.upArrow    { nextTake();               return nil }
            else if event.keyCode       == Keycode.rightArrow { nextTake();               return nil }
            else if event.keyCode       == Keycode.returnKey  { newTake();                return nil }
            else if event.keyCode       == Keycode.t          { setTakeNumber();          return nil }
            
            // Take content
            else if !event.modifierFlags.contains(.shift) &&
                        event.keyCode   == Keycode.f          { addFS();                  return nil }
            else if event.keyCode       == Keycode.g          { delFS();                  return nil }
            else if event.modifierFlags.contains(.shift) &&
                        event.keyCode   == Keycode.f/*+SHIFT*/{ delFS();                  return nil }
            else if event.keyCode       == Keycode.n          { addNotes();               return nil }
            
            // Timer
            else if event.keyCode       == Keycode.space      { toggleTimer();            return nil }
            else if event.keyCode       == Keycode.d          { setTime();                return nil }
            else if event.keyCode       == Keycode.r          { resetTimer();             return nil }
            
            // Other
            else if event.keyCode       == Keycode.l          { toggleTakeLogDisplay();   return nil }
            
            // CSV Export/Import
            else if event.modifierFlags.contains(.command) &&
                        event.keyCode   == Keycode.s/* +CMD */{ exportToCSV();            return nil }
            else if event.modifierFlags.contains(.command) &&
                        event.keyCode   == Keycode.o/* +CMD */{importFromCSV();           return nil }
            
            return event
        }
    }
}
    
