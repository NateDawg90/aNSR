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
    static let AnswerVotes = "votes"
    
    let answerText: String
    let userID: String
    let questionID: String
    let votes: Int
    let firebaseReference: FIRDatabaseReference?
    
    
    init(answerText: String, userID: String, questionID: String) {
        self.answerText = answerText
        self.userID = userID
        self.questionID = questionID
        self.votes = 0
        self.firebaseReference = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        self.answerText = snapshotValue[Answer.AnswerTextKey] as! String
        self.userID = snapshotValue[Answer.AnswerUserKey] as! String
        self.questionID = snapshotValue[Answer.AnswerQuestionKey] as! String
        self.votes = snapshotValue[Answer.AnswerVotes] as! Int
        self.firebaseReference = snapshot.ref
    }
    
    func toDictionary() -> Any {
        return [
            Answer.AnswerTextKey:     self.answerText,
            Answer.AnswerUserKey:     self.userID,
            Answer.AnswerQuestionKey: self.questionID,
            Answer.AnswerVotes:       self.votes
        ]
    }

    
    
}
