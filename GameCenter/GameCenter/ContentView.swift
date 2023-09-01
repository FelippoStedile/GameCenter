//
//  ContentView.swift
//  GameCenter
//
//  Created by Felippo Stedile on 28/08/23.
//

import SwiftUI
import GameKit

struct ContentView: View {
    
    init(){
        GKAccessPoint.shared.location = .topLeading
        GKAccessPoint.shared.isActive = true
    }
    
    @EnvironmentObject var gameCenterAuth: GameCenterAuthenticationService
    
    var body: some View {
        NavigationStack {
            VStack {
                if let view = gameCenterAuth.currentViewController {
                    ViewControllerRepresenter(vc: view)
                }
                
                switch gameCenterAuth.isAuthenticated {
                case .failed:
                    failedScreen
                case .loading:
                    loadingScreen
                case .succeeded:
                    suceeddedScreen
                }
    
                if gameCenterAuth.isAuthenticated == .succeeded {
                    
                }
            }
        }
    }
    
    var loadingScreen: some View {
        ProgressView()
    }
    
    var failedScreen: some View {
        Text("Failed to login to the Game Center. Unable to play online.")
    }
    
    var suceeddedScreen: some View {
        
        NavigationLink(destination: MultiplayerScreen(realGame: RealGame())) {
            Text("Multiplayer")
                .font(.largeTitle)
                .foregroundColor(Color.primary)
                .colorInvert()
                .padding()
                .background(
                    Color.primary
                )
                .cornerRadius(8)
        }
        .navigationBarBackButtonHidden()
    }
    
}
