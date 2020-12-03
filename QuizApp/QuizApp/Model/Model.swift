//
//  Model.swift
//  QuizApp
//
//  Created by Joey Zhu on 2020/11/16.
//

import Foundation

class Choice{
    let questions = [
        "What's the code of James Bond?",
        "What's the name of Iron Man?",
        "What's the name of Doctor Strange?"]
    
    let answers = [["009","007","006","999"],
                   ["Tony Stark","Tony Start","Tony Star"],
                   ["David","Thor","Stephen","John"]]
    
    let correctAnswer = [1, 0, 2]
    
    static let sharedInstance = Choice()
}


class NumericalQuestion: Equatable, Codable{
    var question: String
    var answer: Double
    var isAnswered: Bool
    var createTime: Date
    var itemKey: String
    var finishedLines: [Line]
    var finishedLinesColor: [Int]
    
    init(question: String, answer: Double) {
        self.question = question
        self.answer = answer
        self.isAnswered = false
        self.createTime = Date()
        self.itemKey = UUID().uuidString
        self.finishedLines = [Line]()
        self.finishedLinesColor = [Int]()
    }
    
    static func == (lhs: NumericalQuestion, rhs: NumericalQuestion) -> Bool{
        return lhs.question == rhs.question &&
            lhs.answer == rhs.answer &&
            lhs.isAnswered == rhs.isAnswered &&
            lhs.createTime == rhs.createTime
    }
}

class Numerical{
    static let sharedInstance = Numerical()
//    var allQuestions: [NumericalQuestion] = [
//        NumericalQuestion(question: "What year is this year?", answer: 2020),
//        NumericalQuestion(question: "What year is last year?", answer: 2019),
//        NumericalQuestion(question: "What year is next year?", answer: 2021),
//        NumericalQuestion(question: "What month is this month?", answer: 11),
//        NumericalQuestion(question: "What week is this week?", answer: 7),
//        NumericalQuestion(question: "The code of Mobile Programming?", answer: 246)
//    ]
}


class Score{
    static let sharedInstance = Score()
    var correctNum: Int = 0
    var incorrectNum: Int = 0
}
