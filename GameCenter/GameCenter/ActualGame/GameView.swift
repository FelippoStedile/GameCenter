//
//  GameView.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 29/08/23.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var actualGame: ActualGame
    var turns: Int = 0
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color(
                    red: (min(actualGame.currentDifference, 0) / -3600),
                    green: (max(actualGame.currentDifference, 0) / 3600),
                    blue: max(0, (360 - abs(actualGame.currentDifference))/360)))
            
            VStack {
                if let totalOpponentAngle = actualGame.opponentGameData.deltaAngle {
                    let score = actualGame.selfScore - totalOpponentAngle//
                    var turns = Int(score/360)
                    let current = score.truncatingRemainder(dividingBy: 360)
                    Text("Placar atual:\nVoltas: \(turns)\n\(current)")//
                }
                else {
                    Text("JOGANDO!")
                }
            }
        }
    }
}

