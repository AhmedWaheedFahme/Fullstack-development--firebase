//
//  UserCell.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/8/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var showing = false
    
    func configureCell(profileImage image:UIImage , email: String , isSelected : Bool){
        self.profileImage.image = image
        self.emailLbl.text = email
        if isSelected {
            self.checkImage.isHidden = false
        } else {
            self.checkImage.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected { // we make that cause when select the cell the check iamge will be appear 
            if showing == false {
                checkImage.isHidden = false
                showing = true
        } else {
            checkImage.isHidden = true
                showing = false
        }
    }
    }
}
