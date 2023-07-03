//
//  AddNoteViewController.swift
//  QuickNote
//
//  Created by Sajid Shanta on 26/6/23.
//

import UIKit
import FirebaseAuth
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
        
        //add Data
//        db.collection("Notes").addDocument(data: ["title": titleTextField.text ?? "", "details": detailsTextView.text ?? "", "id": UUID().uuidString]) { error in
        
//        db.collection("Notes").document(UUID().uuidString).setData(["title": titleTextField.text ?? "", "details": detailsTextView.text ?? ""]) { error in
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
        
        db.collection("users").document("\(userId)/Notes/\(UUID().uuidString)").setData(["title": titleTextField.text ?? "", "details": detailsTextView.text ?? ""]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.titleTextField.text = ""
                self.detailsTextView.text = ""
                
                //TODO: minimize the sheet
                
                DataSource.loadNoteDataFromFirebase()
            }
        }
    }
}
