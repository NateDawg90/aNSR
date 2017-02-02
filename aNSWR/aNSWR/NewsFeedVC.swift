//
//  NewsFeedVC.swift
//  aNSWR
//
//  Created by Hui Jun on 1/31/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit
import FirebaseAuth

class NewsFeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // 1
    var expandedLabel: UILabel!
    var indexOfCellToExpand: Int!
    // 2
    //get from firebase
    var questions: [[String: AnyObject]]!
    var selectedQuestion: [String: AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexOfCellToExpand = -1
        TableView.dataSource = self
        TableView.delegate = self
        self.questions = [/*fill in firebasedata*/] 
        DispatchQueue.main.async(execute: {
            self.TableView.reloadData()
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var TableView: UITableView!
    
    func expandCell(sender: UITapGestureRecognizer)
    {
        let label = sender.view as! UILabel
        
        let cell: QuestionCustomCell = TableView.cellForRow(at: IndexPath(row: label.tag, section: 0)) as! QuestionCustomCell
        let movie = self.questions[label.tag]
        let answers = movie["answers"] as! String
        cell.AnswerText.sizeToFit()
        cell.AnswerText.text = answers
        expandedLabel = cell.AnswerText
        indexOfCellToExpand = label.tag
        TableView.reloadRows(at: [IndexPath(row: label.tag, section: 0)], with: .fade)
        TableView.scrollToRow(at: IndexPath(row: label.tag, section: 0), at: .top, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! QuestionCustomCell
        let question = self.questions[indexPath.row]
        let questionText = question["questionText"]
        let answer = question["answers"]
        cell.questionText.text = questionText as! String?
        cell.AnswerText.text = answer as! String?
        let tap = UITapGestureRecognizer(target: self, action: #selector(NewsFeedVC.expandCell(sender:)))
        cell.questionText.addGestureRecognizer(tap)
        cell.questionText.isUserInteractionEnabled = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questions.count
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
