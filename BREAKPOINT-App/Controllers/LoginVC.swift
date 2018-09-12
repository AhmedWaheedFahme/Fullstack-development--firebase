//
//  LoginVC.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/4/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailField: InsetTextField!
    @IBOutlet weak var passwordField: InsetTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self

    }
    @IBAction func closeBtnPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInBtnPress(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil {
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!, loginComplete: { (success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                    
                }else {
                    print(String (describing:loginError?.localizedDescription))
                }
                AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userCreationComplete: { (success, registertionError) in
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!
                            , loginComplete: { (success, nil) in
                            self.dismiss(animated: true, completion: nil)
                           print("Successfully register user!")
                        })
                    } else {
                        print(String (describing : registertionError?.localizedDescription))
                    }
                })
            })
        }
    }
    
}

extension LoginVC : UITextFieldDelegate {
    
    
}













