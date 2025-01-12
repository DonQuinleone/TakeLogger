import Foundation
import SwiftUI

struct ProducerWindow: View {
    @EnvironmentObject var app: AppState
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
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
        .background(Color.black)
    }

    public func toggleTakeLogDisplay() {
        app.showTakeLog.toggle()
    }
    
}
