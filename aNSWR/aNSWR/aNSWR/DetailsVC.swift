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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTextButton()
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("answers").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for answer in self.answers {
                    for snap in snapshots {
                        let value = snap.value as? NSDictionary
                        if ((value?["answerText"] as? String == answer) &&
                            (value?["questionID"] as? String == self.questionID)) {
                            self.votes.append((value?["votes"] as? Int)!)
                            let voters = value?["answerVoters"] as? Array<String>
                            if (voters?.contains(self.loginUserID)) {
                                self.didVoteAns.append(true)
                            } else {
                                self.didVoteAns.append(false)
                            }

                        }
                    }
                    
                }

            }

        })
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
    
    
}

