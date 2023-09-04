//
//  GameCenterAuthenticationService.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 28/08/23.
//

import Foundation
import GameKit
import AVFAudio

final class GameCenterAuthenticationService: ObservableObject {
    var currentViewController: UIViewController?
    
    @Published var isAuthenticated: GameCenterAuthenticationStatus = .loading {
        didSet {
            if isAuthenticated == .succeeded {
                
                Achievements.achievementService.loadAchievements()
                // registra a si mesmo
                //                GKLocalPlayer.local.register(self)
                
                // inicia sessao de audio
                do {
                    let audioSession = AVAudioSession.sharedInstance()

                    try audioSession.setActive(true, options: [])
                    print("AUDIO SUCCESS")
                }
                catch {
                    print("ERROR WITH AUDIO")
                    return
                }
                
            }
        }
    }
    
    init() {
        /// Funcao usada para verificar se o jogador está logado no GameCenter
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            // Casos possíveis (sempre verificar o GKLocalPlayer.isAuthenticated):
                // 1 - O usuário já tem uma conta no GameCenter e está logado, tanto a ViewController quanto o erro vao ser nil, e o jogo pode ser iniciado normalmente. IsAuthenticated se torna true
                // 2 - Se o usuário se recusar a logar (não criar uma conta ou se logar), isAuthenticated se torna false
            
            self.currentViewController = vc
            self.isAuthenticated = GKLocalPlayer.local.isAuthenticated ? .succeeded : .failed
            
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
