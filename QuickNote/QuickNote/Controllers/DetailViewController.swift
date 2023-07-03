//
//  DetailViewController.swift
//  QuickNote
//
//  Created by Sajid Shanta on 26/6/23.
//

import UIKit
import FirebaseFirestore

class DetailViewController: UIViewController {
    @IBOutlet weak var noteDetailTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var noteIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteDetailTextView.isEditable = false
        saveButton.isHidden = true
        
        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "xmark.bin"), style: .plain, target: self, action: #selector(deleteNote))
        deleteButton.tintColor = .red
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeNote))
        
        navigationItem.rightBarButtonItems = [deleteButton, composeButton]
        
        let note = DataSource.notes[noteIndex]
        title = note.title
//        print("details:", note.details)
        noteDetailTextView.text = note.details
    }
    
    @objc func deleteNote() {
//        DataSource.notes.remove(at: noteIndex)
//        DataSource.save()
        
        //create firebase instance
        let db = Firestore.firestore()
        // delete current Note
        db.collection("Notes").document(DataSource.notes[noteIndex].id).delete()
        
        // reload main data to update
        DataSource.loadNoteDataFromFirebase()
        
        // go back to previous view
        navigationController?.popViewController(animated: true)
    }
    
    @objc func composeNote() {
        noteDetailTextView.isEditable = true
        saveButton.isHidden = false
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
//        DataSource.notes[noteIndex].details = noteDetailTextView.text
        
        //Save the Edited verstion to firebase
        //create firebase instance
        let db = Firestore.firestore()
        // save updated version
        db.collection("Notes").document(DataSource.notes[noteIndex].id).updateData(["details": noteDetailTextView.text as String])
        
        saveButton.isHidden = true
        noteDetailTextView.isEditable = false
        
        // reload main data to update
        DataSource.loadNoteDataFromFirebase()
    }
}
