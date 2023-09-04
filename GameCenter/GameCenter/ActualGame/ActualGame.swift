//
//  ActualGame.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 29/08/23.
//

import Foundation
import GameKit
import Combine

final class ActualGame: NSObject, ObservableObject {
    
    var gameInstance: GKMatch
    var opponentGameData: GameData = GameData() {
        didSet {
            self.currentDifference = selfScore - (opponentGameData.deltaAngle ?? 0)
            if currentDifference <= -1800 && !Achievements.achievementService.combackIsOn{
                Achievements.achievementService.combackIsOn = true
                Achievements.achievementService.setToValue(ID: "Comeback3", value: 50.0)
            } else {
                if currentDifference <= -3240 && !Achievements.achievementService.dreamComebackIsOn {
                    Achievements.achievementService.dreamComebackIsOn = true
                }
            }
        }
    }
    
    var selfScore: Double = 0 {
        didSet {
            currentDifference = selfScore - (opponentGameData.deltaAngle ?? 0)
        }
    }
    
    @Published var currentGameOutcome: GameOutcomes? = nil
    
    // represents the current score offset
    @Published var currentDifference: Double = 0
    
    var spinService: CompassHeading = CompassHeading()
    var connections: Set<AnyCancellable> = []
    
    init(match: GKMatch) {
        self.gameInstance = match
        super.init()
        
        spinService.$biggestStack.sink { newValue in
            self.selfScore = newValue
            if self.selfScore >= 36000 {//n testado, só fé
                Achievements.achievementService.completedAchievement(ID: "100Spins2")
            }
            print("audio chat active: \(self.gameInstance.voiceChat(withName: "spinChannel")?.players)")
            if !(self.gameInstance.voiceChat(withName: "spinChannel")?.isActive ?? true)  {
                self.gameInstance.voiceChat(withName: "spinChannel")?.isActive = true
                self.gameInstance.voiceChat(withName: "spinChannel")?.start()
                print("audio nao estava ativo")
            }
        }
        .store(in: &connections)
        
        Timer
            .publish(every: 0.1, on: .main, in: .default)
            .autoconnect()
            .sink { _ in
                if self.currentGameOutcome == nil {
                    self.sendData()
                }
            }
            .store(in: &connections)
    }
}

// MARK: GKMatchDelegate
extension ActualGame: GKMatchDelegate {
    
    private func encodeMyData() -> Data? {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(GameData(deltaAngle: self.selfScore ))
                                          
            
            return data
        } catch let error {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    private func decodeData(data: Data) -> GameData? {
        let decoder = PropertyListDecoder()
        do {
            let gameData = try decoder.decode(GameData.self, from: data)
            return gameData
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func sendData() {
        if self.currentGameOutcome == nil {
            if let data = encodeMyData() {
                do {
                    try self.gameInstance.sendData(toAllPlayers: data, with: .reliable)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        if let decodedInfo = decodeData(data: data) {
            self.opponentGameData = decodedInfo
            if (self.selfScore) - (self.opponentGameData.deltaAngle ?? 0) >= 3600 {
                sendData()
                self.currentGameOutcome = .win
                Achievements.achievementService.completedAchievement(ID: "victorySpin1")
                if Achievements.achievementService.combackIsOn {
                    Achievements.achievementService.completedAchievement(ID: "Comeback3")
                    if Achievements.achievementService.dreamComebackIsOn {
                        Achievements.achievementService.completedAchievement(ID: "ComebackDreams4")
                    }
                }
            } else if (self.selfScore) - (self.opponentGameData.deltaAngle ?? 0) <= -3600 {
                sendData()
                self.currentGameOutcome = .loss
            }
            
        }
    }
}
