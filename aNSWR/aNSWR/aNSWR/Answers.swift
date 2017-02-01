//
//  Answers.swift
//  aNSWR
//
//  Created by Nathan Johnson on 2/1/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

struct Answer {
    
    static let AnswerTextKey = "AnswerText"
    static let AnswerUserKey = "userID"
    static let AnswerQuestionKey = "questionID"
    
    let answerText: String
    let userID: String
    let questionID: String
    let firebaseReference: FIRDatabaseReference?
    
    
    init(answerText: String, userID: String, questionID: String, id: String = "") {
        self.answerText = answerText
        self.userID = userID
        self.questionID = questionID
        self.firebaseReference = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        self.answerText = snapshotValue[Answer.AnswerTextKey] as! String
        self.userID = snapshotValue[Answer.AnswerUserKey] as! String
        self.questionID = snapshotValue[Question.QuestionUserKey] as! String
        self.firebaseReference = snapshot.ref
    }
    
    func toDictionary() -> Any {
        return [
            Answer.AnswerTextKey: self.answerText,
            Answer.AnswerUserKey: self.userID
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
