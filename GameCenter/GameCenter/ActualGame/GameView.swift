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
        Text(String(actualGame.opponentGameData.deltaAngle ?? 500))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    actualGame.sendData()
                }
            }
    }
}

