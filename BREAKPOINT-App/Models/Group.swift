//
//  Group.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/10/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//

import Foundation

class Group {
    
    private var _members : [String]
    private var _memberCount : Int
    private var _key : String
    private var _groupTitle : String
    private var _groupDesc : String
    
    var groupTitle : String {
        return _groupTitle
    }
    var groupDesc : String {
        return _groupDesc
    }
    var memberCount: Int {
        return _memberCount
    }
    var key : String {
        return _key
    }
    var members : [String] {
        return _members
    }
    
    init(title:String , description:String , members:[String] , memberCount:Int , key:String) {
        self._groupDesc = description
        self._groupTitle = title
        self._key = key
        self._memberCount = memberCount
        self._members = members
    }
    
    
    
    
    
    
}
