//
//  Note.swift
//  QuickNote
//
//  Created by Sajid Shanta on 26/6/23.
//

import Foundation

class Note: NSObject, Codable {
    let id: String
    var title: String
    var details: String
    
    init(title: String, details: String, id: String) {
        self.id = id
        self.title = title
        self.details = details
    }
}
