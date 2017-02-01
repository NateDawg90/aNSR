//
//  DBProvider.swift
//  aNSWR
//
//  Created by Hui Jun on 1/31/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DBProvider {
    private static let _instance = DBProvider();
    
    private let USERS = "users"
    private let DISPLAY_NAME = "displayName"
    private let EMAIL = "email"
    private let PASSWORD = "password"
    private let DATA = "data"
    
    static var instance: DBProvider {
        return _instance
    }
    
    var dbRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var usersRef: FIRDatabaseReference {
        return dbRef.child(USERS)
    }
    
    
    
    func saveUser(withID: String, email: String, password: String) {
        let data: Dictionary<String, String> = [EMAIL: email, PASSWORD: password];
        usersRef.child(withID).child(DATA).setValue(data)
    }
    
}



