//
//  ScoreViewController.swift
//  QuizApp
//
//  Created by Joey Zhu on 2020/11/16.
//

import UIKit

class ScoreViewController: UIViewController{
    @IBOutlet var totalNumLabel: UILabel!
    @IBOutlet var correctNumLabel: UILabel!
    @IBOutlet var incorrectNumLabel: UILabel!
    
    @IBAction func openGithub(_ sender: UIButton) {
        let url = URL(string: "https://github.com/joey66666/quizapp")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let correctNum: Int = Score.sharedInstance.correctNum
        let incorrectNum: Int = Score.sharedInstance.incorrectNum
        let totalNum: Int = correctNum + incorrectNum
        
        correctNumLabel.text = "\(correctNum)"
        incorrectNumLabel.text = "\(incorrectNum)"
        totalNumLabel.text = "\(totalNum)"
        
        if correctNum > incorrectNum{
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0.7444281409, blue: 0.007186546397, alpha: 1)
        }else if correctNum < incorrectNum{
            self.view.backgroundColor = #colorLiteral(red: 0.8380152498, green: 0.1714413191, blue: 0.08493182562, alpha: 1)
        }else{
            // Detect and switch to dark mode
            if traitCollection.userInterfaceStyle == .light{
                self.view.backgroundColor = UIColor.white
            }else{
                self.view.backgroundColor = nil
            }
        }
    }
}
