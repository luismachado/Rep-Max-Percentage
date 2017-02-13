//
//  ExerciseViewController.swift
//  RepMax Percentage
//
//  Created by Luís Machado on 30/09/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var exercise: Exercise?
    var listVC: ViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = exercise!.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cellIdentifier = "WeightPercentageCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WeightTableViewCell

        let percentage = Double(round(exercise!.getWeight(getWeightInKgs: weightInKgs) * Double(indexPath.row+1) * 0.05 * 100)/100)
        var weightLabel = WeightKey.kgsKey
        if !weightInKgs {
            weightLabel = WeightKey.lbsKey
        }
        
        cell.percentageLabel.text = "\(Double((indexPath.row+1)) * 5)%"

        cell.weightLabel.text = "\(percentage) " + weightLabel
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditExercise" {
            let exerciseViewController = segue.destination as! EditExerciseViewController
            
            exerciseViewController.exercise = exercise!
        }
    }
    
    @IBAction func unwindToExercise(_ sender: UIStoryboardSegue) {
        print("ExerciseViewController: unwindToExercise")
        if let sourceViewController = sender.source as? EditExerciseViewController, let editedExercise = sourceViewController.exercise {
            exercise = editedExercise
        }
        listVC?.updateExercise(exercise: exercise!)
        tableView.reloadData()
        navigationItem.title = exercise!.name
    }
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
        
    }

}
