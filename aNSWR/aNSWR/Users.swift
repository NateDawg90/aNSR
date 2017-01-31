//
//  users.swift
//  aNSWR
//
//  Created by Hui Jun on 1/31/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import Foundation

struct User {
    
    private var _email = String()
    private var _id = String()
    private var _username = String()
    
    init(id: String, email: String, username: String) {
        _id = id
        _email = email
        _username = username
    }
    
    var id: String {
        return _id;
    }
    
    var email: String {
        get {
            return _email;
        }
    }
    
    var username: String {
        get {
            return _username;
        }
    }
}
