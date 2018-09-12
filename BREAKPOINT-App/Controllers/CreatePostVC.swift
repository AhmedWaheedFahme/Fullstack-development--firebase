//
//  CreatePostVC.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/7/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {
   
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendBtn.bindToKeyboard()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }
    @IBAction func sendBtnPress(_ sender: Any) {
        if textView.text != nil && textView.text != "Say something here..." {
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text, forUid: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in
                if isComplete {
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendBtn.isEnabled = true
                    print("there is an error:")
                }
            })
        }
        
    }
    
    @IBAction func closeBtnPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreatePostVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}






