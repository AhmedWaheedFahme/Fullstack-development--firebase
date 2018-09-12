//
//  GroupCell.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/10/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var memberCountLbl: UILabel!
    @IBOutlet weak var groupDescriptionLbl: UILabel!
    @IBOutlet weak var groupTitleLbl: UILabel!
    
    func configureCell(title:String , description : String , memberCount: Int){
        
        self.groupTitleLbl.text = title
        self.groupDescriptionLbl.text = description
        self.memberCountLbl.text = "\(memberCount) members."
    
    }
}
