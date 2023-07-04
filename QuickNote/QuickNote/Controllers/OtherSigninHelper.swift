//
//  OtherSigninHelper.swift
//  QuickNote
//
//  Created by Sajid Shanta on 4/7/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn

extension ViewController {
    
    func setupGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            
            if let error = error {
                //              showMessage(withTitle: "Error", message: error.localizedDescription)
                print(error.localizedDescription)
                return
            }
            
            guard
                let user = result?.user,
                let idToken = user.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken.tokenString,
                accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                
                let username = result?.user.displayName ?? ""
                guard let email = result?.user.email else { return }
                
                
                let db = Firestore.firestore()
                
                db.collection("users")
                    .document(result?.user.uid ?? UUID().uuidString)
                    .setData([
                        "username": username,
                        "email": email,
                    ]) { error in
                        if let error = error {
                            return
                        }
                    }
                
                // At this point, our user is signed in
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
                
            }
            
            
        }
    }
}
