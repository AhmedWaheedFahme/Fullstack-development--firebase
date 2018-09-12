//
//  GroupFeedCell.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/10/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    
    @IBOutlet weak var profileImag: UIImageView!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!

    func configureCell(profileImage : UIImage , content: String , email:String){
        self.contentLbl.text = content
        self.emailLbl.text = email
        self.profileImag.image = profileImage
    }
}
