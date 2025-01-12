import Foundation
import SwiftUI

struct ProducerWindow: View {
    @EnvironmentObject var app: AppState

    var body: some View {
        VStack {
            VStack {
                Text("Take")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                Text(String(app.takeNumber))
                    .font(.system(size: 125, weight: .bold))
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            VStack {
                Text("Time Remaining")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                
                Text(app.timerValue(timeInSeconds: app.timeRemaining))
                    .font(.system(size: 125, weight: .bold))
                    .foregroundColor(app.timerColor)
                    .padding()
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
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }
    
}
