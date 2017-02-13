//
//  OptionsViewController.swift
//  RepMax Percentage
//
//  Created by Luís Machado on 27/09/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

    @IBOutlet var units: UISegmentedControl!
    @IBAction func unitsChanged(_ sender: AnyObject) {
        
        if units.selectedSegmentIndex == 0 {
            weightInKgs = true
        } else {
            weightInKgs = false
        }
        
        UserDefaults.standard.set(weightInKgs, forKey: "weightInKgs")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if weightInKgs {
            units.selectedSegmentIndex = 0
        } else {
            units.selectedSegmentIndex = 1
        }
    }

    @IBAction func sendFeedback(_ sender: AnyObject) {
        
        send(scheme: "mailto:test@gmail.com")
    }
    
    func send(scheme:String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(scheme): \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
