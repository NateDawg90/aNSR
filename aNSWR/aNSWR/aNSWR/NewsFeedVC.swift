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

class NewsFeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TableView: UITableView!
    var answers = [[String]]()

    var questions = [NSDictionary]()
    var questionsText = [String]()
    var selectedQuestionText = String()
    var selectedAnswers = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        TableView.dataSource = self
//        TableView.delegate = self
//        self.questionsText = ["hey, you", "pepsi or coke", "ssssssssssssssshjkhlhliugivuiviuviuviuviuviuvugvgjcycyjcuycuchgv"]
        self.answers = [["ans1", "ans2"], ["ans3", "ans4", "ans5"]]

        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("questions").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                
                for snap in snapshots {
                    let value = snap.value as? NSDictionary
//                    print(value ?? "")
                    self.questions.append(value!)
                    self.questionsText.append(value?["questionText"] as? String ?? "")
//                    let answers = value?["answers"]
//                    self.answers.append((answers as? [String])!)
//                    print(value?["questionText"] as? String ?? "")
                }
                self.TableView.reloadData()
            }
        })
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
        cell.Answer1Text.text = self.answers[0][0] /*as! String?*/
        cell.Answer2Text.text = self.answers[0][1] /*as! String?*/
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
        self.selectedAnswers = answers[indexPath.row]
        performSegue(withIdentifier: "ShowDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsVC = segue.destination as! DetailsVC
        detailsVC.questionText = self.selectedQuestionText
        detailsVC.answers = self.selectedAnswers
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
