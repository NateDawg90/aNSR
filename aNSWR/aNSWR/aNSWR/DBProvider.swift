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
    private let USERNAME = "username"
    private let EMAIL = "email"
    private let PASSWORD = "password"
    private let DATA = "data"
    private let QUESTIONS = "questions"
    private let QUESTIONTEXT = "questionText"
    private let USERID = "userID"
    private let ANSWERS = "answers"
    private let ANSWERTEXT = "answerText"
    private let QUESTIONID = "questionID"
    private let VOTES = "votes"
    private let ANSWERVOTERS = "answerVoters"
    
    static var instance: DBProvider {
        return _instance
    }
    
    var dbRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var usersRef: FIRDatabaseReference {
        return dbRef.child(USERS)
    }
    
    var questionRef: FIRDatabaseReference {
        return dbRef.child(QUESTIONS).childByAutoId()
    }
    
    var answerRef: FIRDatabaseReference {
        return dbRef.child(ANSWERS).childByAutoId()
    }
  
    func saveUser(withID: String, email: String, username: String, password: String) {
        let data: Dictionary<String, String> = [EMAIL: email, USERNAME: username, PASSWORD: password]
        usersRef.child(withID).setValue(data)
    }
    
    func saveQuestion(questionText: String, answers: Array<String>, userID: String) {
        let data: Dictionary<String, AnyObject> = [QUESTIONTEXT: questionText as AnyObject, USERID: userID as AnyObject, ANSWERS: answers as AnyObject]
        questionRef.setValue(data)
    }
    
    func saveAnswer(answerText: String, userID: String, questionID: String, votes: Int, answerVoters: [String]) {
        let data: Dictionary<String, AnyObject> = [ANSWERTEXT: answerText as AnyObject, USERID: userID as AnyObject, QUESTIONID: questionID as AnyObject, VOTES: votes as AnyObject, ANSWERVOTERS: answerVoters as AnyObject]
        answerRef.setValue(data)
        
    }
}



