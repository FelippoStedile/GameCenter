//
//  GameCenterAuthenticationStatus.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 29/08/23.
//

import Foundation

enum GameCenterAuthenticationStatus {
    case failed, succeeded, loading
    
    var textDescription: String {
        switch self {
        case.failed:
            return "Falhou"
        case .loading:
            return "Carregando ..."
        case .succeeded:
            return "Sucesso!"
        }
    }
}
