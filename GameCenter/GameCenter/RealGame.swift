//
//  RealGame.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 29/08/23.
//

import Foundation
import GameKit

final class RealGame: NSObject, ObservableObject {
    
    @Published var vc: UIViewController? = nil
    @Published var gameState: GameState = .onLobby
    
    override init() {
        super.init()
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        if let viewController = GKMatchmakerViewController(matchRequest: request) {
            viewController.matchmakerDelegate = self
            self.vc = viewController
        }
    }
}

extension RealGame: GKMatchmakerViewControllerDelegate {
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        self.vc = nil
        self.gameState = .canceled
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        self.vc = nil
        self.gameState = .failed
    }
}
