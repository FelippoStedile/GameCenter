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
        VStack {
            if let view = gameCenterAuth.currentViewController {
                ViewControllerRepresenter(vc: view)
            }
                
            Text(gameCenterAuth.isAuthenticated.textDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
