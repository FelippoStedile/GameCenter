//
//  GameData.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 29/08/23.
//

import Foundation

struct GameData: Codable {
    var playerName: String?
    var deltaAngle: Double?
    var outcome: String?
    var message: String?
    var matchName: String?
}
