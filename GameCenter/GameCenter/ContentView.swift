//
//  ContentView.swift
//  GameCenter
//
//  Created by Felippo Stedile on 28/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var gameCenterAuth: GameCenterAuthenticationService
    
    var body: some View {
        NavigationStack {
            VStack {
                if let view = gameCenterAuth.currentViewController {
                    ViewControllerRepresenter(vc: view)
                }
                
                Text(gameCenterAuth.isAuthenticated.textDescription)
    
                if gameCenterAuth.isAuthenticated == .succeeded {
                    NavigationLink(destination: MultiplayerScreen(realGame: RealGame())) {
                        Text("Multiplayer")
                            .font(.largeTitle)
                            .padding()
                            .background(
                                Color.red
                            )
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
