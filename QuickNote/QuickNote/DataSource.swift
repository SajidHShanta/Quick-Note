//
//  DataSource.swift
//  QuickNote
//
//  Created by Sajid Shanta on 27/6/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DataSource {
//    let defaults = UserDefaults.standard
    
    private var notes: [Note] = []
    static let shared = DataSource()
    
    
//    static func save() {
//        let jsonEncoder = JSONEncoder()
//
//        if let savedData = try? jsonEncoder.encode(DataSource.notes) {
//            let defaults = UserDefaults.standard
//            defaults.set(savedData, forKey: "notes")
//
//        } else {
//            print("Failed to save notes!")
//        }
//    }
    
     func loadNoteDataFromFirebase() {
        //delete previous note histry
        self.notes.removeAll(keepingCapacity: true)
        
        guard let userId = Auth.auth().currentUser?.email else {return}
        
        //create firebase instance
        let db = Firestore.firestore()
        //read from db
        db.collection("users/\(userId)/Notes").getDocuments { data, error in
            if error == nil && data != nil {
                if let documents = data?.documents {
                    for document in documents {
                        
                                                
                        self.notes.append(Note(id: document.documentID, title: document.data()["title"] as! String, details: document.data()["details"] as! String, doc: document.data()["doc"] as! String))
                    }
                    
                    let userInfo: [String: [Note]] = [
                        "note": self.notes
                    ]
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil, userInfo: userInfo) //reload main table
                }
            } else {
                print("Faield to read data")
            }
        }
    }
}
