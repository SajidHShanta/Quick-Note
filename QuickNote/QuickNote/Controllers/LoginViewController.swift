//
//  LoginViewController.swift
//  QuickNote
//
//  Created by BTSL.SAJID on 21/6/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: PasswordTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginErrorLabel: UILabel!
    
    var buttonPressed = false {
        didSet {
            loginButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loginButton.isEnabled = true
            }
//            if buttonPressed {
//                loginButton.isEnabled = false
//            } else {
//                loginButton.isEnabled = true
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginErrorLabel.isHidden = true
        
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
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
//        let userRequest = LoginUserRequest(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        
        buttonPressed.toggle() // disable button for 1 sec
        
        let credential = EmailAuthProvider.credential(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "")

        AuthService.shared.signIn(with: credential) { error in
            if let error = error {
                self.loginErrorLabel.text = error.localizedDescription
                self.loginErrorLabel.isHidden = false
                
                print(error.localizedDescription)
                return
            }
            
            self.setupLoader(forSec: 1)
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
//        AuthService.shared.signIn(with: userRequest) { error in
//            if let error = error {
//                self.loginErrorLabel.text = error.localizedDescription
//                self.loginErrorLabel.isHidden = false
//
//                print(error.localizedDescription)
//                return
//            }
//            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
//                sceneDelegate.checkAuthentication()
//            }
//        }
    }
}
