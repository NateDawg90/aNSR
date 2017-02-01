//
//  Questions.swift
//  aNSWR
//
//  Created by Hui Jun on 1/31/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

struct Question {
    
    static let QuestionTextKey = "questionText"
    static let QuestionUserKey = "userID"
    
    let questionText: String
    let userID: String
    let firebaseReference: FIRDatabaseReference?

    
    init(questionText: String, userID: String, id: String = "") {
        self.questionText = questionText
        self.userID = userID
        self.firebaseReference = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        self.questionText = snapshotValue[Question.QuestionTextKey] as! String
        self.userID = snapshotValue[Question.QuestionUserKey] as! String
        self.firebaseReference = snapshot.ref
    }
    
    func toDictionary() -> Any {
        return [
            Question.QuestionTextKey: self.questionText,
            Question.QuestionUserKey: self.userID
        ]
    }
    
//    var questionId: String {
//        return _questionId;
//    }
//    
//    var username: String {
//        get {
//            return _username;
//        }
//    }
//    
//    var userId: String {
//        get {
//            return _userId;
//        }
//    }
//    
//    var questionText: String {
//        get {
//            return _questionText;
//        }
//    }
//    
//    var questionDate: TimeInterval {
//        get {
//            return _questionDate;
//        }
//    }
//    
//    
    
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
