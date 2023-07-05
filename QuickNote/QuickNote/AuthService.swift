//
//  AuthService.swift
//  QuickNote
//
//  Created by BTSL.SAJID on 21/6/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    public static let shared = AuthService() //singleton
    
    private init() { }
    
    
    /// A Method to register the user
    /// - Parameters:
    ///   - userRequest: user information (username, email, password)
    ///   - completion: A completion with two values...
    ///     - Bool: wasRegistered - determine if the user was registered and saved in the database correctly
    ///     - Error?:  An optional error if firebase provides once
    func registerUser(with userRequest: RegisterUserRequest,
                              completion: @escaping (Bool, Error?) -> Void) {
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        // create user with authentication
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            // now we have user
            
            let db = Firestore.firestore()
            
            db.collection("users")
//                .document(resultUser.uid)
                .document(email)
                .setData([
                    "username": username,
                    "email": email,
                    "password": password
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    
                    completion(true, nil) // successfull!
                }
        }
    }
    
    public func signIn(with userCredential: AuthCredential, completion: @escaping (Error?)->Void) {
        Auth.auth().signIn(with: userCredential) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
//    public func signIn(with userRequest: LoginUserRequest, completion: @escaping (Error?)->Void) {
//        Auth.auth().signIn(
//            withEmail: userRequest.email,
//            password: userRequest.password
//        ) { result, error in
//            if let error = error {
//                completion(error)
//                return
//            } else {
//                completion(nil)
//            }
//        }
//    }

    public func signOut(completion: @escaping (Error?)->Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
}
