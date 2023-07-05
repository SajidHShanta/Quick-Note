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
              let authentication = result?.user,
              let idToken = authentication.idToken
            else {
              return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: authentication.accessToken.tokenString)
            
            AuthService.shared.signIn(with: credential) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                // At this point, our user is signed in
                
                let username = result?.user.profile?.name ?? ""
                guard let email = result?.user.profile?.email else { return }
                let db = Firestore.firestore()
                db.collection("users")
                    .document(email)
                    .setData([
                        "username": username,
                        "email": email,
                    ], merge: true) { error in
                        if let error = error {
                            print(error)
                            return
                        }
                    }
                
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            }
            
//            Auth.auth().signIn(with: credential) { result, error in
//
//                let username = result?.user.displayName ?? ""
//                guard let email = result?.user.email else { return }
//
////                Auth.auth().fetchSignInMethods(forEmail: email) {
////                    (providers, error) in
////
////                    if let error = error {
////                        print(error.localizedDescription)
////                    } else if let providers = providers {
////                        print("snta:",providers)
////                    }
////                }
//
//                //                Auth.auth().fetchProviders(forEmail: email, completion: {
//                //                        (providers, error) in
//                //
//                //                        if let error = error {
//                //                            print(error.localizedDescription)
//                //                        } else if let providers = providers {
//                //                            print(providers)
//                //                        }
//                //                    })
//
//                let db = Firestore.firestore()
//
//                db.collection("users")
//                    .document(email)
//                    .setData([
//                        "username": username,
//                        "email": email,
//                    ], merge: true) { error in
//                        if let error = error {
//                            print(error)
//                            return
//                        }
//                    }
//
//                // At this point, our user is signed in
//                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
//                    sceneDelegate.checkAuthentication()
//                }
//
//            }
        }
    }
}
