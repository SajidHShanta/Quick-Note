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
    var image: String
    
    init(id: String, title: String, details: String, image: String = "") {
        self.id = id
        self.title = title
        self.details = details
        self.image = image //will use empty string, if nil
    }
}
