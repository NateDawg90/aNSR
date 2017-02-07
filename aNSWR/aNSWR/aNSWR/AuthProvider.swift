//
//  AuthProvider.swift
//  aNSWR
//
//  Created by Hui Jun on 1/31/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//


import Foundation
import FirebaseAuth

typealias LoginHandler = (_ errMSG: String?) -> Void;

struct LoginErrorCode {
    static let INVALID_EMAIL = "Invalid Email Address, Please Provide Real Email Address";
    static let WRONG_PASSWORD = "Wrong Password, Please Enter The Correct Password";
    static let PROBLEM_CONNECTING = "Problem Connecting To Database, Please Try Again Later";
    static let USER_NOT_FOUND = "User Not Found, Please Register";
    static let EMAIL_ALREADY_IN_USE = "Email Already In Use, Please Use Another Email";
    static let WEAK_PASSWORD = "Password Should Be At Least 6 Characters Long";
}

class AuthProvider {
    private static let _instance = AuthProvider();
    
    static var instance: AuthProvider {
        return _instance;
    }
    
    func isLoggedIn() -> Bool {
        if FIRAuth.auth()?.currentUser != nil {
            return true;
        }
        
        return false;
    }
    
    func logOut() -> Bool {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut();
                return true;
            } catch {
                return false;
            }
        }
        return true;
    }
    
    func login(withEmail: String, password: String, loginHandler: LoginHandler?) {
            FIRAuth.auth()?.signIn(withEmail: withEmail, password: password, completion: { (user, error) in
            
            if error != nil {
                // user not signed in we have a problem
                self.handleErrors(err: error as! NSError, loginHandler: loginHandler);
                
            } else {
                // user is signed in
                loginHandler?(nil);
                print("success")
            }
            
        });
    }
    
    func signUp(withEmail: String, username: String, password: String, loginHandler: LoginHandler?) {
        
        FIRAuth.auth()?.createUser(withEmail: withEmail, password: password, completion: { (user, error) in
            if error != nil {
                self.handleErrors(err: error as! NSError, loginHandler: loginHandler);
            } else {
                
                if user?.uid != nil {
                    
                    // save to database
                    DBProvider.instance.saveUser(withID: user!.uid, email: withEmail, username: username);
                    
                    // sign in the user
                    FIRAuth.auth()?.signIn(withEmail: withEmail, password: password, completion: { (user, error) in
                        
                        if error != nil {
                            self.handleErrors(err: error as! NSError, loginHandler: loginHandler);
                        } else {
                            loginHandler?(nil);
                        }
                        
                    });
                    
                }
                
            }
            
        });
        
    }
    
    private func handleErrors(err: NSError, loginHandler: LoginHandler?) {
        
        if let errCode = FIRAuthErrorCode(rawValue: err.code) {
            
            switch errCode {
                
            case .errorCodeWrongPassword:
                loginHandler?(LoginErrorCode.WRONG_PASSWORD);
                break;
                
            case .errorCodeInvalidEmail:
                loginHandler?(LoginErrorCode.INVALID_EMAIL);
                break;
                
            case .errorCodeUserNotFound:
                loginHandler?(LoginErrorCode.USER_NOT_FOUND);
                break;
                
            case .errorCodeEmailAlreadyInUse:
                loginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE);
                break;
                
            case .errorCodeWeakPassword:
                loginHandler?(LoginErrorCode.WEAK_PASSWORD);
                break;
                
            default:
                loginHandler?(LoginErrorCode.PROBLEM_CONNECTING);
                break;
                
            }
            
        }
        
    }
    
}
