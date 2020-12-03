//
//  NumericalViewController.swift
//  QuizApp
//
//  Created by Joey Zhu on 2020/11/16.
//

import UIKit


class NumericalViewController: UIViewController{
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var inputField: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var nextQuestionButton: UIButton!
    var numericalQuestionStore: NumericalQuestionStore!
    var imageStore: ImageStore!
    var inputValue: Double = 0.0
    var currentQuestionIndex: Int = 0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadQuestion()
    }
    
    @IBAction func submitQuestion(_ sender: UIButton){
        let allQuestions = numericalQuestionStore.allQuestions
        
        let numericalQuestion: NumericalQuestion = allQuestions[currentQuestionIndex]
        let answer = numericalQuestion.answer
        if inputValue == answer{
            answerCorrect()
        }else{
            answerIncorrect()
        }
        allQuestions[currentQuestionIndex].isAnswered = true
        submitButton.isHidden = true
    }
    
    @IBAction func nextQuestion(_ sender: UIButton){
        currentQuestionIndex += 1
        let allQuestions = numericalQuestionStore.allQuestions
        
        if currentQuestionIndex == (allQuestions.count - 1){
            nextQuestionButton.isHidden = true
        }
        reloadQuestion()
    }
    
    @IBAction func inputFieldEditBegin(_ textFiled: UITextField){
        textFiled.text = ""
        textFiled.textColor = UIColor.orange
    }
    
    @IBAction func inputfieldEditChange(_ textField: UITextField){
        textField.font = UIFont.boldSystemFont(ofSize: 40)
        if let text = textField.text, let value = Double(text){
            inputValue = value
        }
    }

    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        inputField.resignFirstResponder()
    }
    
    func reloadQuestion(){
        let allQuestions = numericalQuestionStore.allQuestions
        if allQuestions.count != 0 && currentQuestionIndex < allQuestions.count && allQuestions[currentQuestionIndex].isAnswered == false{
            let numericalQuestion: NumericalQuestion = allQuestions[currentQuestionIndex]
            let question: String = "\(currentQuestionIndex + 1): " + numericalQuestion.question
            questionLabel.isHidden = false
            questionLabel.text = question
            questionLabel.textColor = nil
            questionLabel.font = questionLabel.font.withSize(20)
            answerLabel.isHidden = false
            let key = numericalQuestion.itemKey
            
            if key != "" {
                let imageToDisplay = imageStore.getImage(forKey: key)
                imageView.image = imageToDisplay
            } else {
                imageView.image = nil
            }
            
            inputField.isHidden = false
            inputField.text = nil
            inputField.font = UIFont.systemFont(ofSize: 26)
            inputField.textColor = UIColor.lightGray
            nextQuestionButton.isHidden = false
            submitButton.isHidden = false
            if currentQuestionIndex == allQuestions.count - 1{
                nextQuestionButton.isHidden = true
            }
            
        }else{
            questionLabel.text = "Empty"
            questionLabel.textColor = nil
            questionLabel.font = questionLabel.font.withSize(20)
            answerLabel.isHidden = true
            inputField.isHidden = true
            submitButton.isHidden = true
//            nextQuestionButton.setTitle("", for: .normal)
            nextQuestionButton.isHidden = true
            imageView.image = nil
        }
    }
    
    func answerCorrect(){
        Score.sharedInstance.correctNum += 1
        questionLabel.text = "CORRECT"
        questionLabel.textColor = #colorLiteral(red: 0, green: 0.7444281409, blue: 0.007186546397, alpha: 1)
        questionLabel.font = questionLabel.font.withSize(40)
        answerLabel.isHidden = true
        inputField.isHidden = true
        imageView.image = nil
    }
    
    func answerIncorrect(){
        Score.sharedInstance.incorrectNum += 1
        questionLabel.text = "INCORRECT"
        questionLabel.textColor = UIColor.red
        questionLabel.font = questionLabel.font.withSize(40)
        answerLabel.isHidden = true
        inputField.isHidden = true
        imageView.image = nil
    }
    
    func reset(){
        currentQuestionIndex = 0
        for i in numericalQuestionStore.allQuestions{
            i.isAnswered = false
        }
        viewDidLoad()
    }
}
