//
//  Questions.swift
//  aNSWR
//
//  Created by Andrew on 1/31/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

struct Question {
    
    var _username = String()
    var _userId = String()
    var _questionId = String()
    var _questionText = String()
    var _questionDate = TimeInterval()
    var _key = String()
    
    init(username: String, userId: String, questionId: String, questionText: String, questionDate: TimeInterval) {
        _username = username
        _userId = userId
        _questionId = questionId
        _questionText = questionText
        _questionDate = questionDate
    }
    
    var questionId: String {
        return _questionId;
    }
    
    var username: String {
        get {
            return _username;
        }
    }
    
    var userId: String {
        get {
            return _userId;
        }
    }
    
    var questionText: String {
        get {
            return _questionText;
        }
    }
    
    var questionDate: TimeInterval {
        get {
            return _questionDate;
        }
    }
    
    

//    init(snapshot: FIRDatabaseReference){
//        
//        self.ref = snapshot.ref
//        self.key = snapshot.key
//        self.username = (snapshot.value! as! NSDictionary)["username"] as! String
//        self.userId = (snapshot.value! as! NSDictionary)["userId"] as! String
//        self.questionId = (snapshot.value! as! NSDictionary)["questionId"] as! String
//        self.questionText = (snapshot.value! as! NSDictionary)["questionText"] as! String
//        self.questionDate = (snapshot.value! as! NSDictionary)["questionDate"] as! String
//        self.username = (snapshot.value! as! NSDictionary)["username"] as! String
//
//    }
//    init(username: String, userId: String, questionId: String, questionText: String, questionDate: TimeInterval){
//        
//        self.username = username
//        self.userId = userId
//        self.questionId = questionId
//        self.questionText = questionText
//        self.questionDate = questionDate
//    }
//    
//    func toAnyObject() -> [String: Any] {
//        return ["username": username, "userId": userId, "questionId": questionId, "questionText": questionText, "questionDate": questionDate]
//    }
    
}
