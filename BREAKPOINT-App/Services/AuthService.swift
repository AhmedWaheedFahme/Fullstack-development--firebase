//
//  AuthService.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/4/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//  we make that for creating functions for register user and login user

import Foundation
import Firebase

class AuthService {
    
    static let instance = AuthService()
    
    func registerUser(withEmail email:String , andPassword password:String , userCreationComplete :  @escaping (_ status:Bool ,_ error:Error?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { ( user , error) in
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            let userData = ["provider": user.user.providerID , "email":user.user.email]
            DataService.instance.createDBuser(uid:user.user.uid, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
        }
    }
}
