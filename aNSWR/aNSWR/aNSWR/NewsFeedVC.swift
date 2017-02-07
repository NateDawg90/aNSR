//
//  NewsFeedVC.swift
//  aNSWR
//
//  Created by Hui Jun on 1/31/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class NewsFeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {
    
    @IBOutlet weak var TableView: UITableView!
    var answers = [[AnyObject]]()

    var questions = [NSDictionary]()
    var questionsText = [String]()
    var questionsID = [String]()
    var selectedQuestionText = String()
    var selectedAnswers = [String]()
    var selectedQuestionID = String()
    
    var searchResult = [String]()
    var filteredQuestionText = [String]()
    var filteredAnswers = [[AnyObject]]()
    var filteredQuestionID = [String]()
    
    override func viewDidAppear(_ animated: Bool) {
        createData()
        self.searchBarSetup()
    }
    
    func createData(){
        self.questions.removeAll()
        self.questionsText.removeAll()
        self.questionsID.removeAll()
        self.answers.removeAll()
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("questions").observeSingleEvent(of: .value, with: { (snapshot) in
            
            //get all question IDs
            for singleSnap in snapshot.children.allObjects {
                let question = singleSnap as! FIRDataSnapshot
                self.questionsID.append(question.key)
            }
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                //snapshots == all questions
                
                for snap in snapshots {
                    //value == individual question-able to access values
                    let value = snap.value as? NSDictionary
                    self.questions.append(value!)
                    self.questionsText.append(value?["questionText"] as? String ?? "")
                    //                    let answers = value?["answers"]
                    self.answers.append(value?["answers"] as? Array<AnyObject> ?? ["" as AnyObject])
                    //                    print(value?["questionText"] as? String ?? "")
                }
            }
            self.TableView.reloadData()
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBarSetup()
//        TableView.dataSource = self
//        TableView.delegate = self
//        self.questionsText = ["hey, you", "pepsi or coke", "ssssssssssssssshjkhlhliugivuiviuviuviuviuviuvugvgjcycyjcuycuchgv"]
//        self.answers = [["ans1" as AnyObject, "ans2" as AnyObject], ["ans3" as AnyObject, "ans4" as AnyObject, "ans5" as AnyObject]]

        
    }
    
    func searchBarSetup() {
        let searchBar = UISearchBar(frame: CGRect(x:0,y:0,width:(UIScreen.main.bounds.width),height:50))
        searchBar.delegate = self
        searchBar.placeholder = "Search here"
        searchBar.sizeToFit()
        searchBar.searchBarStyle = UISearchBarStyle.prominent
        //change here 
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor(red: 0/255, green: 74/255, blue: 103/255, alpha: 1)
        textFieldInsideSearchBar?.backgroundColor = UIColor(red: 230/255, green: 67/255, blue: 67/255, alpha: 1)
        searchBar.barTintColor = UIColor(red: 0/255, green: 74/255, blue: 103/255, alpha: 1)
//        searchBar.backgroundColor = UIColor(red: 230/255, green: 67/255, blue: 67/255, alpha: 1)
        self.TableView.tableHeaderView = searchBar
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }

    //search bar delegate 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            createData()
        }else {
            filterTableView(text: searchText)
        }
    }
    
    func filterTableView(text:String) {
        self.filteredQuestionText.removeAll()
        self.filteredAnswers.removeAll()
        for question in questions {
            let questionText = question["questionText"] as! String
            let answersArr = question["answers"]
            if (questionText.lowercased().contains(text.lowercased())) {
                filteredQuestionText.append(questionText)
                filteredAnswers.append(answersArr as! [AnyObject])
            }
        }
        self.questionsText.removeAll()
        self.answers.removeAll()
        self.questionsText = filteredQuestionText
        self.answers = filteredAnswers
        self.TableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! QuestionCustomCell
//        cell.textLabel?.text = self.questionsText[indexPath.row]
        let questionText = self.questionsText[indexPath.row]
        cell.QuestionText.text = questionText
        cell.Answer1Text.text = (self.answers[indexPath.row][0] as AnyObject) as? String /*as! String?*/
        cell.Answer2Text.text = (self.answers[indexPath.row][1] as AnyObject) as? String /*as! String?*/
        //        let tap = UITapGestureRecognizer(target: self, action: #selector(NewsFeedVC.expandCell(sender:)))
        //        cell.questionText.addGestureRecognizer(tap)
        //        cell.questionText.isUserInteractionEnabled = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionsText.count
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        if indexPath.row == indexOfCellToExpand
    //        {
    //            return 170 + expandedLabel.frame.height - 38
    //        }
    //        return 170
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedQuestionText = questionsText[indexPath.row]
        self.selectedAnswers = answers[indexPath.row] as! [String]
        self.selectedQuestionID = questionsID[indexPath.row]
        performSegue(withIdentifier: "ShowDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails" {
            let detailsVC = segue.destination as! QuestionDetailVC
            detailsVC.questionText = self.selectedQuestionText
            detailsVC.answers = self.selectedAnswers
            detailsVC.questionID = self.selectedQuestionID
            detailsVC.loginUserID = (FIRAuth.auth()?.currentUser?.uid)!
        }

    }
    
    @IBAction func LogOutButton(_ sender: AnyObject) {
        if AuthProvider.instance.logOut() {
            dismiss(animated: true, completion: nil);
        } else {
            showAlertMessage(title: "Could Not Log Out", message: "We Have A Problem With Connecting To Database To Log Out, Please Try Again");
        }
    }
    
    private func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil);
        alert.addAction(ok);
        self.present(alert, animated: true, completion: nil);
    }
}
