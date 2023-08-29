//
//  MultiplayerScreen.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 29/08/23.
//

import SwiftUI

struct MultiplayerScreen: View {
    
    @StateObject var realGame: RealGame
    
    var body: some View {
        if let vc = realGame.vc {
            ViewControllerRepresenter(vc: vc)
        } else {
            switch realGame.gameState {
            case .canceled:
                canceledScreen
            case .playing:
                playingScreen
            default:
                Text("outra coisa \(realGame.gameState.hashValue)")
            }
        }
    }
    
    var canceledScreen: some View {
        VStack {
            Text("Você cancelou o Game Center")
        }
    }
    
    var playingScreen: some View {
        Text("Actual Game UI here")
    }
}
