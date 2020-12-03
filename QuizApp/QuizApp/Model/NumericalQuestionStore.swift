//
//  NumericalQuestionStore.swift
//  QuizApp
//
//  Created by Joey Zhu on 2020/11/22.
//

import UIKit

class NumericalQuestionStore{
    var allQuestions = [NumericalQuestion]()
    init(){
        do{
            let data = try Data(contentsOf: questionsArchiveURL)
            let unarchiver = PropertyListDecoder()
            let questions = try unarchiver.decode([NumericalQuestion].self, from: data)
            allQuestions = questions
        } catch {
            print("Error reloading in saved question: \(error)")
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
//        addQuestion(question: "What year is this year?", answer: 2020)
//        addQuestion(question: "What year is last year?", answer: 2019)
//        addQuestion(question: "What year is next year?", answer: 2021)
//        addQuestion(question: "What month is this month?", answer: 11)
//        addQuestion(question: "What week is this week?", answer: 7)
//        addQuestion(question: "The code of Mobile Programming?", answer: 246)
    }
    
    @discardableResult func addQuestion(question: String, answer: Double) -> NumericalQuestion {
        let newQuestion = NumericalQuestion(question: question, answer: answer)
        allQuestions.append(newQuestion)
        return newQuestion
    }
    
    func moveQuestion(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        let movedQuestion = allQuestions[fromIndex]
        allQuestions.remove(at: fromIndex)
        allQuestions.insert(movedQuestion, at: toIndex)
    }
    
    func removeQuestion(_ numericalQuestion: NumericalQuestion){
        if let index = allQuestions.firstIndex(of: numericalQuestion){
            allQuestions.remove(at: index)
        }
    }
    
    @objc func saveChanges() -> Bool {
        print("Saving allQuestions to: \(questionsArchiveURL)")
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allQuestions)
            try data.write(to: questionsArchiveURL, options: [.atomic])
            print("Saved allQuestions")
            return true
        } catch let encodingError{
            print("Error encoding allQuestions: \(encodingError)")
            return false
        }
    }
    
    let questionsArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("questions.plist")
    }()
    
}
