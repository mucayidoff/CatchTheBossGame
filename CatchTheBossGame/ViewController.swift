//
//  ViewController.swift
//  CatchTheBossGame
//
//  Created by mucayid on 14.07.2024.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var bossArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    //Views
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    

    @IBOutlet weak var boss1: UIImageView!
    
    @IBOutlet weak var boss2: UIImageView!
    
    @IBOutlet weak var boss3: UIImageView!
    
    @IBOutlet weak var boss4: UIImageView!
    
    @IBOutlet weak var boss5: UIImageView!
    
    @IBOutlet weak var boss6: UIImageView!
    
    @IBOutlet weak var boss7: UIImageView!
    
    @IBOutlet weak var boss8: UIImageView!
    
    @IBOutlet weak var boss9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        scoreLabel.text = "Score: \(score)"
        
        //HighScore check
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        if let newScore = storedHighscore as? Int {
            highScore = newScore
            highScoreLabel.text = "highScore: \(highScore)"
            
            
        }
        
        
        
        //Images
        
        boss1.isUserInteractionEnabled = true
        boss2.isUserInteractionEnabled = true
        boss3.isUserInteractionEnabled = true
        boss4.isUserInteractionEnabled = true
        boss5.isUserInteractionEnabled = true
        boss6.isUserInteractionEnabled = true
        boss7.isUserInteractionEnabled = true
        boss8.isUserInteractionEnabled = true
        boss9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        boss1.addGestureRecognizer(recognizer1)
        boss2.addGestureRecognizer(recognizer2)
        boss3.addGestureRecognizer(recognizer3)
        boss4.addGestureRecognizer(recognizer4)
        boss5.addGestureRecognizer(recognizer5)
        boss6.addGestureRecognizer(recognizer6)
        boss7.addGestureRecognizer(recognizer7)
        boss8.addGestureRecognizer(recognizer8)
        boss9.addGestureRecognizer(recognizer9)
        
        bossArray = [boss1, boss2, boss3, boss4, boss5, boss6, boss7, boss8, boss9]
        
        
        
        
        
        //Timer
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideBoss), userInfo: nil, repeats: true)
        
        hideBoss()
        
    }
    
    
    @objc func hideBoss() {
        
        for boss in bossArray {
            boss.isHidden = true
            
        }
        
        let random = Int(arc4random_uniform(UInt32(bossArray.count - 1)))
        bossArray[random].isHidden = false
    }
    
    

    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown() {
        
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for boss in bossArray {
                boss.isHidden = true
            }
            
            
            //HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
                
            }
            
            
            
            
            //Alert
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                // Replay function
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideBoss), userInfo: nil, repeats: true)
                
                
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
    }
    
    
}

