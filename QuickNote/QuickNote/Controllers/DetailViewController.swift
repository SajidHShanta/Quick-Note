//
//  DetailViewController.swift
//  QuickNote
//
//  Created by Sajid Shanta on 26/6/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import PDFKit
import UniformTypeIdentifiers

class DetailViewController: UIViewController {
    @IBOutlet weak var noteDetailTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var viewForPDF: UIView!
    
    var noteIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLoader(forSec: 1)
        
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
        
//        if note.image != "" {
//            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            let pathURL = path.appending(path: note.image)
//            noteImage.image = UIImage(contentsOfFile: pathURL.path())
//        } else {
//            noteImage.isHidden = true
//        }
        
      
        
        if note.doc != "" {
            //create firebase instance
            let db = Firestore.firestore()
            
            let storageref = Storage.storage().reference()
            
            // Create a reference to the file you want to download
            let docRef = storageref.child(note.doc)
            
            // Create local filesystem URL
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let localURL = path.appending(path: note.doc)

            // Download to the local filesystem
            let downloadTask = docRef.write(toFile: localURL) { url, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    guard let url = url else { return }
                    guard let data = try? Data(contentsOf: url) else { return }
                    
                    if note.doc.hasSuffix("pdf") {
                        if let document = PDFDocument(data: data){
                            var pdfviewObject = PDFView()
                            pdfviewObject = PDFView(frame: self.viewForPDF.bounds)
                            self.viewForPDF.addSubview(pdfviewObject)
                            pdfviewObject.document = document
                            pdfviewObject.autoScales = true
                        }
                        self.viewForPDF.isHidden = false
                        self.noteImage.isHidden = true
                    } else if note.doc.hasSuffix("png") {
                        self.noteImage.image = UIImage(data: data)
                        self.noteImage.isHidden = false
                        self.viewForPDF.isHidden = true
                    } else {
                        self.noteImage.isHidden = true
                        self.viewForPDF.isHidden = true
                    }
                }
            }
        } else {
            noteImage.isHidden = true
            viewForPDF.isHidden = true
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
