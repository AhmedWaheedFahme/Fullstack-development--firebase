//
//  FeedCell.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/7/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    func configureCell(profilePic:UIImage , email :  String , content:String){
        self.profileImage.image = profilePic
        self.contentLbl.text = content
        self.emailLbl.text = email
        
    }
    
    
}
