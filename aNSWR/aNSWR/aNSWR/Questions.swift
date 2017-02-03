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
    static let QuestionAnswersKey = "answers"
    static let QuestionVotersKey = "questionVoters"
    
    let questionText: String
    let answers: Array<String>
    let userID: String
    let questionVoters: Array<String>
    let firebaseReference: FIRDatabaseReference?

    
    init(questionText: String, answers: Array<String>, userID: String, id: String = "", questionVoters: Array<String>) {
        self.questionText = questionText
        self.answers = answers
        self.userID = userID
        self.questionVoters = questionVoters
        self.firebaseReference = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        self.questionText = snapshotValue[Question.QuestionTextKey] as! String
        self.answers = snapshotValue[Question.QuestionAnswersKey] as! Array<String>
        self.userID = snapshotValue[Question.QuestionUserKey] as! String
        self.questionVoters = snapshotValue[Question.QuestionVotersKey] as! Array<String>
        self.firebaseReference = snapshot.ref
    }
    
    func toDictionary() -> Any {
        return [
            Question.QuestionTextKey: self.questionText,
            Question.QuestionTextKey: self.answers,
            Question.QuestionUserKey: self.userID,
            Question.QuestionVotersKey: self.questionVoters
        ]
    }
        
}
