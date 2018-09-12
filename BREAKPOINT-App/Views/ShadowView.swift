//
//  ShadowView.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/4/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//  we make that to make a shadow around the login view

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        super.awakeFromNib()
    }
}
