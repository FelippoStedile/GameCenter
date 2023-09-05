//
//  GameView.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 29/08/23.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var actualGame: ActualGame
    var turns: Int = 0
    
    var body: some View {
        ZStack {
            if let outcome = actualGame.currentGameOutcome {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(.purple)
                
                VStack{
                    Text(outcome == .win ? "YOU WIN!" : "YOU LOSE!")
                    
                    Button("Go Back", action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                }
            } else {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(Color(
                        red: (min(actualGame.currentDifference, 0) / -3600),
                        green: (max(actualGame.currentDifference, 0) / 3600),
                        blue: max(0, (360 - abs(actualGame.currentDifference))/360)))
            }
            HStack{
                Button("Mute") {
                    actualGame.voiceChat!.volume = 0
                }
                Button("Unmute") {
                    actualGame.voiceChat!.volume = 0.5
                }
            }
//            VStack {
//                if let totalOpponentAngle = actualGame.opponentGameData.deltaAngle {
//                    let score = actualGame.selfScore - totalOpponentAngle//
//                    var turns = Int(score/360)
//                    let current = score.truncatingRemainder(dividingBy: 360)
//                    Text("Placar atual:\nVoltas: \(turns)\n\(current)")//
//                }
//                else {
//                    Text("JOGANDO!")
//                }
//            }
        }
    }
}

