//
//  ViewController.swift
//  QuickNote
//
//  Created by BTSL.SAJID on 21/6/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController {
    @IBOutlet weak var segmentedPicker: UISegmentedControl!
    @IBOutlet weak var loginSegmentView: UIView!
    @IBOutlet weak var registerSegmentView: UIView!
    @IBOutlet weak var otherOptions: UIStackView!
    
    var isInRegistarPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        self.view.bringSubviewToFront(loginSegmentView)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            hideKeyboard()
            isInRegistarPage = false
            
//            self.view.bringSubviewToFront(loginSegmentView)
            loginSegmentView.isHidden = false
            registerSegmentView.isHidden = true
        case 1:
            hideKeyboard()
            isInRegistarPage = true
            
//            self.view.bringSubviewToFront(registerSegmentView)
            loginSegmentView.isHidden = true
            registerSegmentView.isHidden = false
        default:
            break
        }
    }
    @IBAction func googleSignin(_ sender: Any) {
        setupGoogle()
    }
    
    @IBAction func facebookSignin(_ sender: Any) {
    }
    
    @IBAction func appleSignin(_ sender: Any) {
    }
}
