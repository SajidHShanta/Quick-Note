//
//  LoginViewController.swift
//  QuickNote
//
//  Created by BTSL.SAJID on 21/6/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.keyboardType = .emailAddress
        passwordTextField.textContentType = .password
        
        //placeholder color with opacity
        emailTextField.attributedPlaceholder =
        NSAttributedString(string: " Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255.0, alpha: 0.6)])
        passwordTextField.attributedPlaceholder =
        NSAttributedString(string: " Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255.0, alpha: 0.6)])
        
        // add custom bottom border with extension
        emailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
    }
}
