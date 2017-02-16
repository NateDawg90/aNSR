//
//  SignUpVC.swift
//  aNSWR
//
//  Created by Hui Jun on 1/31/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController, UITextFieldDelegate {

    private let NEWS_FEED_SEGUE_ID = "NewsFeedVC"
    private let SIGN_IN_SEGUE_ID = "signIn"
    
    var currentEmail = String()
    
    @IBOutlet weak var EmailText: CustomTextField!
    
    @IBOutlet weak var UsernameText: CustomTextField!
    
    @IBOutlet weak var PasswordText: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PasswordText.delegate = self
        UsernameText.delegate = self
        EmailText.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        PasswordText.resignFirstResponder()
        UsernameText.resignFirstResponder()
        EmailText.resignFirstResponder()
        return true;
    }

    
    @IBAction func BackButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func SignUpButton(_ sender: AnyObject) {
        self.currentEmail = self.EmailText.text!
        print(self.currentEmail)
        if EmailText.text != "" && isValidEmail(testStr: EmailText.text!) && PasswordText.text != "" && UsernameText.text != "" {
            
            AuthProvider.instance.signUp(withEmail: EmailText.text!, username: UsernameText.text!, password: PasswordText.text!, loginHandler: { (message) in
                if ((message?.range(of: "verify")) != nil) {
                    
                    self.EmailText.text = ""
                    self.UsernameText.text = ""
                    self.PasswordText.text = ""
                    self.showValidationMessage(title: "Verify Email Address", message: "Please check \(self.currentEmail) for the verification link");
                    
                } else if message != nil {
                    self.showAlertMessage(title: "Problem With Signing Up", message: message!);
                }
            });
            
        } else {
            showAlertMessage(title: "Email And Password Are Required", message: "Please enter email and password in the text fields");
        }
    }
    
    
    private func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    private func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil);
        alert.addAction(ok);
        self.present(alert, animated: true, completion: nil);
    }
    
    private func showValidationMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            self.performSegue(withIdentifier: "signIn", sender: self)
        })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    

}
