//
//  Note.swift
//  QuickNote
//
//  Created by Sajid Shanta on 26/6/23.
//

import Foundation

class Note: NSObject, Codable {
    var title: String
    var details: String
    
    init(title: String, details: String) {
        self.title = title
        self.details = details
    }
}
