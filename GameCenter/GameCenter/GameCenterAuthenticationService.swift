//
//  GameCenterAuthenticationService.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 28/08/23.
//

import Foundation
import GameKit

final class GameCenterAuthenticationService: ObservableObject {
    var currentViewController: UIViewController?
    
    @Published var isAuthenticated: Bool? = nil
    
    init() {
        
        /// Funcao usada para verificar se o jogador está logado no GameCenter
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            // Casos possíveis (sempre verificar o GKLocalPlayer.isAuthenticated):
                // 1 - O usuário já tem uma conta no GameCenter e está logado, tanto a ViewController quanto o erro vao ser nil, e o jogo pode ser iniciado normalmente. IsAuthenticated se torna true
                // 2 - Se o usuário se recusar a logar (não criar uma conta ou se logar), isAuthenticated se torna false
            
            self.currentViewController = vc
            self.isAuthenticated = GKLocalPlayer.local.isAuthenticated
            
            if error != nil { return } // following code only runs when there is no error
            
            // MARK: Checking for restrictions
            
            if GKLocalPlayer.local.isUnderage {
                // Hide explicit content
                print("underage")
            }
            
            if GKLocalPlayer.local.isMultiplayerGamingRestricted {
                // Disable multiplayer game features
                print("multiplayer restricted")
            }
            
            if GKLocalPlayer.local.isPersonalizedCommunicationRestricted {
                // Disable in game comunnication UI
                print("communication restricted")
            }
            
        }
    }
}
