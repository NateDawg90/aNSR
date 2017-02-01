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
    
    @IBOutlet weak var QuestionText: CustomTextField!
    
    @IBAction func CreateQuestionButton(_ sender: AnyObject) {
        if QuestionText.text != "" {
            DBProvider.instance.saveQuestion(questionText: QuestionText.text!, userID: (FIRAuth.auth()?.currentUser?.uid)!)
        }
    }
}
