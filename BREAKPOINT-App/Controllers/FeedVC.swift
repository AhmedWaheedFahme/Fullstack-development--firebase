//
//  FeedVC.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/3/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) { // we make that to appear messages in the screen
        super.viewDidAppear(animated)
        DataService.instance.getAllFeedMessages { (returnedToMessages) in
            self.messageArray = returnedToMessages.reversed() // we make that to reverse the feed posts
            self.tableView.reloadData() // to appear the data automatic not appear when we close the app and open it again
        }
    }
}

extension FeedVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell")as? FeedCell else { return UITableViewCell()}
        let image = UIImage(named:"defaultProfileImage")
        let message = messageArray[indexPath.row]
        
        DataService.instance.getUsername(forUID: message.senderId) { (returnedUsername) in
            cell.configureCell(profilePic: image!, email:returnedUsername , content: message.content)
        }
        
        return cell
    }
}

