import Foundation
import SwiftUI
import Combine
import UniformTypeIdentifiers

extension Color {
    static let orange = Color(red: 1.0, green: 0.4, blue: 0.0)
}

@main
struct TakeLoggerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var takeNumber: Int = 1
    @State private var falseStarts: Int = 0
    @State private var userNote: String = ""
    @State private var takeLog: [(take: Int, fs: Int, notes: String)] = []
    @State private var timeRemaining: Int = 5400
    @State private var timerOn: Bool = false
    @State private var currentTime: String = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
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

    var body: some View {
        HStack {
            VStack {
                HStack(alignment: .center) {
                    Button(action: toggleTimer) {
                        Image(systemName: "timer")
                    }.help("Toggle Timer On/Off")
                    .padding()
                    Button(action: addFS) {
                        Image(systemName: "plus")
                    }.help("Add False Start")
                    Button(action: delFS) {
                        Image(systemName: "minus")
                    }.help("Remove False Start")
                    .padding()
                    Button(action: previousTake) {
                        Image(systemName: "lessthan")
                    }.help("Go to Previous Take")
                    Button(action: nextTake) {
                        Image(systemName: "greaterthan")
                    }.help("Go to Next Take")
                    Button(action: presentNotesDialog) {
                        Image(systemName: "note.text")
                    }.help("Modify Take Notes")
                    .padding()
                    Button(action: exportToCSV) {
                        Image(systemName: "square.and.arrow.up")
                    }.help("Export to CSV")
                    Button(action: importFromCSV) {
                        Image(systemName: "square.and.arrow.down")
                    }.help("Import CSV")
                }
                List {
                    if takeLog.isEmpty {
                        Text("No entries yet")
                            .foregroundColor(.white)
                            .padding()
                    } else {
                        ForEach(takeLog.indices, id: \.self) { index in
                            let log = takeLog[index]
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(log.take)")
                                        .font(.system(size: 40, weight: .bold))
                                }
                                .background(takeNumber == log.take ? Color.blue.opacity(0.1) : Color.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 7.5)
                                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, dash: [5]))
                                        .padding(-2)
                                        .opacity(takeNumber == log.take ? 1 : 0)
                                )
                                .padding()
                                Text("\(log.fs) FSs")
                                    .font(.system(size: 35))
                                    .padding()
                                Text(log.notes)
                                    .font(.system(size: 35))
                            }.onTapGesture(count: 1) { takeNumber = log.take }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                
            }
            
            Spacer()
            
            VStack {
                VStack {
                    Text("Take")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                    
                    Text(String(takeNumber))
                        .font(.system(size: 150, weight: .bold))
                        .foregroundColor(.blue)
                        .padding()
                        .onTapGesture(count: 2) { presentTakeDialog() }
                }
                
                Spacer()
                
                VStack {
                    Text("Time Remaining")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                    
                    Text(timerValue(timeInSeconds: timeRemaining))
                        .font(.system(size: 150, weight: .bold))
                        .foregroundColor(timerColor)
                        .padding()
                        .onReceive(timer) { _ in
                            if timerOn == true {
                                timeRemaining -= 1
                            }
                            
                        }
                        .onTapGesture(count: 2) { presentTimerDialog() }
                }
                
                Spacer()
                
                VStack {
                    Text("Current Time " )
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                    
                    Text(currentTime)
                        .font(.system(size: 150, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .onReceive(timer) { _ in updateCurrentTime() }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color.black)
        .onAppear {
            logInitialTake()
            updateCurrentTime()
            setKeyCommands()
        }
    }
    
    private func logInitialTake() {
        takeLog.append((take: takeNumber, fs: falseStarts, notes: userNote))
    }
    
    private func addLogEntry() {
        takeLog.append((take: takeNumber, fs: falseStarts, notes: ""))
        userNote = ""
        falseStarts = 0
    }
    
    private func addFS() {
        if let index = takeLog.firstIndex(where: { $0.take == takeNumber }) {
            takeLog[index].fs += 1
        }
    }
    
    private func delFS() {
        if let index = takeLog.firstIndex(where: { $0.take == takeNumber }) {
            takeLog[index].fs = max(0, takeLog[index].fs - 1)
        }
    }
    
    private func timerValue(timeInSeconds : Int) -> String {
        let hours = timeInSeconds / 3600
        let minutes = (timeInSeconds % 3600) / 60
        let seconds = timeInSeconds % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    private func updateCurrentTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        currentTime = formatter.string(from: Date())
    }
    
    private func presentTakeDialog() {
        let alert = NSAlert()
        alert.messageText = "Set take number"
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        
        let input = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        //input.stringValue = "\(takeNumber)"
        alert.accessoryView = input
        
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            if let newTakeNumber = Int(input.stringValue) {
                takeNumber = newTakeNumber
            }
        }
    }
    
    private func presentTimerDialog() {
        let alert = NSAlert()
        alert.messageText = "Set timer value (in minutes)"
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        
        let input = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        //input.stringValue = "\(timeRemaining)"
        alert.accessoryView = input
        
        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            if let newTimerValue = Int(input.stringValue) {
                timeRemaining = newTimerValue * 60 // Convert to seconds
            }
        }
    }
    
    private func presentNotesDialog() {
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
    }
    
    private func toggleTimer() {
        timerOn.toggle()
    }
    
    private func nextTake() {
        takeNumber += 1
        if !takeLog.contains(where: { $0.take == takeNumber }) {
            addLogEntry()
        }
    }
    
    private func previousTake() {
        takeNumber = max(1, takeNumber - 1)
    }
    
    private func setKeyCommands() {
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.modifierFlags.contains(.command) &&
                event.keyCode == 0x05 { // Command+G (*G*o)
                toggleTimer()
                return nil
            } else if event.modifierFlags.contains(.command) &&
                        event.keyCode == 0x24 { // Command+Return
                nextTake()
                return nil
            } else if event.modifierFlags.contains(.command) &&
                        event.keyCode == 0x33 { // Command+Backspace
                previousTake()
                return nil
            } else if event.modifierFlags.contains(.command) &&
                        event.keyCode == 0x11 { // Command+T (*T*ake number)
                presentTakeDialog()
                return nil
            } else if event.modifierFlags.contains(.command) &&
                        !event.modifierFlags.contains(.shift) &&
                        event.keyCode == 0x02 { // Command+D (*D*uration)
                presentTimerDialog()
                return nil
            } else if event.modifierFlags.contains(.command) &&
                        event.modifierFlags.contains(.shift) &&
                        event.keyCode == 0x02 { // Command+Shift+D (*D*uration)
                timeRemaining = 5400
                return nil
            } else if event.modifierFlags.contains(.command) &&
                        !event.modifierFlags.contains(.shift) &&
                        event.keyCode == 0x03 { // Command+F (Add *F*alse start)
                addFS()
                return nil
            } else if event.modifierFlags.contains(.command) &&
                        event.modifierFlags.contains(.shift) &&
                        event.keyCode == 0x03 { // Command+Shift+F (Delete *F*alse start)
                delFS()
                return nil
            } else if event.modifierFlags.contains(.command) &&
                        event.keyCode == 0x2D { // Command+N (*N*otes)
                presentNotesDialog()
                return nil
            } else if event.modifierFlags.contains(.command) &&
                        event.keyCode == 0x01 { // Command+S (*S*ave)
                exportToCSV()
                return nil
            } else if event.modifierFlags.contains(.command) &&
                        event.keyCode == 0x1F { // Command+O (*O*pen)
                importFromCSV()
                return nil
            }
            return event
        }
    }
    
    private func exportToCSV() {
        let dialog = NSSavePanel()
        dialog.title = "Export Take Log"
        dialog.allowedContentTypes = [UTType.commaSeparatedText]
        
        if dialog.runModal() == .OK {
            if let path = dialog.url {
                var csvText = "Take,FSs,Notes\n"
                for log in takeLog {
                    let line = "\(log.take),\(log.fs),\"\(log.notes)\"\n"
                    csvText.append(line)
                }
                
                do {
                    try csvText.write(to: path, atomically: true, encoding: .utf8)
                } catch {
                    print("Failed to create file: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func importFromCSV() {
        let dialog = NSOpenPanel()
        dialog.title = "Import Take Log"
        dialog.allowedContentTypes = [UTType.commaSeparatedText]
        
        if dialog.runModal() == .OK {
            if let path = dialog.url {
                do {
                    let csvData = try String(contentsOf: path, encoding: .utf8)
                    let lines = csvData.components(separatedBy: .newlines)
                    
                    var importedLog: [(take: Int, fs: Int, notes: String)] = []
                    
                    for line in lines.dropFirst() { // Skip header line
                        let fields = line.components(separatedBy: ",")
                        if fields.count == 3, let take = Int(fields[0]), let fs = Int(fields[1]) {
                            let notes = fields[2].replacingOccurrences(of: "\"", with: "")
                            importedLog.append((take: take, fs: fs, notes: notes))
                        }
                    }
                    
                    takeLog = importedLog
                } catch {
                    print("Error reading CSV file: \(error.localizedDescription)")
                }
            }
        }
    }
}
