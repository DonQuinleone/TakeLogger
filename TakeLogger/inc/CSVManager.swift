import SwiftUI
import UniformTypeIdentifiers

extension AppState {
    
    public func exportToCSV() {
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
    
    public func importFromCSV() {
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
                    
                    takeLog = importedLog.sorted { $0.take > $1.take }
                    scrollToTake = takeLog.first?.take
                } catch {
                    print("Error reading CSV file: \(error.localizedDescription)")
                }
            }
        }
    }
}
