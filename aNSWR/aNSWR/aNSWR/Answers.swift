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
    static let AnswerVoters = "voters"
    
    let answerText: String
    let userID: String
    let questionID: String
    let votes: Int
    let answerVoters: [String]
    let firebaseReference: FIRDatabaseReference?
    
    
    init(answerText: String, userID: String, questionID: String, votes: Int, voters: [String]) {
        self.answerText = answerText
        self.userID = userID
        self.questionID = questionID
        self.votes = votes
        self.answerVoters = voters
        self.firebaseReference = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        self.answerText = snapshotValue[Answer.AnswerTextKey] as! String
        self.userID = snapshotValue[Answer.AnswerUserKey] as! String
        self.questionID = snapshotValue[Answer.AnswerQuestionKey] as! String
        self.votes = snapshotValue[Answer.AnswerVotes] as! Int
        self.answerVoters = snapshotValue[Answer.AnswerVoters] as! [String]
        self.firebaseReference = snapshot.ref
    }
    
    func toDictionary() -> Any {
        return [
            Answer.AnswerTextKey:     self.answerText,
            Answer.AnswerUserKey:     self.userID,
            Answer.AnswerQuestionKey: self.questionID,
            Answer.AnswerVotes:       self.votes,
            Answer.AnswerVoters:      self.answerVoters
        ]
    }

    
    
}
