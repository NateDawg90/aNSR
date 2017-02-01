//
//  CreateQuestionVC.swift
//  aNSWR
//
//  Created by Andrew on 1/31/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit
import Firebase

class CreateQuestionVC: UIViewController {
    
    private let NEWS_FEED_SEGUE_ID = "NewsFeedVC"
    
    @IBOutlet weak var QuestionText: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
