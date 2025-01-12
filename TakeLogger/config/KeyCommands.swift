import AppKit
import SwiftUI

extension MainWindow {
    public func setKeyCommands() {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            
            // Do nothing when a dialogue is open
            if app.dialogueOpen { return event }
            
            // Take navigation
            if      event.keyCode       == Keycode.downArrow  { app.previousTake();                 }
            else if event.keyCode       == Keycode.leftArrow  { app.previousTake();                 }
            else if event.keyCode       == Keycode.upArrow    { app.nextTake();                     }
            else if event.keyCode       == Keycode.rightArrow { app.nextTake();                     }
            else if event.keyCode       == Keycode.returnKey  { app.newTake();                      }
            else if event.keyCode       == Keycode.t          { app.setTakeNumber();                }
            
            // Take content
            else if !event.modifierFlags.contains(.shift) &&
                        event.keyCode   == Keycode.f          { app.addFS();                        }
            else if event.keyCode       == Keycode.g          { app.delFS();                        }
            else if event.modifierFlags.contains(.shift) &&
                        event.keyCode   == Keycode.f/*+SHIFT*/{ app.delFS();                        }
            else if event.keyCode       == Keycode.n          { app.addNotes();                     }
            
            // Timer
            else if event.keyCode       == Keycode.space      { app.toggleTimer();                  }
            else if event.keyCode       == Keycode.d          { app.setTime();                      }
            else if event.keyCode       == Keycode.r          { app.resetTimer();                   }
            
            // View
            else if event.keyCode       == Keycode.l          { app.toggleTakeLogDisplay();         }
            else if event.keyCode       == Keycode.p          { app.toggleProducerWindow();         }
            
            // CSV Export/Import
            else if event.modifierFlags.contains(.command) &&
                        event.keyCode   == Keycode.s/* +CMD */{ app.exportToCSV();                  }
            else if event.modifierFlags.contains(.command) &&
                        event.keyCode   == Keycode.o/* +CMD */{ app.importFromCSV();                }
            
            // OS
            else if event.modifierFlags.contains(.command) &&
                        event.keyCode   == Keycode.m/* +CMD */{ NSApplication.shared.miniaturizeAll(self) }
            else if event.modifierFlags.contains(.command) &&
                        event.keyCode   == Keycode.q/* +CMD */{ NSApplication.shared.terminate(nil) }
            
            return nil
        }
    }
}
    
