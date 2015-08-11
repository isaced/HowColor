//
//  UserDefaults.swift
//  HowColor
//
//  Created by isaced on 15/5/27.
//
//

import UIKit

class UserDefaults: NSObject {
    
    static let BestScoreKey = "BestScore"
    
    /**
    保存最高分
    */
    static func saveBestScore(bestScore : Int){
        var userdefaults = NSUserDefaults.standardUserDefaults()
        var oldBestScore = userdefaults.integerForKey(BestScoreKey)
        
        // 比以前的分数大才写入
        if bestScore > oldBestScore {
            userdefaults.setInteger(bestScore, forKey: BestScoreKey)
            userdefaults.synchronize()
        }
    }
    
    /**
    读取最高分
    */
    static func bestScore() -> Int {
        var bestScore = NSUserDefaults.standardUserDefaults().integerForKey(BestScoreKey)
        return bestScore
    }
}
