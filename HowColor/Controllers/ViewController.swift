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
    }
    
    override func viewWillAppear(animated: Bool) {
        bestScoreLabel.text = "Best : \(UserDefaults.bestScore())"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

