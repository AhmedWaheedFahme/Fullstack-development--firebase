//
//  Message.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/7/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//  
import Foundation

class Message {
    private var _content : String
    private var _senderId : String
    
    var content : String {
        return _content
    }
    var senderId : String {
        return _senderId
    }
    
    init(content:String , senderId: String) {
        self._senderId = senderId
        self._content = content
    }
}
