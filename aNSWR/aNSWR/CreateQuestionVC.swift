//
//  CreateQuestionVC.swift
//  aNSWR
//
//  Created by Hui Jun on 1/31/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateQuestionVC: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var QuestionText: UITextField!
    
    @IBOutlet weak var AnswerText1: UITextField!
    @IBOutlet weak var AnswerText2: UITextField!
    @IBOutlet weak var AnswerText3: UITextField!
    @IBOutlet weak var AnswerText4: UITextField!
    @IBOutlet weak var AnswerText5: UITextField!
    @IBOutlet weak var AnswerButton1: UIButton!
    @IBOutlet weak var AnswerButton2: UIButton!
    
    @IBOutlet weak var AnswerButton3: UIButton!
    @IBOutlet weak var AnswerButton4: UIButton!
    
    @IBAction func AddAnswer2(_ sender: Any) {
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
    
    @IBAction func AddAnswer3(_ sender: Any) {
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
    
    @IBAction func AddAnswer4(_ sender: Any) {
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
    
    @IBAction func AddAnswer5(_ sender: Any) {
        if AnswerButton4.titleLabel!.text == "+" {
            AnswerText5.isHidden = false
            
            AnswerButton4.setTitle("-", for: .normal)
        } else {
            AnswerText5.isHidden = true
            AnswerText5.text = ""
            AnswerButton4.setTitle("+", for: .normal)
        }
    }
    
    @IBAction func CancelQuestionButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CreateQuestionButton(_ sender: AnyObject) {
        if QuestionText.text != "" {
            DBProvider.instance.saveQuestion(questionText: QuestionText.text!, userID: (FIRAuth.auth()?.currentUser?.uid)!)
        }
    }
}
