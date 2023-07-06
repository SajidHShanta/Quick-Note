//
//  DetailViewController.swift
//  QuickNote
//
//  Created by Sajid Shanta on 26/6/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class DetailViewController: UIViewController {
    @IBOutlet weak var noteDetailTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var noteImage: UIImageView!
    
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
        
        if note.image != "" {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let pathURL = path.appending(path: note.image)
            noteImage.image = UIImage(contentsOfFile: pathURL.path())
        } else {
            noteImage.isHidden = true
        }
    }
    
    @objc func deleteNote() {
        let vc = UIAlertController(title: "Are you Sure?", message: "Delete this note premanently", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Delete", style: .destructive) {_ in
            guard let userId = Auth.auth().currentUser?.email else {return}

            //create firebase instance
            let db = Firestore.firestore()
            // delete current Note
            db.collection("users/\(userId)/Notes").document(DataSource.notes[self.noteIndex].id).delete()
            
            // reload main data to update
            DataSource.loadNoteDataFromFirebase()
            
            // go back to previous view
            self.navigationController?.popViewController(animated: true)
        })
        vc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(vc, animated: true)
    }
    
    @objc func composeNote() {
        noteDetailTextView.isEditable = true
        saveButton.isHidden = false
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
//        DataSource.notes[noteIndex].details = noteDetailTextView.text
        
        guard let userId = Auth.auth().currentUser?.email else {return}
        
        //Save the Edited verstion to firebase
        //create firebase instance
        let db = Firestore.firestore()
        // save updated version
        db.collection("users/\(userId)/Notes").document(DataSource.notes[noteIndex].id).updateData(["details": noteDetailTextView.text as String])
        
        saveButton.isHidden = true
        noteDetailTextView.isEditable = false
        
        // reload main data to update
        DataSource.loadNoteDataFromFirebase()
    }
}
