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
    @IBOutlet weak var registerErrorLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    var buttonPressed = false {
        didSet {
            registerButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.registerButton.isEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerErrorLabel.isHidden = true
        
        emailTextField.keyboardType = .emailAddress
        passwordTextField.textContentType = .newPassword
        confirmPasswordTextField.textContentType = .newPassword
        
        usernameTextField.spellCheckingType = .no
        usernameTextField.autocorrectionType = .no
        
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
        buttonPressed.toggle()
        
        if passwordTextField.text != confirmPasswordTextField.text {
            self.registerErrorLabel.text = "New password and confirm password don't match"
            self.registerErrorLabel.isHidden = false
            return
        }

        let userRequest = RegisterUserRequest(username: usernameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
            
        
        AuthService.shared.registerUser(with: userRequest) { isRegistered, error in
            if let error = error {
                self.registerErrorLabel.text = error.localizedDescription
                self.registerErrorLabel.isHidden = false
                
                print(error.localizedDescription)
                return
            }
            
            self.setupLoader(forSec: 1)
            
            print("isRegistered:",isRegistered)
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}
