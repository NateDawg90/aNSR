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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    
    @IBAction func backButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

