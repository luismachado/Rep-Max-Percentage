//
//  Exercise.swift
//  RepMax Percentage
//
//  Created by Luís Machado on 27/09/16.
//  Copyright © 2016 LuisMachado. All rights reserved.
//

import UIKit

class Exercise: NSObject, NSCoding {
    
    // MARK: Properties
    var name: String
    var weight: Double
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("exercises")
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let weightKey = "weight"
    }
    
    // MARK: Initialization
    init?(name: String, weight: Double, weightInKgs: Bool) {
        // Initialize stored properties.
        self.name = name
        self.weight = weight
        
        if !weightInKgs {
            self.weight = weight / 2.20462
        }
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || weight < 0 {
            return nil
        }
    }
    
    func getWeight(getWeightInKgs:Bool) -> Double {
        var returnedWeight:Double = 0
        if getWeightInKgs {
            returnedWeight = weight
        } else {
            returnedWeight = weight * 2.20462
        }
        
        return Double(round(100*returnedWeight)/100)
    }
    
    
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(weight, forKey: PropertyKey.weightKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let weight = aDecoder.decodeDouble(forKey: PropertyKey.weightKey)
        
        // Must call designated initializer.
        self.init(name: name, weight: weight, weightInKgs: true)
    }
    
}
