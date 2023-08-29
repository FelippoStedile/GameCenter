//
//  GameCenterApp.swift
//  GameCenter
//
//  Created by Felippo Stedile on 28/08/23.
//

import SwiftUI

@main
struct GameCenterApp: App {
    
    @StateObject var gameCenterAuth: GameCenterAuthenticationService = GameCenterAuthenticationService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameCenterAuth)
        }
    }
}
