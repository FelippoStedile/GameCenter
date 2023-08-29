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
        if let deltaAngle = actualGame.opponentGameData.deltaAngle {
            Text("Angulo do seu oponente: \(deltaAngle)")
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        actualGame.sendData()
                        print("enviou")
                    }
                }
        }
        else {
            Text("JOGANDO!")
        }
    }
}

