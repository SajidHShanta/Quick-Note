//
//  ResetPasswordViewController.swift
//  QuickNote
//
//  Created by Sajid Shanta on 3/7/23.
//

import UIKit
import FirebaseAuth

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        
        emailTextField.keyboardType = .emailAddress
        
        //placeholder color with opacity
        emailTextField.attributedPlaceholder =
        NSAttributedString(string: " Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255.0, alpha: 0.6)])
        
        // add custom bottom border with extension
        emailTextField.addBottomBorder()
    }
    
    @IBAction func EmailSendButtonPressed(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
            if let error = error {
                self.errorLabel.text = error.localizedDescription
                self.errorLabel.isHidden = false
//                let ac = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//                self.present(ac, animated: true)
                return
            }
            self.errorLabel.text = ""
            self.errorLabel.isHidden = true
            
            let ac = UIAlertController(title: "Check Your Mail", message: "A password reset link has been sent", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default){_ in
                self.dismiss(animated: true)
            })
            self.present(ac, animated: true)
        }
    }
}
