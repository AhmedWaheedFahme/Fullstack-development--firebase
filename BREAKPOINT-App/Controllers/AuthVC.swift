//
//  AuthVC.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/4/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func googleSignInBtnPress(_ sender: Any) {
    }
    @IBAction func facebookSignInBtnPress(_ sender: Any) {
    }
    @IBAction func signInWithEmailPress(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
        
    }
}
