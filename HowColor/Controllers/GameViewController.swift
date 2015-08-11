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
    var level : Int = 0
    
    /// 倒计时秒数
    var countdown : Int = 60
    
    /// 计时器
    var timer : NSTimer!
    
    /// 块宽度
    var tileWidht : CGFloat = 0
    
    /// 块数量
    var tileCount : Int = 0
    
    /// 颜色
    var colorA : UIColor!
    var colorB : UIColor!
    
    /// 随机颜色的位置
    var ranmodColorIndex : Int = 0
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 调整 UICollectionView 样式
        tileCollectionView.layer.cornerRadius = 8.0
        tileCollectionView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5)
        
        // 重置计时器
        refreshTimeLabel()
        
        // 计时开始
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("increaseTimerCount"), userInfo: nil, repeats: true)
        
        // 根据不同屏幕决定方块数量和大小
        if Device.IS_3_5_INCHES() {
            tileWidht = 56.0
            tileCount = 20
        }else if Device.IS_4_INCHES() {
            tileWidht = 60.0
            tileCount = 24
        }else if Device.IS_4_7_INCHES() {
            tileWidht = 63.0
            tileCount = 28
        }else if Device.IS_5_5_INCHES() {
            tileWidht = 63.0
            tileCount = 40
        }
        
        // 生成颜色
        generateColorForLevel(level)
        
        tileCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tileCount
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: tileWidht, height: tileWidht)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        if indexPath.row == self.ranmodColorIndex {
            cell.backgroundColor = colorB;
        }else{
            cell.backgroundColor = colorA;
        }

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == self.ranmodColorIndex {
            
            level = level + 1
            
            refreshScoreLabel()
            
            generateColorForLevel(level);
            
            // reload CollectionView (使用 reloadSections 会有个默认渐显动画)
            tileCollectionView.reloadSections(NSIndexSet(index: 0))
        }
    }
    
    // MARK: -
    
    @IBAction func goBackAction(sender: UIBarButtonItem) {
        
        // Timer invalidate
        if timer.valid {
            timer.invalidate()
        }
        
        // Dismiss
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
    刷新分数标签
    */
    func refreshScoreLabel() {
        scoreLabel.text = "\(level)"
    }
    
    /**
    刷新倒计时标签
    */
    func refreshTimeLabel() {
        timeButton.setTitle("\(countdown)", forState: .Normal)
    }
    
    /**
    计时循环
    */
    func increaseTimerCount() {
        countdown = countdown - 1
        
        refreshTimeLabel()
        
        // Time Over
        if self.countdown == 0 {
            timer.invalidate()
            timerOver()
        }
    }
    
    /**
    时间到
    */
    func timerOver() {
        let alert = UIAlertController(title: "Game Over", message: nil, preferredStyle: .Alert)
        self.presentViewController(alert, animated: true, completion: nil)
        
        // Save Score
        UserDefaults.saveBestScore(level)

        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            alert.dismissViewControllerAnimated(true, completion: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    /**
    根据游戏等级生成颜色
    */
    func generateColorForLevel(level:Int) {
        let r = CGFloat(arc4random() % 255)
        let g = CGFloat(arc4random() % 255)
        let b = CGFloat(arc4random() % 255)
        
        colorA = UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
        
        // 从基数 0.2 开始递增，增量为 0.03 * Level
        let alpha = 0.2 + (0.03 * CGFloat(level));
        
        colorB = colorA.colorWithAlphaComponent(alpha)
        
        ranmodColorIndex = Int(arc4random()) % tileCount;
    }
}
