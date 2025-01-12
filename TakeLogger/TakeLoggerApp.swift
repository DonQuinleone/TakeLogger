import Foundation
import SwiftUI

@main
struct TakeLoggerApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup("TakeLogger") {
            MainWindow()
                .environmentObject(appState)
        }
        WindowGroup("Producer Window") {
            ProducerWindow()
                .environmentObject(appState)
        }
        .handlesExternalEvents(matching: Set(arrayLiteral: "producerWindow"))
    }
}

class AppState: ObservableObject {
    @Published public var takeNumber: Int = 1
    @Published public var falseStarts: Int = 0
    @Published public var userNote: String = ""
    @Published public var takeLog: [(take: Int, fs: Int, notes: String)] = []
    @Published public var timeRemaining: Int = 5400
    @Published public var timerOn: Bool = false
    @Published public var currentTime: String = ""
    @Published public var scrollToTake: Int? = nil
    @Published public var showTakeLog: Bool = true
    @Published public var dialogueOpen: Bool = false
}
