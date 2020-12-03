//
//  EditViewController.swift
//  QuizApp
//
//  Created by Joey Zhu on 2020/11/18.
//

import UIKit

class EditViewController: UITableViewController{
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    
    var numericalQuestionStore: NumericalQuestionStore!
    var imageStore: ImageStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "showQuestion":
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = numericalQuestionStore.allQuestions[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.numericalQuestion = item
                detailViewController.imageStore = imageStore
            }
        case "addQuestion":
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.numericalQuestion = numericalQuestionStore.addQuestion(question: "", answer: 0.0)
            detailViewController.imageStore = imageStore
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numericalQuestionStore.allQuestions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as! QuestionCell
        let item = numericalQuestionStore.allQuestions[indexPath.row]
        cell.questionLabel.text = item.question
        cell.answerLabel.text = numberFormatter.string(from: NSNumber(value: item.answer))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let question = numericalQuestionStore.allQuestions[indexPath.row]
            numericalQuestionStore.removeQuestion(question)
            imageStore.deleteImage(forKey: question.itemKey)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            resetAll()
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        numericalQuestionStore.moveQuestion(from: sourceIndexPath.row, to: destinationIndexPath.row)
        resetAll()
    }
        
    func reset(){
        viewDidLoad()
    }
    
    func resetAll(){
        Score.sharedInstance.correctNum = 0
        Score.sharedInstance.incorrectNum = 0
        
        let viewControllers: [UIViewController] = (self.tabBarController?.viewControllers)!
        
        let choiceController: ChoiceViewController = viewControllers[0] as! ChoiceViewController
        let numericalController: NumericalViewController = viewControllers[1] as! NumericalViewController
        choiceController.reset()
        numericalController.reset()
    }
}
