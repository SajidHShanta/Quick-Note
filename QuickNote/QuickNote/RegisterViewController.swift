//
//  RegisterViewController.swift
//  QuickNote
//
//  Created by BTSL.SAJID on 21/6/23.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var middleNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var confirmPasswordTextField: PasswordTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.keyboardType = .emailAddress
        passwordTextField.textContentType = .newPassword
        confirmPasswordTextField.textContentType = .newPassword

        //placeholder color with opacity
        firstNameTextField.attributedPlaceholder =
        NSAttributedString(string: " Fist Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255.0, alpha: 0.6)])
        middleNameTextField.attributedPlaceholder =
        NSAttributedString(string: " Middle Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255.0, alpha: 0.6)])
        lastNameTextField.attributedPlaceholder =
        NSAttributedString(string: " Last Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255.0, alpha: 0.6)])
        emailTextField.attributedPlaceholder =
        NSAttributedString(string: " Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255.0, alpha: 0.6)])
        passwordTextField.attributedPlaceholder =
        NSAttributedString(string: " Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255.0, alpha: 0.6)])
        confirmPasswordTextField.attributedPlaceholder =
        NSAttributedString(string: " Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255.0, alpha: 0.6)])
        
        // add custom bottom border with extension
        firstNameTextField.addBottomBorder()
        middleNameTextField.addBottomBorder()
        lastNameTextField.addBottomBorder()
        emailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
        confirmPasswordTextField.addBottomBorder()
    }
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
    }
}
