//
//  DetailsVC.swift
//  aNSWR
//
//  Created by Hui Jun on 2/1/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit
import Firebase

class DetailsVC: UIViewController {
    var questionText = String()

    var answers = [String]()
    var questionID = String()
    var votes = [Int]()
    var didVoteAns = [Bool]()
    var loginUserID = String()
    var answersID = [String]()
    var voters = [[String]]()
    var answerKey = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTextButton()
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("answers").observeSingleEvent(of: .value, with: { (snapshot) in
            //get answer key
            for singleSnap in snapshot.children.allObjects {
                let answer = singleSnap as! FIRDataSnapshot
                self.answerKey = answer.key
                
                let answerSnap = singleSnap as? FIRDataSnapshot
                let value = answerSnap?.value as? NSDictionary
                if (value?["questionID"] as? String == self.questionID) {
                    self.answersID.append(self.answerKey)
                    self.votes.append((value?["votes"] as? Int)!)
                    self.voters.append((value?["answerVoters"] as! [String]))
                    let voters = value?["answerVoters"] as? Array<String>
                    if (voters?.contains(self.loginUserID))! {
                        self.didVoteAns.append(true)
                    } else {
                        self.didVoteAns.append(false)
                    }
                }
            }
  
            self.changeButtonSign()
            print("....................................")
            print(self.didVoteAns)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.main.async(execute: {
//            self.updateData(questionID: self.questionID)
//        })
//        self.DetailsVC.setNeedsDisplay()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var answer1Text: UILabel!
    @IBOutlet weak var answer2Text: UILabel!
    @IBOutlet weak var answer3Text: UILabel!
    @IBOutlet weak var answer4Text: UILabel!
    @IBOutlet weak var answer5Text: UILabel!

    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    @IBOutlet weak var answer5Button: UIButton!
    
    @IBOutlet weak var AnswerTextButton: UIButton!
    @IBOutlet weak var moreAnswerText: UITextField!
    
    @IBAction func addAnswerButton(_ sender: AnyObject) {
        if !(moreAnswerText.text?.isEmpty)! {
            DBProvider.instance.saveAnswer(answerText: (moreAnswerText.text)!, userID: (FIRAuth.auth()?.currentUser?.uid)!, questionID: self.questionID, votes: 0, answerVoters: [""])
            self.answers.append(moreAnswerText.text!)
            DBProvider.instance.questionRef.child(self.questionID).updateChildValues(["answers": self.answers])
        } else {
            showAlertMessage(title: "Answers Required", message: "Please fill in the answer text field");
        }
    }
    
//    func updateData(questionID: String) {
//        self.questionText.removeAll()
//        self.answers.removeAll()
//        self.votes.removeAll()
//        self.didVoteAns.removeAll()
//        
//        var ref: FIRDatabaseReference!
//        ref = FIRDatabase.database().reference()
//        ref.child("questions").child(questionID).observeSingleEvent(of: .value, with: { (snapshot) in
//        
//            let value = snapshot.value as? NSDictionary
//            self.questionText = value?["questionText"] as? String ?? ""
//            self.answers = value?["answers"] as? Array<AnyObject> as! [String]? ?? [("" as AnyObject) as! String]
//        })
//        
//        for answer in self.answers {
//            ref.child("answers").observeSingleEvent(of: .value, with: { (snapshot) in
//                if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
//                    for snap in snapshots {
//                        for singleSnap in snapshot.children.allObjects {
//                            let answer = singleSnap as! FIRDataSnapshot
//                            self.answerKey = answer.key
//                        }
//                        let value = snap.value as? NSDictionary
//                        if ((value?["answerText"] as? String == answer) &&
//                            (value?["questionID"] as? String == self.questionID)) {
//                            self.answersID.append(self.answerKey)
//                            self.votes.append((value?["votes"] as? Int)!)
//                            let voters = value?["answerVoters"] as? Array<String>
//                            if (voters?.contains(self.loginUserID))! {
//                                self.didVoteAns.append(true)
//                            } else {
//                                self.didVoteAns.append(false)
//                            }
//                        }
//                    }
//                }
                print(".....................\(self.answersID)")
    self.changeButtonSign()

//            })
//
//        }
//    }
//    
    func changeButtonSign() {
        for i in 0..<didVoteAns.count {
            if (didVoteAns[i] == true) {
                print("..............................")
                print(didVoteAns[i])
                answer1Button.setTitle("-", for: .normal)
            } else {
                answer1Button.setTitle("+", for: .normal)
            }
        }
    }
    
    func displayTextButton() {
        if (answers.count == 1) {
            answer1Text.text = answers[0]
            answer2Text.isHidden = true
            answer3Text.isHidden = true
            answer4Text.isHidden = true
            answer5Text.isHidden = true
            answer2Button.isHidden = true
            answer3Button.isHidden = true
            answer4Button.isHidden = true
            answer5Button.isHidden = true
            moreAnswerText.isHidden = false
            AnswerTextButton.isHidden = false
        } else if (answers.count == 2) {
            answer1Text.text = answers[0]
            answer2Text.text = answers[1]
            answer3Text.isHidden = true
            answer4Text.isHidden = true
            answer5Text.isHidden = true
            answer3Button.isHidden = true
            answer4Button.isHidden = true
            answer5Button.isHidden = true
            moreAnswerText.isHidden = false
            AnswerTextButton.isHidden = false
        }else if (answers.count == 3) {
            answer1Text.text = answers[0]
            answer2Text.text = answers[1]
            answer3Text.text = answers[2]
            answer4Text.isHidden = true
            answer5Text.isHidden = true
            answer4Button.isHidden = true
            answer5Button.isHidden = true
            moreAnswerText.isHidden = false
            AnswerTextButton.isHidden = false
        }else if (answers.count == 4) {
            answer1Text.text = answers[0]
            answer2Text.text = answers[1]
            answer3Text.text = answers[2]
            answer4Text.text = answers[3]
            answer5Text.isHidden = true
            answer5Button.isHidden = true
            moreAnswerText.isHidden = false
            AnswerTextButton.isHidden = false

        } else {
            answer1Text.text = answers[0]
            answer2Text.text = answers[1]
            answer3Text.text = answers[2]
            answer4Text.text = answers[3]
            answer5Text.text = answers[4]
            moreAnswerText.isHidden = true
            AnswerTextButton.isHidden = true
        }
    }
    
    @IBAction func answer1Button(_ sender: AnyObject) {
        if (answer1Button.titleLabel?.text == "+") {
            answer1Button.setTitle("-", for: .normal)
            self.voters[0].append(self.loginUserID)
            DBProvider.instance.answerRef.child(self.answersID[0]).updateChildValues(["votes": (self.votes[0] + 1)])
            DBProvider.instance.answerRef.child(self.answersID[0]).updateChildValues(["answerVoters": self.voters[0]])
        } else {
            answer1Button.setTitle("+", for: .normal)
            let index = self.voters[0].index(of: "\(self.loginUserID)")
            self.voters[0].remove(at: index!)
            DBProvider.instance.answerRef.child(self.answersID[0]).updateChildValues(["votes": (self.votes[0] - 1)])
            DBProvider.instance.answerRef.child(self.answersID[0]).updateChildValues(["answerVoters": self.voters[0]])
        }
    }
    
    @IBAction func answer2Button(_ sender: AnyObject) {
    }
    
    @IBAction func answer3Button(_ sender: AnyObject) {
    }
    
    @IBAction func answer4Button(_ sender: AnyObject) {
    }
    
    @IBAction func answer5Button(_ sender: AnyObject) {
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    private func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil);
        alert.addAction(ok);
        self.present(alert, animated: true, completion: nil);
    }
    

    
}


