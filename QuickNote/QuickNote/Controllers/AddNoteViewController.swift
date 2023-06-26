//
//  AddNoteViewController.swift
//  QuickNote
//
//  Created by Sajid Shanta on 26/6/23.
//

import UIKit

class AddNoteViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Note"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: HomeViewController.self, action: .none)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let newNote = Note(title: titleTextField.text ?? "", details: detailsTextView.text ?? "")
        dataSource.notes.append(newNote)
        dataSource.save()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil) //reload main table
    }
}
