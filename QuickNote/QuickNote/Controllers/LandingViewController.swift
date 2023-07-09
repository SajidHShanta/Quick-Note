//
//  HomeViewController.swift
//  QuickNote
//
//  Created by Sajid Shanta on 25/6/23.
//

import UIKit
import GoogleSignIn
class LandingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Quick Notes"
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
}
