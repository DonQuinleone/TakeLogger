import Foundation
import SwiftUI

@main
struct TakeLoggerApp: App {    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    
    @State public var takeNumber:       Int      = 1
    @State public var falseStarts:      Int      = 0
    @State public var userNote:         String   = ""
    @State public var takeLog:          [(take: Int, fs: Int, notes: String)] = []
    @State public var timeRemaining:    Int      = 5400
    @State public var timerOn:          Bool     = false
    @State public var currentTime:      String   = ""
    @State public var scrollToTake:     Int?     = nil
    @State public var showTakeLog:      Bool     = true
    @State public var dialogueOpen:     Bool     = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack {
            if showTakeLog == true {
                VStack {
                    ScrollViewReader { proxy in
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
                                    }
                                    .id(log.take) // For scrolling
                                    .onTapGesture(count: 1) { takeNumber = log.take }
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .onChange(of: scrollToTake) { _ in
                            withAnimation {
                                proxy.scrollTo(scrollToTake, anchor: .center)
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            VStack {
                VStack {
                    Text("Take")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("<")
                            .font(.system(size: 45, weight: .bold))
                            .onTapGesture { previousTake() }
                            .foregroundColor(.gray)
                            .padding()
                        
                        Text(String(takeNumber))
                            .font(.system(size: 125, weight: .bold))
                            .foregroundColor(.blue)
                            .padding()
                            .onTapGesture(count: 1) { setTakeNumber() }
                        
                        Text(">")
                            .font(.system(size: 45, weight: .bold))
                            .onTapGesture { nextTake() }
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("Time Remaining")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                    
                    HStack {
                        Text("Reset")
                            .font(.system(size: 20, weight: .regular))
                            .onTapGesture {
                                timerOn = false
                                timeRemaining = 5400
                            }
                            .foregroundColor(.gray)
                            .padding()
                        
                        Text(timerValue(timeInSeconds: timeRemaining))
                            .font(.system(size: 125, weight: .bold))
                            .foregroundColor(timerColor)
                            .padding()
                            .onReceive(timer) { _ in
                                if timerOn == true {
                                    timeRemaining -= 1
                                }
                            }
                            .onTapGesture(count: 1) { setTime() }
                        
                        Text("Toggle")
                            .font(.system(size: 20, weight: .regular))
                            .onTapGesture { toggleTimer() }
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("Current Time " )
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                    
                    Text(currentTime)
                        .font(.system(size: 125, weight: .bold))
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

    public func toggleTakeLogDisplay() {
        showTakeLog.toggle()
    }
    
}
