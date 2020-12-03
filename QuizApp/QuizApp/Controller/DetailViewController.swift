//
//  DetailViewController.swift
//  QuizApp
//
//  Created by Joey Zhu on 2020/11/20.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var questionField: UITextField!
    @IBOutlet var answerField: UITextField!
    @IBOutlet var createTimeField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var drawButton: UIBarButtonItem!
    var imageStore: ImageStore!
    var numericalQuestion: NumericalQuestion!{
        didSet{
            navigationItem.title = numericalQuestion.question
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionField.text = numericalQuestion.question
        answerField.text = numberFormatter.string(from: NSNumber(value: numericalQuestion.answer))
        createTimeField.text = dateFormatter.string(from: numericalQuestion.createTime)
        createTimeField.isUserInteractionEnabled = false
        let key = numericalQuestion.itemKey
        let imageToDisplay = imageStore.getImage(forKey: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Clear first responder
        view.endEditing(true)
        // Save changes to item
        numericalQuestion.question = questionField.text ?? ""
        if let answerText = answerField.text, let value = numberFormatter.number(from: answerText){
            numericalQuestion.answer = value.doubleValue
        }else{
            numericalQuestion.answer = 0.0
        }
        resetAll()
    }

    // Pass data to DrawViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goDraw") {
            let drawViewController = segue.destination as! DrawViewController
            drawViewController.imageStore = imageStore
            drawViewController.numericalQuestion = numericalQuestion
        }
    }
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = sender
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(photoLibraryAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func deleteImage(_ sender: UIBarButtonItem) {
        let itemKey = numericalQuestion.itemKey
        imageStore.deleteImage(forKey: itemKey)
        numericalQuestion.itemKey = ""
        imageView.image = nil
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
    
    func imagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
//        imagePicker.allowsEditing = true`
        return imagePicker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageStore.setImage(image, forKey: numericalQuestion.itemKey)
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
