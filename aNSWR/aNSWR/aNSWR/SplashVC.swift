//
//  ViewController.swift
//  aNSWR
//
//  Created by Hui Jun on 1/31/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.title(for: .normal) == "X" {
            sender.setTitle("A very long title for this button", for: .normal)
        } else {
            sender.setTitle("X", for: .normal)
        }
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        if sender.title(for: .normal) == "X" {
            sender.setTitle("A very long title for this button", for: .normal)
        } else {
            sender.setTitle("X", for: .normal)
        }
    }
//    override func viewDidAppear(_ animated: Bool) {
//        if AuthProvider.instance.isLoggedIn() {
//            performSegue(withIdentifier: NEWS_FEED_SEGUE_ID, sender: nil);
//        }
//    }


}

