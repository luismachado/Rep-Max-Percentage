//
//  ViewController.swift
//  RepMax Percentage
//
//  Created by Luís Machado on 27/09/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit

var weightInKgs:Bool = true
struct WeightKey {
    static let kgsKey = "Kgs"
    static let lbsKey = "Lbs"
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var exercises = [Exercise]()

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        if let savedWeightInKgs = UserDefaults.standard.object(forKey: "weightInKgs") {
            
            weightInKgs =  savedWeightInKgs as! Bool
        }
        
        
        // Load any saved exercises, otherwise load sample data.
        if let savedExercises = loadExercises() {
            exercises += savedExercises
        } else {
            // Load the sample data.
            let exercise = Exercise(name: "Squat", weight: 140, weightInKgs: true)!
            let exercise1 = Exercise(name: "Deadlift", weight: 170, weightInKgs: true)!
            let exercise2 = Exercise(name: "Bench Press", weight: 80, weightInKgs: true)!
            exercises.append(exercise)
            exercises.append(exercise1)
            exercises.append(exercise2)
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ExerciseTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ExerciseTableViewCell
        
        // Fetches the appropriate exercise for the data source layout.
        let exercise = exercises[indexPath.row]
        
        var weightLabel = WeightKey.kgsKey
        if !weightInKgs {
            weightLabel = WeightKey.lbsKey
        }
        
        cell.nameLabel.text = exercise.name
        cell.weightLabel.text = String(exercise.getWeight(getWeightInKgs: weightInKgs)) + " " + weightLabel

        return cell
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            exercises.remove(at: (indexPath as NSIndexPath).row)
            saveExercises()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let exerciseViewController = segue.destination as! ExerciseViewController
            
            // Get the cell that generated this segue.
            if let selectedExerciseCell = sender as? ExerciseTableViewCell {
                let indexPath = tableView.indexPath(for: selectedExerciseCell)!
                let selectedExercise = exercises[(indexPath as NSIndexPath).row]
                exerciseViewController.exercise = selectedExercise
                exerciseViewController.listVC = self
                
            }
        }
        else if segue.identifier == "AddExercise" {
            print("ViewController: Adding new exercise.")
        }
    }
    
    
    @IBAction func unwindToExerciseList(_ sender: UIStoryboardSegue) {

        if let sourceViewController = sender.source as? EditExerciseViewController, let exercise = sourceViewController.exercise {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing exercise.
                exercises[(selectedIndexPath as NSIndexPath).row] = exercise
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new exercise.
                exercises.append(exercise)
                tableView.reloadData()
            }
            // Save exercise list
            saveExercises()
        }
    }
    
    public func updateExercise(exercise: Exercise){
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            exercises[selectedIndexPath.row] = exercise
            print("ViewController: TableList updated")
            saveExercises()
        }
    }
    
    
    // MARK: NSCoding
    func saveExercises() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(exercises, toFile: Exercise.ArchiveURL.path)
        if !isSuccessfulSave {
            print("ViewController: Failed to save exercises...")
        }
    }
    
    func loadExercises() -> [Exercise]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Exercise.ArchiveURL.path) as? [Exercise]
    }
    


}

