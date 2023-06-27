//
//  DataSource.swift
//  QuickNote
//
//  Created by Sajid Shanta on 27/6/23.
//

import Foundation

class DataSource {
    let defaults = UserDefaults.standard
    
    static var notes: [Note] = []
    
    static func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(DataSource.notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
            
        } else {
            print("Failed to save notes!")
        }
    }
}
