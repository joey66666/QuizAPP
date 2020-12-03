//
//  DrawViewController.swift
//  QuizApp
//
//  Created by Joey Zhu on 2020/11/24.
//

import UIKit

class DrawViewController: UIViewController {
    var imageStore: ImageStore!
    var numericalQuestion: NumericalQuestion!
    
    override func viewWillDisappear(_ animated: Bool) {
        let drawView = self.viewIfLoaded as! DrawView
        let image = drawView.asImage()
        imageStore.setImage(image, forKey: numericalQuestion.itemKey)
        numericalQuestion.finishedLines = drawView.finishedLines
        numericalQuestion.finishedLinesColor = drawView.finishedLinesColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if numericalQuestion.itemKey != "" {
            let drawView = self.viewIfLoaded as! DrawView
            drawView.savedLines = numericalQuestion.finishedLines
            drawView.savedLinesColor = numericalQuestion.finishedLinesColor
        }
    }
}
