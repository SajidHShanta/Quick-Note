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
import UniformTypeIdentifiers


//class AddNoteViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
class AddNoteViewController: UIViewController, UIDocumentPickerDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var attachmentNameView: UILabel!
    
//    var pickedImage: String?
    var pickedDoc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Note"
        
        attachmentNameView.isHidden = true
    }
    
    
//    @IBAction func uploadImageButtonPressed(_ sender: Any) {
//        let picker = UIImagePickerController()
//        picker.allowsEditing = true
//        picker.delegate = self
//        present(picker, animated: true)
//    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let image = info[.editedImage] as? UIImage else { return }
//
//        pickedImagePreviewView.image = image
//        pickedImagePreviewView.isHidden = false
//
//        let imageName = "images/"+UUID().uuidString
//
//        //write to local storage
////        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
////        if let jpegData = image.jpegData(compressionQuality: 0.8) {
////            try? jpegData.write(to: imagePath)
////        }
//
//        // upload image to forebase
//        let storageref = Storage.storage().reference()
//        let imagenode = storageref.child(imageName)
//        imagenode.putData(image.pngData()!) { metaData, error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                self.pickedImage = imageName
//            }
//        }
//
//        dismiss(animated: true) //dismiss the image picker
//    }
    
    //    func getDocumentsDirectory() -> URL {
    //        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    //        return path[0]
    //    }
    
    @IBAction func uploadDocumentButtonPressed(_ sender: Any) {
        
        var documentPicker: UIDocumentPickerViewController!
        
        let supportedTypes: [UTType] = [.image, .pdf]
        documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let filenameWithEndBracket = URL(fileURLWithPath: String(describing:urls)).lastPathComponent // print: myfile.pdf]
        let filename = String(filenameWithEndBracket.dropLast(1)) // myfile.pdf
        // display picked file in a view
        guard let url = urls.first else { return }
        guard let doc = try? Data(contentsOf: url) else { return }
        
        guard let userId = Auth.auth().currentUser?.email else {return}

        let documentID = "documents/\(userId)/\(filename)"
        
//         upload document to forebase
        let storageref = Storage.storage().reference()
        let docNode = storageref.child(documentID)
        docNode.putData(doc) { metaData, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.pickedDoc = documentID
                
                self.attachmentNameView.text = filename
                self.attachmentNameView.isHidden = false
            }
        }
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
        
        guard let userId = Auth.auth().currentUser?.email else {return}
        
        db.collection("users").document("\(userId)/Notes/\(UUID().uuidString)").setData(["title": titleTextField.text ?? "", "details": detailsTextView.text ?? "", "doc": pickedDoc ?? ""]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.titleTextField.text = ""
                self.detailsTextView.text = ""
                self.attachmentNameView.isHidden = true
                
                //TODO: minimize the sheet
                
                DataSource.shared.loadNoteDataFromFirebase()
            }
        }
    }
}
