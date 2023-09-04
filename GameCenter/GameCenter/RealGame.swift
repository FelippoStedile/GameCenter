//
//  RealGame.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 29/08/23.
//

import Foundation
import GameKit

final class RealGame: NSObject, ObservableObject {
    
    @Published var gameView: GameView?
    @Published var vc: UIViewController? = nil
    @Published var gameState: GameState = .onLobby
    
    override init() {
        super.init()
        let request = GKMatchRequest()
        request.minPlayers = 2//
        request.maxPlayers = 2//
        if let viewController = GKMatchmakerViewController(matchRequest: request) {
            viewController.matchmakerDelegate = self
            self.vc = viewController
        }
        GKLocalPlayer.local.register(self)
    }
}

// MARK: GKMatchmakerViewControllerDelegate
extension RealGame: GKMatchmakerViewControllerDelegate {
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        self.vc = nil
        self.gameState = .canceled
        print("passou aqui 4")
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        self.vc = nil
        self.gameState = .failed
        print("passou aqui 3")
        print("erro: \(error.localizedDescription)")
    }
}

// MARK: GKLocalPlayerListener
extension RealGame: GKLocalPlayerListener {
    func player(_ player: GKPlayer, didAccept invite: GKInvite) {
        if let viewController = GKMatchmakerViewController(invite: invite) {
            viewController.matchmakerDelegate = self
            print("passou aqui 2")
            self.vc = viewController
        }
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        self.vc = nil
        print("passou aqui")
        self.gameState = .playing
        let actualGame = ActualGame(match: match)
        match.delegate = actualGame
        
        var voiceChat = match.voiceChat(withName: "spinChannel")
        print("audio: \(voiceChat)")
        voiceChat?.start()
        print("pre audio status: \(voiceChat?.isActive)")
        voiceChat?.isActive = true
        print("post audio status: \(voiceChat?.isActive)")
        voiceChat?.volume = 1
        print("audio is allowed: \(GKVoiceChat.isVoIPAllowed())")
        voiceChat?.playerVoiceChatStateDidChangeHandler = { player, state in
            switch state {
            case .connected:
                print("audio \(player.alias) connected")
            case .connecting:
                print("audio \(player.alias) connecting")
            case .disconnected:
                print("audio \(player.alias) disconnected")
            case .silent:
                print("audio \(player.alias) is silent")
            case .speaking:
                print("audio silence, \(player.alias) is speaking")
            default:
                print("audio uncovered case \(state)")
            }
        }
        
        self.gameView = GameView(actualGame: actualGame)
    }
}


