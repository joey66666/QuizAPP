//
//  ChoiceViewController.swift
//  QuizApp
//
//  Created by Joey Zhu on 2020/11/16.
//

import UIKit


class ChoiceViewController: UIViewController{
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    @IBOutlet var picker: UIPickerView!
    
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var nextQuestionButton: UIButton!
    
    let questions = Choice.sharedInstance.questions
    let answers = Choice.sharedInstance.answers
    let correctAnswer = Choice.sharedInstance.correctAnswer
    
    var currentQuestionIndex: Int = 0
    
    override func viewDidLoad(){
        super.viewDidLoad()
        reloadQuestion()
        picker.isHidden = false
        picker.dataSource = self
        picker.delegate = self
        submitButton.isHidden = false
    }
    
    @IBAction func nextQuestion(_ sender: UIButton){
        currentQuestionIndex += 1
        if currentQuestionIndex == (questions.count - 1){
            nextQuestionButton.setTitle("", for: .normal)
//            nextQuestionButton.isHidden = true
        }
        reloadQuestion()
        reloadAnswer()
        answerLabel.isHidden = false
        picker.isHidden = false
        submitButton.isHidden = false
    }
    
    
    @IBAction func submitQuestion(_ sender: UIButton){
        let selectedIndex = picker.selectedRow(inComponent: 0)
        if selectedIndex == correctAnswer[currentQuestionIndex]{
            answerCorrect()
        }else{
            answerIncorrect()
        }
        submitButton.isHidden = true
    }
    
    func reloadQuestion(){
        let question: String = "\(currentQuestionIndex + 1): " + questions[currentQuestionIndex]
        questionLabel.text = question
        questionLabel.textColor = nil
        questionLabel.font = questionLabel.font.withSize(20)
        questionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    func reloadAnswer(){
        picker.reloadAllComponents()
        picker.selectRow(0, inComponent: 0, animated: true)
    }
    
   
    
    func answerCorrect(){
        Score.sharedInstance.correctNum += 1
        questionLabel.text = "CORRECT"
        questionLabel.textColor = #colorLiteral(red: 0, green: 0.7444281409, blue: 0.007186546397, alpha: 1)
        questionLabel.font = questionLabel.font.withSize(40)
        answerLabel.isHidden = true
        picker.isHidden = true
    }
    
    func answerIncorrect(){
        Score.sharedInstance.incorrectNum += 1
        questionLabel.text = "INCORRECT"
        questionLabel.textColor = UIColor.red
        questionLabel.font = questionLabel.font.withSize(40)
        answerLabel.isHidden = true
        picker.isHidden = true
    }
    
    func reset(){
        currentQuestionIndex = 0
        viewDidLoad()
    }
}

extension ChoiceViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return answers[currentQuestionIndex].count
    }
}

extension ChoiceViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return answers[currentQuestionIndex][row]
    }
    
}
