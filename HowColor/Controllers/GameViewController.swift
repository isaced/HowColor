//
//  GameViewController.swift
//  HowColor
//
//  Created by isaced on 15/5/27.
//
//

import UIKit

class GameViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    /// 分数标签
    @IBOutlet var scoreLabel: UILabel!
    
    /// 色块墙
    @IBOutlet var tileCollectionView: UICollectionView!
    
    /// 倒计时显示
    @IBOutlet var timeButton: UIButton!
    
    // ---
    
    /// 当前级别
    var level : Int = 1
    
    /// 倒计时秒数
    var countdown : Int = 60
    
    var tileWidht : CGFloat = 0
    var tileNum : Int = 0
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 调整 UICollectionView 样式
        tileCollectionView.layer.cornerRadius = 8.0
        tileCollectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5)
        
        // 计时开始
        var timer = NSTimer(timeInterval: 1, target: self, selector: Selector("increaseTimerCount"), userInfo: nil, repeats: true)
        
        // 根据不同屏幕决定方块数量和大小
        if Device.IS_3_5_INCHES() {
            tileWidht = 56.0
            tileNum = 20
        }else if Device.IS_4_INCHES() {
            tileWidht = 60.0
            tileNum = 24
        }else if Device.IS_4_7_INCHES() {
            tileWidht = 63.0
            tileNum = 28
        }else if Device.IS_5_5_INCHES() {
            tileWidht = 63.0
            tileNum = 40
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tileNum
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: tileWidht, height: tileWidht)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        cell.backgroundColor = UIColor.redColor()

        return cell
    }
    
    // MARK: -
    
    @IBAction func goBackAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func increaseTimerCount() {
        
    }

}
