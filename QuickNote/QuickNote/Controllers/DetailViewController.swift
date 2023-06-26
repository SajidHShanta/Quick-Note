//
//  DetailViewController.swift
//  QuickNote
//
//  Created by Sajid Shanta on 26/6/23.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var noteDetailTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var noteIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteDetailTextView.isEditable = false
        saveButton.isHidden = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonPressed))
        
        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "xmark.bin"), style: .plain, target: self, action: #selector(deleteNote))
        deleteButton.tintColor = .red
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeNote))
        
        navigationItem.rightBarButtonItems = [deleteButton, composeButton]
        
        let note = dataSource.notes[noteIndex]
        title = note.title
        print("details:", note.details)
        noteDetailTextView.text = note.details
    }
    
    @objc func logoutButtonPressed(_ sender: Any) {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    @objc func deleteNote() {
        dataSource.notes.remove(at: noteIndex)
        dataSource.save()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil) //reload main table
        navigationController?.popViewController(animated: true) // go back to previous view
    }
    
    @objc func composeNote() {
        print("compose")
        noteDetailTextView.isEditable = true
        saveButton.isHidden = false
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        dataSource.notes[noteIndex].details = noteDetailTextView.text
        saveButton.isHidden = true
        noteDetailTextView.isEditable = false
    }
}
