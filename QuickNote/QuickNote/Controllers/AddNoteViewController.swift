//
//  AddNoteViewController.swift
//  QuickNote
//
//  Created by Sajid Shanta on 26/6/23.
//

import UIKit
import FirebaseFirestore

class AddNoteViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Note"
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
//        let newNote = Note(title: titleTextField.text ?? "", details: detailsTextView.text ?? "")
//        dataSource.notes.append(newNote)
//        dataSource.save()
        
        //MARK: save data on Firestore
        //create instance of Firebase
        let db = Firestore.firestore()
        //to add Data
        db.collection("Notes").addDocument(data: ["title": titleTextField.text ?? "", "details": detailsTextView.text ?? ""])
        // now run
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil) //reload main table
    }
}
