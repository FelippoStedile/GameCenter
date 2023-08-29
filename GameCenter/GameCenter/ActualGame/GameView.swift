//
//  GameView.swift
//  GameCenter
//
//  Created by Pedro Mezacasa Muller on 29/08/23.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var actualGame: ActualGame
    var colorMeter: Color = .white//
    var turns: Int = 0 {
        didSet{
            switch turns {
            case -10...(-9): colorMeter = Color.red
            case -8...(-6): colorMeter = Color.orange
            case -5...(-3): colorMeter = Color.yellow
            case -2...(-1): colorMeter = Color.gray
            case 0: colorMeter = Color.primary
            case 1...2: colorMeter = Color.blue
            case 3...5: colorMeter = Color.cyan
            case 6...8: colorMeter = Color.mint
            case 9...10: colorMeter = Color.green
            default: colorMeter = Color.black
            }
        }
    }
    var currentAngle: Double = 0
    
    var body: some View {
        VStack {
            if let totalOpponentAngle = actualGame.opponentGameData.deltaAngle {
                let score = actualGame.selfScore - totalOpponentAngle//
                var turns = Int(score/360)
                let current = score.truncatingRemainder(dividingBy: 360)
                Text("Placar atual:\nVoltas: \(turns)\n\(current)")//
            }
            else {
                Text("JOGANDO!")
            }
            ZStack{//
                Circle()
                    .foregroundColor(colorMeter)
                    .frame(width: 100, height: 100)
                Image(systemName: "arrow.triangle.merge")
                    .foregroundColor(colorMeter)
                    .frame(width: 80, height: 80)
                    .colorInvert()//so pra n criar ainda a antiPrimary
                    .rotationEffect(Angle(degrees: ((actualGame.selfScore - (actualGame.opponentGameData.deltaAngle?.truncatingRemainder(dividingBy: 360) ?? 0) ))/2.0 ))
            }//
        }
    }
}

