//
//  GameView.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 29/08/23.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var actualGame: ActualGame
    
    var body: some View {
        if let totalOpponentAngle = actualGame.opponentGameData.deltaAngle {
            Text("Placar atual: \(actualGame.selfScore + (Double(actualGame.spinService.numberOfSpins) * 360) - totalOpponentAngle)")
        }
        else {
            Text("JOGANDO!")
        }
        Text("SELF SCORE: \(actualGame.selfScore)")
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    actualGame.sendData()
                    print("enviou")
                }
            }
    }
}

