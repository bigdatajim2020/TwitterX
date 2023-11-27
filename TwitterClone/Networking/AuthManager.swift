//
//  AuthManager.swift
//  TwitterClone
//
//  Created by Jim Yang on 2023-10-23.
//

import Foundation
import Firebase
import FirebaseAuthCombineSwift
import Combine

class AuthManager{
    static let shared = AuthManager()
    
    func registerUser(with email: String, password: String)-> AnyPublisher<User, Error> {
        return Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
    
    func loginUser(with email: String, password: String)->AnyPublisher<User, Error>{
        return Auth.auth().signIn(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
}
