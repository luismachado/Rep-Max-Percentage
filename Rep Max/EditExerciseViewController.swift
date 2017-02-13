//
//  EditExerciseViewController.swift
//  RepMax Percentage
//
//  Created by Luís Machado on 27/09/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit

class EditExerciseViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var weightLabel: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var exercise: Exercise?
    var newExercise:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.delegate = self
        self.weightLabel.delegate = self

        // Set placeholder text according to weight unit
        if weightInKgs {
            weightLabel.attributedPlaceholder = NSAttributedString(string: WeightKey.kgsKey)
        } else {
            weightLabel.attributedPlaceholder = NSAttributedString(string: WeightKey.lbsKey)
        }
        
        navigationItem.title = "New Exercise"
        
        if let exercise = exercise {
            nameLabel.text = exercise.name
            //weightLabel.text = String(format: "%f", exercise.getWeight(getWeightInKgs: weightInKgs))
            
            let numberFormatter = NumberFormatter()
            numberFormatter.locale = NSLocale.current
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            let number = NSNumber(value: exercise.getWeight(getWeightInKgs: weightInKgs))
            
            weightLabel.text = numberFormatter.string(from: number)
            
            newExercise = false
            navigationItem.title = exercise.name
        }
        
        checkValidFields()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: AnyObject) {
        
        let name = nameLabel.text ?? ""
        let weight = weightLabel.text ?? ""
        // Set the exercise to be passed to ViewController after the unwind segue.
        
        let numberFormatted = NumberFormatter().number(from: weight)
        if let numberFormatted = numberFormatted {
            exercise = Exercise(name: name, weight: Double(numberFormatted), weightInKgs: weightInKgs)
        }
        if newExercise {
            self.performSegue(withIdentifier: "unwindToExerciseList", sender: self)
        } else {
            self.performSegue(withIdentifier: "unwindToExercise", sender: self)
        }
        
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        
        let isPresentingInAddExerciseMode = presentingViewController is UINavigationController
        
        
        if isPresentingInAddExerciseMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
        
    }
    
    // MARK: UITextFieldDelegate
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidFields()
        
        //navigationItem.title = nameLabel.text
        if let name = nameLabel.text {
            if name != "" {
                navigationItem.title = name
            } else {
                navigationItem.title = "New Exercise"
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func checkValidFields() {
        // Disable the Save button if the text field is empty.
        let text = nameLabel.text ?? ""
        let weight = weightLabel.text ?? ""
        
        let numberFormatted = NumberFormatter().number(from: weight)
        if let numberFormatted = numberFormatted {
            saveButton.isEnabled = !text.isEmpty && !weight.isEmpty && Double(numberFormatted) > 0.0
        }
    }

}
