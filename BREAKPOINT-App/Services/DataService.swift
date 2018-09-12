//
//  DataService.swift
//  BREAKPOINT-App
//
//  Created by Ahmed Waheed on 9/4/18.
//  Copyright © 2018 Ahmed Waheed. All rights reserved.
//


import Foundation
import Firebase

let DB_BASE = Database.database().reference() // we make that to allow to access the database url of database

class DataService {
    
    static let instance = DataService() // to make it accessable at any other class
    
    //  we make it private to can not access from any class or any where and make a child to make an appened a folder or file in the database for users and groups etc
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    // we make it public to can use it and access the private by it
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS : DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED : DatabaseReference {
        return _REF_FEED
    }
    
    // we need a function to push info to the database or to create a firebase user
    func createDBuser(uid:String , userData:Dictionary<String,Any>){
        REF_USERS.child(uid).updateChildValues(userData) // update means i want to put inside that id his data like email
    }
    
    func getUsername(forUID uid:String ,handler: @escaping (_ username:String) -> ()){ // to covert fom uid to actual useremail
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                    
                }
            }
        }
    }
    
    func uploadPost(withMessage message :String , forUid uid:String , withGroupKey groupKey:String? , sendComplete : @escaping (_ status : Bool) -> ()){
        if groupKey != nil {
            // send to groups ref
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message , "senderID" : uid])
            sendComplete(true)
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content":message , "senderID":uid])
        sendComplete(true)
        }
    }
    
    func getAllFeedMessages(handler: @escaping (_ messages : [Message] ) -> ()){ // we make it to display posts from firebase on tableView
        var messageArray = [Message]() // we inite it now
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else {return} // we make it to download data from firebase
            
            // we need to make a cycle for all messages so
            for messages in feedMessageSnapshot {
                let content = messages.childSnapshot(forPath: "content").value as! String
                let senderId = messages.childSnapshot(forPath: "senderID").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message) // to add the new message to the array
            }
            handler(messageArray) // we can now download all messages and pass it into the table view
        }
    }
    
    func getAllMessagesFor(desiredGroup : Group , handler : @escaping (_ messageArray:[Message]) -> ()){
        var groupMessageArray = [Message]()
        REF_GROUPS.child(desiredGroup.key).child("messages").observeSingleEvent(of:.value) { (groupMessageSnapshot) in
            guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for groupMessage in groupMessageSnapshot {
                let content = groupMessage.childSnapshot(forPath: "content").value as! String
                let senderId = groupMessage.childSnapshot(forPath: "senderID").value as! String
                let groupMessage = Message(content: content, senderId: senderId)
                groupMessageArray.append(groupMessage)
            }
            handler(groupMessageArray)
        }
    }
    
    func getEmail(forSearchQuery query:String , handler : @escaping (_ emailArray: [String])->()){ // we make that to search for emails and add them into groups
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
       handler(emailArray)
        }
    }
    
    func getIds(forUsernames username: [String] , handler: @escaping (_ uidArray: [String]) -> () ){// we make it to convert from useremail to user ID
       var idArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if username.contains(email){
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }
    
    func getEmailsFor(group:Group , handler: @escaping (_ emailArray: [String]) -> ()){ // we make it to convert from uid to userEmail in group feed vc
       var emailArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for user in userSnapshot {
            
                if group.members.contains(user.key) {
               let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func createGroup(withTitle title:String , andDescription description : String , forUserIds ids: [String] , handler : @escaping (_ groupCreated : Bool) -> ()){ // we make that function to create a group
        REF_GROUPS.childByAutoId().updateChildValues(["title":title , "description" : description , "members" : ids])
        handler(true)
    }
    
    func getAllGroups(handler : @escaping (_ groupsArray : [Group]) ->()){
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for group in groupSnapshot {
                let memberArray = group.childSnapshot(forPath: "members").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!) {
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let description = group.childSnapshot(forPath: "description").value as! String
                    let group = Group(title: title, description: description, members: memberArray, memberCount: memberArray.count, key: group.key)
                    groupsArray.append(group)
                }
            }
            handler(groupsArray)
        }
    }
    }
