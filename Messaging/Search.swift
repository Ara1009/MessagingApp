//
//  Search.swift
//  Messaging
//
//  Created by Aravind Subramanian on 11/17/17.
//  Copyright © 2017 Aravind Subramanian. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

class Search {
    
    private var _username: String!
    
    private var _userImg: String!
    
    private var _userKey: String!
    
    private var _userRef: DatabaseReference!
    
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    var username: String {
        
        return _username
        
    }
    
    var userImg: String {
        
        return _userImg
        
    }
    
    
    var userKey: String {
        
        return _userKey
    }
    
    init(username: String, sender: String) {
        _username = username
        
        _userImg = userImg
    }
    
    init(userKey: String, postData: Dictionary<String, AnyObject>) {
        
        _userKey = userKey
        
        if let username = postData["username"] as? String {
            
            _username = username
            
        }
        
        if let userImg = postData["userImg"] as? String {
            
            _userImg = userImg
        }
        
        _userRef = Database.database().reference().child("messages").child(_userKey)
    }
    
}
