//
//  DetailsVC.swift
//  aNSWR
//
//  Created by Hui Jun on 2/1/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
    var questionText = String()
    var answers = [String()]
    var questionID = String()
    var loginUserID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("..................\(questionText)")
        print(answers)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
