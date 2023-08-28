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
    
    init() {
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            if error != nil {
                print("erro: \(error!.localizedDescription)")
            }
            if vc != nil {
                print("tem uma view aqui")
            } else {
                print("nao tem uma view aqui")
            }
            self.currentViewController = vc
        }
    }
}
