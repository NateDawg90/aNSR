//
//  CreateQuestionFormVC.swift
//  aNSWR
//
//  Created by Hui Jun on 2/6/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateQuestionFormVC: UIViewController, UITextFieldDelegate {

    var amountOfLinesToBeShown:CGFloat = 6
    var maxHeight:CGFloat = 17*6
    var ansArr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        AnswerText1.delegate = self
        AnswerText2.delegate = self
        AnswerText3.delegate = self
        AnswerText4.delegate = self
        AnswerText5.delegate = self
        QuestionText2.layer.cornerRadius = 5
        QuestionText2.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        QuestionText2.layer.borderWidth = 0.5
        QuestionText2.clipsToBounds = true
        AnswerButton1.isHidden = false
        AnswerButton2.isHidden = true
        AnswerButton3.isHidden = true
        AnswerButton4.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        AnswerText1.resignFirstResponder()
        AnswerText2.resignFirstResponder()
        AnswerText3.resignFirstResponder()
        AnswerText4.resignFirstResponder()
        AnswerText5.resignFirstResponder()
        return true;
    }
    
    @IBOutlet weak var QuestionText2: UITextView!
    @IBOutlet weak var AnswerText1: CustomTextField!
    @IBOutlet weak var AnswerText2: CustomTextField!
    @IBOutlet weak var AnswerText3: CustomTextField!
    @IBOutlet weak var AnswerText4: CustomTextField!
    @IBOutlet weak var AnswerText5: CustomTextField!
    
    @IBOutlet weak var AnswerButton1: UIButton!
    @IBOutlet weak var AnswerButton2: UIButton!
    @IBOutlet weak var AnswerButton3: UIButton!
    @IBOutlet weak var AnswerButton4: UIButton!
    
    @IBAction func AddAnswer2(_ sender: AnyObject) {
        if AnswerButton1.titleLabel!.text == "+" {
            AnswerText2.isHidden = false
            AnswerButton2.isHidden = false
            AnswerButton1.setTitle("-", for: .normal)
        } else {
            AnswerText2.isHidden = true
            AnswerText2.text = ""
            AnswerText3.isHidden = true
            AnswerText3.text = ""
            AnswerText4.isHidden = true
            AnswerText4.text = ""
            AnswerText5.isHidden = true
            AnswerText5.text = ""
            AnswerButton2.isHidden = true
            AnswerButton2.setTitle("+", for: .normal)
            AnswerButton3.isHidden = true
            AnswerButton3.setTitle("+", for: .normal)
            AnswerButton4.isHidden = true
            AnswerButton4.setTitle("+", for: .normal)
            AnswerButton1.setTitle("+", for: .normal)
        }
    }
    
    @IBAction func AddAnswer3(_ sender: AnyObject) {
        if AnswerButton2.titleLabel!.text == "+" {
            AnswerText3.isHidden = false
            AnswerButton3.isHidden = false
            AnswerButton2.setTitle("-", for: .normal)
        } else {
            AnswerText3.isHidden = true
            AnswerText3.text = ""
            AnswerText4.isHidden = true
            AnswerText4.text = ""
            AnswerText5.isHidden = true
            AnswerText5.text = ""
            AnswerButton3.isHidden = true
            AnswerButton3.setTitle("+", for: .normal)
            AnswerButton4.isHidden = true
            AnswerButton4.setTitle("+", for: .normal)
            AnswerButton2.setTitle("+", for: .normal)
        }
    }
    
    @IBAction func AddAnswer4(_ sender: AnyObject) {
        if AnswerButton3.titleLabel!.text == "+" {
            AnswerText4.isHidden = false
            AnswerButton4.isHidden = false
            AnswerButton3.setTitle("-", for: .normal)
        } else {
            AnswerText4.isHidden = true
            AnswerText4.text = ""
            AnswerText5.isHidden = true
            AnswerText5.text = ""
            AnswerButton4.isHidden = true
            AnswerButton4.setTitle("+", for: .normal)
            AnswerButton3.setTitle("+", for: .normal)
        }
    }
    
    @IBAction func AddAnswer5(_ sender: AnyObject) {
        if AnswerButton4.titleLabel!.text == "+" {
            AnswerText5.isHidden = false
            
            AnswerButton4.setTitle("-", for: .normal)
        } else {
            AnswerText5.isHidden = true
            AnswerText5.text = ""
            AnswerButton4.setTitle("+", for: .normal)
        }
    }
    
    @IBAction func CancelQuestionButton(_ sender: AnyObject)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CreateQuestionButton(_ sender: AnyObject) {
        if !AnswerText1.text! .isEqual("") {
            ansArr.append(AnswerText1.text!)
        }
        if !AnswerText2.text! .isEqual("") {
            ansArr.append(AnswerText2.text!)
        }
        if !AnswerText3.text! .isEqual("") {
            ansArr.append(AnswerText3.text!)
        }
        if !AnswerText4.text! .isEqual("") {
            ansArr.append(AnswerText4.text!)
        }
        if !AnswerText5.text! .isEqual("") {
            ansArr.append(AnswerText5.text!)
        }
        
        let answers = [AnswerText1, AnswerText2, AnswerText3, AnswerText4, AnswerText5]
        
        if QuestionText2.text != "" && AnswerText1.text != "" && AnswerText2.text != "" {
            DBProvider.instance.saveQuestion(questionText: QuestionText2.text!, answers: ansArr, userID: (FIRAuth.auth()?.currentUser?.uid)!, questionVoters: [""])
            
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            ref.child("questions").queryLimited(toLast: 1).observeSingleEvent(of: .value, with: { (snapshot) in
                
                for singleSnap in snapshot.children.allObjects {
                    
                    let question = singleSnap as! FIRDataSnapshot
                    for answer in answers {
                        if !(answer?.text?.isEmpty)! {
                            DBProvider.instance.saveAnswer(answerText: (answer?.text)!, userID: (FIRAuth.auth()?.currentUser?.uid)!, questionID: question.key, votes: 0, answerVoters: [""])
                        }
                    }
                }
                self.dismiss(animated: true, completion: nil)
            })
            
            
        } else {
            showAlertMessage(title: "Answers Required", message: "Please fill out at least 2 answers");
            
        }
    }
    
    private func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil);
        alert.addAction(ok);
        self.present(alert, animated: true, completion: nil);
    }
    
}
