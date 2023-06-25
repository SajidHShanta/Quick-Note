//
//  RegisterController.swift
//  QuickNote
//
//  Created by BTSL.SAJID on 21/6/23.
//

import UIKit

class RegisterController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var confirmPasswordTextField: PasswordTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.keyboardType = .emailAddress
        passwordTextField.textContentType = .newPassword
        confirmPasswordTextField.textContentType = .newPassword

        //placeholder color with opacity
        usernameTextField.attributedPlaceholder =
        NSAttributedString(string: " Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255.0, alpha: 0.6)])
        emailTextField.attributedPlaceholder =
        NSAttributedString(string: " Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255.0, alpha: 0.6)])
        passwordTextField.attributedPlaceholder =
        NSAttributedString(string: " Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255.0, alpha: 0.6)])
        confirmPasswordTextField.attributedPlaceholder =
        NSAttributedString(string: " Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 99.0/255.0, green: 99/255.0, blue: 102.0/255.0, alpha: 0.6)])
        
        // add custom bottom border with extension
        usernameTextField.addBottomBorder()
        emailTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
        confirmPasswordTextField.addBottomBorder()
    }
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        let userRequest = RegisterUserRequest(username: usernameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        
        AuthService.shared.registerUser(with: userRequest) { isRegistered, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("isRegistered:",isRegistered)
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}
