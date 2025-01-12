import Foundation
import SwiftUI

struct MainWindow: View {
    @EnvironmentObject var app: AppState
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack {
            if app.showTakeLog == true {
                VStack {
                    ScrollViewReader { proxy in
                        List {
                            if app.takeLog.isEmpty {
                                Text("No entries yet")
                                    .foregroundColor(.white)
                                    .padding()
                            } else {
                                ForEach(app.takeLog.indices, id: \.self) { index in
                                    let log = app.takeLog[index]
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("\(log.take)")
                                                .font(.system(size: 40, weight: .bold))
                                        }
                                        .background(app.takeNumber == log.take ? Color.blue.opacity(0.1) : Color.clear)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 7.5)
                                                .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, dash: [5]))
                                                .padding(-2)
                                                .opacity(app.takeNumber == log.take ? 1 : 0)
                                        )
                                        .padding()
                                        Text("\(log.fs) FSs")
                                            .font(.system(size: 35))
                                            .padding()
                                        Text(log.notes)
                                            .font(.system(size: 35))
                                    }
                                    .id(log.take) // For scrolling
                                    .onTapGesture(count: 1) { app.takeNumber = log.take }
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .onChange(of: app.scrollToTake) { _ in
                            withAnimation {
                                proxy.scrollTo(app.scrollToTake, anchor: .center)
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
                            .onTapGesture { app.previousTake() }
                            .foregroundColor(.gray)
                            .padding()
                        
                        Text(String(app.takeNumber))
                            .font(.system(size: 125, weight: .bold))
                            .foregroundColor(.blue)
                            .padding()
                            .onTapGesture(count: 1) { app.setTakeNumber() }
                        
                        Text(">")
                            .font(.system(size: 45, weight: .bold))
                            .onTapGesture { app.nextTake() }
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
                                app.timerOn = false
                                app.timeRemaining = 5400
                            }
                            .foregroundColor(.gray)
                            .padding()
                        
                        Text(app.timerValue(timeInSeconds: app.timeRemaining))
                            .font(.system(size: 125, weight: .bold))
                            .foregroundColor(app.timerColor)
                            .padding()
                            .onReceive(timer) { _ in
                                if app.timerOn == true {
                                    app.timeRemaining -= 1
                                }
                            }
                            .onTapGesture(count: 1) { app.setTime() }
                        
                        Text("Toggle")
                            .font(.system(size: 20, weight: .regular))
                            .onTapGesture { app.toggleTimer() }
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("Current Time " )
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                    
                    Text(app.currentTime)
                        .font(.system(size: 125, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .onReceive(timer) { _ in app.updateCurrentTime() }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color.black)
        .onAppear {
            app.logInitialTake()
            app.updateCurrentTime()
            setKeyCommands()
        }
    }

    public func toggleTakeLogDisplay() {
        app.showTakeLog.toggle()
    }
    
}
