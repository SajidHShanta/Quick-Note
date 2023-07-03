//
//  ViewController.swift
//  QuickNote
//
//  Created by BTSL.SAJID on 21/6/23.
//

import UIKit

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
        
        // for now other option is hidden
        otherOptions.isHidden = true
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
            
            //adjustForKeyboard
//            let notificationCenter = NotificationCenter.default
//            notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//            notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        default:
            break
        }
    }
    
    @IBAction func facebookSignup(_ sender: Any) {
        
    }
    
    @IBAction func googleSignup(_ sender: Any) {
        
    }
    
    @IBAction func appleSignup(_ sender: Any) {
        
    }
    
//    //MARK: adjust for keyboard
//    @objc func keyboardWillShow(notification: Notification) {
//        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
//        if isInRegistarPage && self.view.frame.origin.y == 0 {
//            let keyboadHeight = keyboardValue.cgRectValue.height
////            let bottomSpace = self.view.frame.height - (registerSegmentView.frame.origin.y + registerSegmentView.frame.height)
//            let bottomSpace = (self.view.window?.windowScene?.keyWindow?.frame.height)! - (registerSegmentView.frame.origin.y + registerSegmentView.frame.height)
//
//            if keyboadHeight > (bottomSpace + 10) {
////                let h = keyboadHeight - bottomSpace + 10
////                self.view.frame.origin.y = -h
//            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: -(keyboadHeight-bottomSpace))
//            }
//        }
//    }
//    @objc func keyboardWillHide() {
//        // back to normal view
//        self.view.frame.origin.y = 0
//    }
}

