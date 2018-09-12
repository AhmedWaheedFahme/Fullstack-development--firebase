//
//  GroupFeedVC.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/10/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {
    
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var sendTxtField: InsetTextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var group : Group?
    var groupMessages = [Message]()
    
    func initData(forGroup group:Group){ // to show the data on the group feed vc
        self.group = group
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        groupTitleLbl.text = group?.groupTitle
        DataService.instance.getEmailsFor(group: group!) { (returedEmails) in
            self.membersLbl.text = returedEmails.joined(separator: ", ")
        }
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup:self.group!, handler: { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.tableView.reloadData()
            })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         sendBtnView.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
        
        if self.groupMessages.count > 4 { // we make that to animate the table view and show the newest meesage
            self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1 , section:0), at: .none, animated: true) // and we add - 1 cause the array starts from 0
            
        }
    }
    
    
    @IBAction func sendBtnPress(_ sender: Any) {
        if sendTxtField.text != "" {
            sendBtn.isEnabled = false
            sendTxtField.isEnabled = false
            DataService.instance.uploadPost(withMessage: sendTxtField.text!, forUid: Auth.auth().currentUser!.uid, withGroupKey: group?.key, sendComplete: { (complete) in
                if complete {
                    self.sendTxtField.text = ""
                    self.sendTxtField.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            })
        }
    }
    
    @IBAction func backBtnPress(_ sender: Any) {
        dismissDetails()
    }
    
}

extension GroupFeedVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else {return UITableViewCell()}
        let message = groupMessages[indexPath.row]
        DataService.instance.getUsername(forUID: message.senderId) { (email) in
            cell.configureCell(profileImage:UIImage(named:"defaultProfileImage")!, content: message.content, email: email)
        }
        return cell
    }
}











