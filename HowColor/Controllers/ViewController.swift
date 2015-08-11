//
//  ViewController.swift
//  HowColor
//
//  Created by isaced on 15/5/27.
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bestScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bestScoreLabel.text = "Best : \(UserDefaults.bestScore())"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

