//
//  SceneDelegate.swift
//  QuickNote
//
//  Created by BTSL.SAJID on 21/6/23.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setupWindow(with: scene)
        self.checkAuthentication()
        
        //         create new user
//        let userRequest = RegisterUserRequest(
//            username: "de",
//            email: "d@e.com",
//            password: "password123"
//        )
//        AuthService.shared.registerUser(with: userRequest) { wasRegistered, error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            print("wasRegistered: ", wasRegistered)
//        }
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    public func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            // login page
            self.goToController(with: "LoginPage")
        } else {
            //home page
            self.goToController(with: "HomePage")
        }
    }
    
    private func goToController(with viewControllerIdentifier: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        DispatchQueue.main.async { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
                
            } completion: { [weak self] _ in
                let vc : UIViewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as UIViewController
                vc.modalPresentationStyle = .fullScreen
                self?.window?.rootViewController = vc
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
}
