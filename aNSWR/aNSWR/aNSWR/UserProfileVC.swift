//
//  UserProfileVC.swift
//  aNSWR
//
//  Created by Andrew on 2/8/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class UserProfileVC: UIViewController, UITextFieldDelegate {
    private let SUCCESS_SEGUE_ID = "SuccessVC"
    
    @IBOutlet weak var usernameText: UILabel!
    
    @IBOutlet weak var changeEmailText: UITextField!
    
    @IBAction func LogOutButton(_ sender: Any) {
        if AuthProvider.instance.logOut() {
            performSegue(withIdentifier: "logout", sender: nil)
//            dismiss(animated: true, completion: nil);
        } else {
            showAlertMessage(title: "Could Not Log Out", message: "We Have A Problem With Connecting To Database To Log Out, Please Try Again");
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var changeUsernameText: UITextField!
    
    @IBOutlet weak var changePasswordText: UITextField!
    
    @IBAction func updateEmailButton(_ sender: Any) {
        if changeEmailText.text != "" && isValidEmail(testStr: changeEmailText.text!) {
            FIRAuth.auth()?.currentUser?.updateEmail(self.changeEmailText.text!) { (error) in
                if error == nil {
                    DBProvider.instance.usersRef.child((FIRAuth.auth()?.currentUser?.uid)!).updateChildValues(["email": self.changeEmailText.text ?? ""])
                    self.showAlertMessage(title: "Success", message: "Email successfully updated!")
                    self.changeEmailText.text = ""
                }
                else{
                    self.showAlertMessage(title: "Error", message: "This operation is sensitive and requires recent authentication. Log in again before retrying this request.")
                }
            }
        } else {
            showAlertMessage(title: "Invalid Email", message: "Please enter a valid Email");
        }
    }
    
    @IBAction func updateUsernameButton(_ sender: Any) {
        if self.changeUsernameText.text != "" {
            DBProvider.instance.usersRef.child((FIRAuth.auth()?.currentUser?.uid)!).updateChildValues(["username": self.changeUsernameText.text ?? ""])
            self.changeUsernameText.text = ""
            performSegue(withIdentifier: SUCCESS_SEGUE_ID, sender: nil)
        } else {
            showAlertMessage(title: "Invalid Username", message: "Please enter a valid Username");
        }
        
    }
    
    @IBAction func updatePasswordButton(_ sender: Any) {
        if (self.changePasswordText.text != "") {
            FIRAuth.auth()?.currentUser?.updatePassword(self.changePasswordText.text!) { (error) in
                if error == nil {
                    self.showAlertMessage(title: "Success", message: "Password successfully updated!")
                    self.changePasswordText.text = ""
                }
                else{
                    self.showAlertMessage(title: "Error", message: "This operation is sensitive and requires recent authentication. Log in again before retrying this request.")
                }

            }
        } else {
            showAlertMessage(title: "Invalid Password", message: "Please enter a valid password")
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changePasswordText.delegate = self
        changeUsernameText.delegate = self
        changeEmailText.delegate = self
        // Do any additional setup after loading the view.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        changePasswordText.resignFirstResponder()
        changeUsernameText.resignFirstResponder()
        changeEmailText.resignFirstResponder()
        return true;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            for singleSnap in snapshot.children.allObjects {
                let user = singleSnap as! FIRDataSnapshot
                if (user.key == FIRAuth.auth()?.currentUser?.uid){
                    let value = user.value as? NSDictionary
                    self.usernameText.text = value?["username"] as? String
                }
            }
        })
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


    

//    
//    @IBAction func SignUpButton(_ sender: AnyObject) {
//        if EmailText.text != "" && isValidEmail(testStr: EmailText.text!) && PasswordText.text != "" && UsernameText.text != "" {
//            
//            AuthProvider.instance.signUp(withEmail: EmailText.text!, username: UsernameText.text!, password: PasswordText.text!, loginHandler: { (message) in
//                if message != nil {
//                    self.showAlertMessage(title: "Problem With Signing Up", message: message!);
//                } else {
//                    self.EmailText.text = ""
//                    self.UsernameText.text = ""
//                    self.PasswordText.text = ""
//                    self.performSegue(withIdentifier: self.NEWS_FEED_SEGUE_ID, sender: nil)
//                }
//                
//            });
//            
//        } else {
//            showAlertMessage(title: "Email And Password Are Required", message: "Please enter email and password in the text fields");
//        }
//
//    }
//    
//
    
    
}

