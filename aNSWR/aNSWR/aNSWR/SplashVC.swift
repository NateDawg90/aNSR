//
//  ViewController.swift
//  aNSWR
//
//  Created by Hui Jun on 1/31/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit
import FirebaseAuth

class SplashVC: UIViewController {
    var email = "demo@gmail.com"
    var password = "password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

//    override func viewDidAppear(_ animated: Bool) {
//        if AuthProvider.instance.isLoggedIn() {
//            performSegue(withIdentifier: NEWS_FEED_SEGUE_ID, sender: nil);
//        }
//    }


    @IBAction func demoLogin(_ sender: AnyObject) {
        AuthProvider.instance.login(withEmail: email, password: password, loginHandler: { (message) in
            if message != nil {
                self.showAlertMessage(title: "Problem With Authentication", message: message!);
            } else {
                self.performSegue(withIdentifier: "demoLoginNewsFeed", sender: nil);
            }
        });
    }
    
    private func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil);
        alert.addAction(ok);
        self.present(alert, animated: true, completion: nil);
    }
    
    
}

