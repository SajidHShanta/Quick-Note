//
//  AddNoteViewController.swift
//  QuickNote
//
//  Created by Sajid Shanta on 26/6/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class AddNoteViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var pickedImagePreviewView: UIImageView!
    
    var pickedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Note"
        
        pickedImagePreviewView.isHidden = true
    }
    
    
    @IBAction func uploadImageButtonPressed(_ sender: Any) {
        let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        pickedImagePreviewView.image = image
        pickedImagePreviewView.isHidden = false

        let imageName = "images/"+UUID().uuidString
        
        //write to local storage
//        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
//        if let jpegData = image.jpegData(compressionQuality: 0.8) {
//            try? jpegData.write(to: imagePath)
//        }
        
        // upload image to forebase
        let storageref = Storage.storage().reference()
        let imagenode = storageref.child(imageName)
        imagenode.putData(image.pngData()!) { metaData, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.pickedImage = imageName
            }
        }
        
        dismiss(animated: true) //dismiss the image picker
    }

//    func getDocumentsDirectory() -> URL {
//        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return path[0]
//    }
    
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
        
        guard let userId = Auth.auth().currentUser?.email else {return}
        
        db.collection("users").document("\(userId)/Notes/\(UUID().uuidString)").setData(["title": titleTextField.text ?? "", "details": detailsTextView.text ?? "", "image": pickedImage ?? ""]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.titleTextField.text = ""
                self.detailsTextView.text = ""
                self.pickedImagePreviewView.isHidden = true
                
                //TODO: minimize the sheet
                
                DataSource.loadNoteDataFromFirebase()
            }
        }
    }
}
