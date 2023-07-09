//
//  HomeViewController.swift
//  QuickNote
//
//  Created by Sajid Shanta on 26/6/23.
//

import UIKit

class HomeViewController: UITableViewController {
    
    var notes: [Note] = []
    
    override func viewDidLoad() {
        self.setupLoader(forSec: 1)
        
        super.viewDidLoad()
        
        title = "Quick Notes"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        
//        let defaults = UserDefaults.standard
//        if let savedNotes = defaults.object(forKey: "notes") as? Data {
//            let jsonDecoder = JSONDecoder()
//            do {
//                DataSource.notes = try jsonDecoder.decode([Note].self, from: savedNotes)
//            } catch {
//                print("Faield to load data")
//            }
//        }
        
        DataSource.shared.loadNoteDataFromFirebase()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    
    @objc func loadList(notification: NSNotification){
        //load data here
        if let notes = notification.userInfo?["note"] as? [Note] {
            self.notes = notes
            self.tableView.reloadData()
        }
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
    
    @objc func addNote() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddNote") as? AddNoteViewController {
            
            // for bottom sheet
            //            if let sheet = vc.sheetPresentationController {
            //                sheet.detents = [.medium(), .large()]
            //                sheet.largestUndimmedDetentIdentifier = .medium
            //                sheet.prefersGrabberVisible = true
            //                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            //                sheet.prefersEdgeAttachedInCompactHeight = true
            //                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            //            }
            
            if let sheet = vc.sheetPresentationController {
                sheet.prefersGrabberVisible = true
            }
            
            present(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = self.notes[indexPath.row].title
        content.image = UIImage(systemName: self.notes[indexPath.row].doc == "" ? "paperclip.circle" : "paperclip.circle.fill")
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetail") as? DetailViewController {
            vc.note = notes[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
