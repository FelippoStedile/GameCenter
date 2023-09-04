//
//  MultiplayerScreen.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 29/08/23.
//

import SwiftUI

struct MultiplayerScreen: View {
    
    @StateObject var realGame: RealGame
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Group {
            if let vc = realGame.vc {
                ViewControllerRepresenter(vc: vc)
            } else if let view = realGame.gameView {
                view
            } else {
                switch realGame.gameState {
                case .canceled:
                    canceledScreen
                    Button("Go Back", action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                case .playing:
                    playingScreen
                default:
                    Text("outra coisa \(realGame.gameState.hashValue)")
                    Button("Go Back", action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                }
            }
        }
        .navigationBarBackButtonHidden()
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
