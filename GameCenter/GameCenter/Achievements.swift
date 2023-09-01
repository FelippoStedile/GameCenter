//
//  Achievements.swift
//  GameCenter
//
//  Created by Felippo Stedile on 30/08/23.
//

import Foundation
import GameKit

class Achievements{
    
    static var achievementService: Achievements = Achievements()
    var achievementIDs: [String] = ["victorySpin1", "100Spins2"]
    var achievementsToReport: [GKAchievement] = []
    
    
//    init(){
//
//
//        //print("fiz isso aqui")
//    }
    
    func loadAchievements(){
        GKAchievement.loadAchievements(completionHandler: { [self] (achievements: [GKAchievement]?, error: Error?) in
            
            for achievementID in achievementIDs {
                var achievement = achievements?.first(where: { $0.identifier == achievementID})
                
                if achievement == nil {
                    achievement = GKAchievement(identifier: achievementID)
                }
                
                self.achievementsToReport.append(achievement!)
                
                if error != nil {
                    // Handle the error that occurs.
                    print("Error: \(String(describing: error))")
                }
            }
        })
    }
    
    func completedAchievement(ID: String){
        achievementsToReport.first(where: { $0.identifier == ID})?.percentComplete = 100
        var achievement = achievementsToReport.first(where: { $0.identifier == ID})
        achievement?.showsCompletionBanner = true
        
        Achievements.achievementService.reportProgress()
    }
    
    func reportProgress(){
        GKAchievement.report(achievementsToReport, withCompletionHandler: {(error: Error?) in
            if error != nil {
                // Handle the error that occurs.
                print("Error: \(String(describing: error))")
            }
        })
        
    }
    
}
