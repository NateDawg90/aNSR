//
//  QuestionDetailVC.swift
//  aNSWR
//
//  Created by Hui Jun on 2/6/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit
import Charts
import Firebase

class QuestionDetailVC: UIViewController, UITextFieldDelegate {
    var questionText = String()
    var answers = [String]()
    var questionID = String()
    var votes = [Int]()
    var didVoteAns = [Bool]()
    var loginUserID = String()
    var answersID = [String]()
    var voters = [[String]]()
    var answerKey = String()
    var numOfVotes = Int()
    var checkAnswerText = ""
    var badWord = ["f...","2g1c","2 girls 1 cup","acrotomophilia","alabama hot pocket","alaskan pipeline","anal","anilingus","anus","apeshit"
        ,"arsehole","ass","asshole","assmunch","auto erotic","autoerotic","babeland","baby batter","baby juice","ball gag","ball gravy","ball kicking"
        ,"ball licking","ball sack","ball sucking","bangbros","bareback","barely legal","barenaked","bastard","bastardo","bastinado"
        ,"bbw","bdsm","beaner","beaners","beaver cleaver","beaver lips","bestiality","big black","big breasts","big knockers","big tits","bimbos"
        ,"birdlock","bitch","bitches","black cock","blonde action","blonde on blonde action","blowjob","blow job","blow your load","blue waffle","blumpkin"
        ,"bollocks","bondage","boner","boob","boobs","booty call","brown showers","brunette action","bukkake","bulldyke","bullet vibe","bullshit"
        ,"bung hole","bunghole","busty","butt","buttcheeks","butthole","camel toe","camgirl","camslut","camwhore","carpet muncher","carpetmuncher"
        ,"chocolate rosebuds","circlejerk","cleveland steamer","clit","clitoris","clover clamps","clusterfuck","cock","cocks"
        ,"coprolagnia","coprophilia","cornhole","coon","coons","creampie","cum","cumming","cunnilingus","cunt","darkie","date rape","daterape"
        ,"deep throat","deepthroat","dendrophilia","dick","dildo","dingleberry","dingleberries","dirty pillows","dirty sanchez","doggie style","doggiestyle"
        ,"doggy style","doggystyle","dog style","dolcett","domination","dominatrix","dommes","donkey punch","double dong","double penetration"
        ,"dp action","dry hump","dvda","eat my ass","ecchi","ejaculation","erotic","erotism","escort","eunuch","faggot","fecal"
        ,"felch","fellatio","feltch","female squirting","femdom","figging","fingerbang","fingering","fisting","foot fetish","footjob","frotting"
        ,"fuck","f*ck","f**k","fuck buttons","fuckin","fucking","fucktards","fudge packer","fudgepacker","futanari","gang bang","gay sex"
        ,"genitals","giant cock","girl on","girl on top","girls gone wild","goatcx","goatse","god damn","gokkun","golden shower","goodpoop","goo girl"
        ,"goregasm","grope","group sex","g-spot","guro","hand job","handjob","hard core","hardcore","hentai","homoerotic","honkey","hooker","hot carl","hot chick"
        ,"how to kill","how to murder","huge fat","humping","incest","intercourse","jack off","jail bait","jailbait","jelly donut","jerk off"
        ,"jigaboo","jiggaboo","jiggerboo","jizz","juggs","kike","kinbaku","kinkster","kinky","knobbing","leather restraint","leather straight jacket"
        ,"lemon party","lolita","lovemaking","make me come","male squirting","masturbate","menage a trois","milf","missionary position","motherfucker"
        ,"mound of venus","mr hands","muff diver","muffdiving","nambla","nawashi","negro","neonazi","nigga","nigger","nig nog","nimphomania"
        ,"nipple","nipples","nsfw images","nude","nudity","nympho","nymphomania","octopussy","omorashi","one cup two girls","one guy one jar"
        ,"orgasm","orgy","paedophile","paki","panties","panty","pedobear","pedophile","pegging","penis","phone sex","piece of shit","pissing","piss pig","pisspig"
        ,"playboy","pleasure chest","pole smoker","ponyplay","poof","poon","poontang","punany","poop chute","poopchute","porn","porno","pornography"
        ,"prince albert piercing","pthc","pubes","pussy","queaf","queef","quim","raghead","raging boner","rape","raping","rapist","rectum","reverse cowgirl"
        ,"rimjob","rimming","rosy palm","rosy palm and her 5 sisters","rusty trombone","sadism","santorum","scat","schlong","scissoring","semen","sex","sexo"
        ,"shaved beaver","shaved pussy","shemale","shibari","shit","shitblimp","shitty","shota","shrimping","skeet","slanteye","slut","s&m","smut","sodomize"
        ,"sodomy","spic","splooge","splooge moose","spooge","spread legs","spunk","strapon","strappado","strip club","style doggy","suck","sucks"
        ,"suicide girls","sultry women","swastika","swinger","tainted love","taste my","tea bagging","threesome","throating","tied up","tight white"
        ,"tit","tits","titties","titty","tongue in a","topless","tosser","towelhead","tranny","tribadism","tub girl","tubgirl","tushy","twat","twink"
        ,"two girls one cup","upskirt","urethra play","urophilia","vagina","venus mound","vibrator","violet wand","vorarephilia","voyeur","vulva"
        ,"wank","wetback","wet dream","white power","wrapping men","wrinkled starfish","xx","xxx","yaoi","yellow showers","yiffy","zoophilia"]
    
    @IBOutlet weak var deleteQuestionButton: UIButton!
    @IBAction func deleteQuestion(_ sender: AnyObject) {
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("questions").observeSingleEvent(of: .value, with: { (snapshot) in
            //get answer key
            for singleSnap in snapshot.children.allObjects {
                let question = singleSnap as! FIRDataSnapshot
                if self.questionID == question.key {
                    DBProvider.instance.questionRef.child(self.questionID).removeValue()
                }
                
            }
        })
        
        ref.child("answers").observeSingleEvent(of: .value, with: { (snapshot) in
            for singleSnap in snapshot.children.allObjects {
                let answer = singleSnap as! FIRDataSnapshot
                let id = answer.key
                
                let answerSnap = singleSnap as? FIRDataSnapshot
                let value = answerSnap?.value as? NSDictionary
                if (value?["questionID"] as? String == self.questionID) {
                    DBProvider.instance.answerRef.child(id).removeValue()
                }
            }
            self.dismiss(animated: true, completion: nil)
        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moreAnswerText.delegate = self
        questionTextLabel.text = questionText
        // Do any additional setup after loading the view.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        moreAnswerText.resignFirstResponder()
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        moreAnswerText.text = ""
        self.votes.removeAll()
        self.voters.removeAll()
        self.answersID.removeAll()
        self.didVoteAns.removeAll()
        self.answers.removeAll()
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("questions").observeSingleEvent(of: .value, with: { (snapshot) in
            for singleSnap in snapshot.children.allObjects {
//                let question = singleSnap as! FIRDataSnapshot
                let questionSnap = singleSnap as? FIRDataSnapshot
                let value = questionSnap?.value as? NSDictionary
                if (self.questionText == value?["questionText"] as? String) {
                    if (value?["userID"] as? String == self.loginUserID) {
                        print(self.loginUserID)
                        self.deleteQuestionButton.isHidden = false
                    } else {
                        self.deleteQuestionButton.isHidden = true
                    }
                }
            }
        })
        ref.child("answers").observeSingleEvent(of: .value, with: { (snapshot) in
            //get answer key
            for singleSnap in snapshot.children.allObjects {
                let answer = singleSnap as! FIRDataSnapshot
                self.answerKey = answer.key
                
                let answerSnap = singleSnap as? FIRDataSnapshot
                let value = answerSnap?.value as? NSDictionary
                if (value?["questionID"] as? String == self.questionID) {
//                   if (self.loginUserID == value?["userID"] as! String){
//                        self.deleteQuestionButton.isHidden = false
//                        
//                    }
                    self.answersID.append(self.answerKey)
                    self.votes.append((value?["votes"] as? Int)!)
                    self.answers.append((value?["answerText"] as! String))
                    self.voters.append((value?["answerVoters"] as! [String]))
                    let voters = value?["answerVoters"] as? Array<String>
                    if (voters?.contains(self.loginUserID))! {
                        self.didVoteAns.append(true)
                    } else {
                        self.didVoteAns.append(false)
                    }
                }
            }
            self.displayTextButton()
            self.changeButtonSign()
            self.updateChartWithData()
            self.updatePieChartWithData()
        })
    }

    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var answer1Text: UILabel!
    @IBOutlet weak var answer2Text: UILabel!
    @IBOutlet weak var answer3Text: UILabel!
    @IBOutlet weak var answer4Text: UILabel!
    @IBOutlet weak var answer5Text: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    @IBOutlet weak var answer5Button: UIButton!
    @IBOutlet weak var AnswerTextButton: UIButton!
    @IBOutlet weak var moreAnswerText: UITextField!
    
    @IBAction func addAnswerButton(_ sender: AnyObject) {
        let answerArr = moreAnswerText.text?.components(separatedBy: " ")
        for word in answerArr! {
            if (badWord.contains(word.lowercased())){
                checkAnswerText = word
            }
        }
        if !(moreAnswerText.text?.isEmpty)! && checkAnswerText == "" {
            DBProvider.instance.saveAnswer(answerText: (moreAnswerText.text)!, userID: (FIRAuth.auth()?.currentUser?.uid)!, questionID: self.questionID, votes: 0, answerVoters: [""])
            self.answers.append(moreAnswerText.text!)
            DBProvider.instance.questionRef.child(self.questionID).updateChildValues(["answers": self.answers])
        } else {
            if (checkAnswerText != "") {
                showAlertMessage(title: "Error", message: "Your answer contains inappropriate word. Please replace \(checkAnswerText) with more appropriate word")
                checkAnswerText = ""
            } else {
                showAlertMessage(title: "Answers Required", message: "Please fill in the answer text field");
            }
        }
    }
    
    func updateData(questionID: String) {
        self.questionText.removeAll()
        self.answers.removeAll()
        self.votes.removeAll()
        self.didVoteAns.removeAll()
        self.answersID.removeAll()
        self.voters.removeAll()
        
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("answers").observeSingleEvent(of: .value, with: { (snapshot) in
            //get answer key
            for singleSnap in snapshot.children.allObjects {
                let answer = singleSnap as! FIRDataSnapshot
                self.answerKey = answer.key
                
                let answerSnap = singleSnap as? FIRDataSnapshot
                let value = answerSnap?.value as? NSDictionary
                if (value?["questionID"] as? String == self.questionID) {
                    self.answersID.append(self.answerKey)
                    self.answers.append((value?["answerText"] as! String))
                    self.votes.append((value?["votes"] as? Int)!)
                    self.voters.append((value?["answerVoters"] as! [String]))
                    let voters = value?["answerVoters"] as? Array<String>
                    if (voters?.contains(self.loginUserID))! {
                        self.didVoteAns.append(true)
                    } else {
                        self.didVoteAns.append(false)
                    }
                }
            }
            
            self.changeButtonSign()
        })
    }

    func changeButtonSign() {
        if (didVoteAns.count == 1) {
            if (didVoteAns[0] == true) {
                answer1Button.setTitle("-", for: .normal)
            } else {
                answer1Button.setTitle("+", for: .normal)
            }
        } else if (didVoteAns.count == 2) {
            if (didVoteAns[0] == true) {
                answer1Button.setTitle("-", for: .normal)
            } else {
                answer1Button.setTitle("+", for: .normal)
            }
            if (didVoteAns[1] == true) {
                answer2Button.setTitle("-", for: .normal)
            } else {
                answer2Button.setTitle("+", for: .normal)
            }
        } else if (didVoteAns.count == 3) {
            if (didVoteAns[0] == true) {
                answer1Button.setTitle("-", for: .normal)
            } else {
                answer1Button.setTitle("+", for: .normal)
            }
            if (didVoteAns[1] == true) {
                answer2Button.setTitle("-", for: .normal)
            } else {
                answer2Button.setTitle("+", for: .normal)
            }
            if (didVoteAns[2] == true) {
                answer3Button.setTitle("-", for: .normal)
            } else {
                answer3Button.setTitle("+", for: .normal)
            }
        } else if (didVoteAns.count == 4) {
            if (didVoteAns[0] == true) {
                answer1Button.setTitle("-", for: .normal)
            } else {
                answer1Button.setTitle("+", for: .normal)
            }
            if (didVoteAns[1] == true) {
                answer2Button.setTitle("-", for: .normal)
            } else {
                answer2Button.setTitle("+", for: .normal)
            }
            if (didVoteAns[2] == true) {
                answer3Button.setTitle("-", for: .normal)
            } else {
                answer3Button.setTitle("+", for: .normal)
            }
            if (didVoteAns[3] == true) {
                answer4Button.setTitle("-", for: .normal)
            } else {
                answer4Button.setTitle("+", for: .normal)
            }
        } else {
            if (didVoteAns[0] == true) {
                answer1Button.setTitle("-", for: .normal)
            } else {
                answer1Button.setTitle("+", for: .normal)
            }
            if (didVoteAns[1] == true) {
                answer2Button.setTitle("-", for: .normal)
            } else {
                answer2Button.setTitle("+", for: .normal)
            }
            if (didVoteAns[2] == true) {
                answer3Button.setTitle("-", for: .normal)
            } else {
                answer3Button.setTitle("+", for: .normal)
            }
            if (didVoteAns[3] == true) {
                answer4Button.setTitle("-", for: .normal)
            } else {
                answer4Button.setTitle("+", for: .normal)
            }
            if (didVoteAns[4] == true) {
                answer5Button.setTitle("-", for: .normal)
            } else {
                answer5Button.setTitle("+", for: .normal)
            }
        }
    }

    func displayTextButton() {
        if (answers.count == 1) {
            answer1Text.text = answers[0]
            answer2Text.isHidden = true
            answer3Text.isHidden = true
            answer4Text.isHidden = true
            answer5Text.isHidden = true
            answer2Button.isHidden = true
            answer3Button.isHidden = true
            answer4Button.isHidden = true
            answer5Button.isHidden = true
            
        } else if (answers.count == 2) {
            answer1Text.isHidden = false
            answer1Button.isHidden = false
            answer1Text.text = answers[0]
            answer2Text.text = answers[1]
            answer2Text.isHidden = false
            answer2Button.isHidden = false
            answer3Text.isHidden = true
            answer4Text.isHidden = true
            answer5Text.isHidden = true
            answer3Button.isHidden = true
            answer4Button.isHidden = true
            answer5Button.isHidden = true
            
        }else if (answers.count == 3) {
            answer1Text.isHidden = false
            answer1Button.isHidden = false
            answer2Text.isHidden = false
            answer2Button.isHidden = false
            answer3Text.isHidden = false
            answer3Button.isHidden = false
            answer1Text.text = answers[0]
            answer2Text.text = answers[1]
            answer3Text.text = answers[2]
            answer3Text.isHidden = false
            answer3Button.isHidden = false
            answer4Text.isHidden = true
            answer5Text.isHidden = true
            answer4Button.isHidden = true
            answer5Button.isHidden = true
            
        }else if (answers.count == 4) {
            answer1Text.isHidden = false
            answer1Button.isHidden = false
            answer2Text.isHidden = false
            answer2Button.isHidden = false
            answer3Text.isHidden = false
            answer3Button.isHidden = false
            answer4Text.isHidden = false
            answer4Button.isHidden = false
            answer1Text.text = answers[0]
            answer2Text.text = answers[1]
            answer3Text.text = answers[2]
            answer4Text.text = answers[3]
            answer4Text.isHidden = false
            answer4Button.isHidden = false
            answer5Text.isHidden = true
            answer5Button.isHidden = true
            
        } else {
            answer1Text.isHidden = false
            answer1Button.isHidden = false
            answer2Text.isHidden = false
            answer2Button.isHidden = false
            answer3Text.isHidden = false
            answer3Button.isHidden = false
            answer4Text.isHidden = false
            answer4Button.isHidden = false
            answer1Text.text = answers[0]
            answer2Text.text = answers[1]
            answer3Text.text = answers[2]
            answer4Text.text = answers[3]
            answer5Text.text = answers[4]
            answer5Text.isHidden = false
            answer5Button.isHidden = false
            moreAnswerText.isHidden = true
            AnswerTextButton.isHidden = true
        }
    }

    @IBAction func answer1Button(_ sender: AnyObject) {
        if (answer1Button.titleLabel?.text == "+") {
            let prevVote = self.didVoteAns.index(of: true)
            if (prevVote == nil) {
                answer1Button.setTitle("-", for: .normal)
                self.voters[0].append(self.loginUserID)
                DBProvider.instance.answerRef.child(self.answersID[0]).updateChildValues(["votes": (self.votes[0] + 1)])
                DBProvider.instance.answerRef.child(self.answersID[0]).updateChildValues(["answerVoters": self.voters[0]])
                updateData(questionID: self.questionID)
                updateChartWithData()
                updatePieChartWithData()
            } else {
                let userIdx = self.voters[prevVote!].index(of: "\(self.loginUserID)")
                self.voters[prevVote!].remove(at: userIdx!)
                answer1Button.setTitle("-", for: .normal)
                self.voters[0].append(self.loginUserID)
                DBProvider.instance.answerRef.child(self.answersID[prevVote!]).updateChildValues(["votes": (self.votes[prevVote!] - 1)])
                DBProvider.instance.answerRef.child(self.answersID[prevVote!]).updateChildValues(["answerVoters": self.voters[prevVote!]])
                DBProvider.instance.answerRef.child(self.answersID[0]).updateChildValues(["votes": (self.votes[0] + 1)])
                DBProvider.instance.answerRef.child(self.answersID[0]).updateChildValues(["answerVoters": self.voters[0]])
                updateData(questionID: self.questionID)
                updateChartWithData()
                updatePieChartWithData()
            }
            
        } else {
            answer1Button.setTitle("+", for: .normal)
            let index = self.voters[0].index(of: "\(self.loginUserID)")
            self.voters[0].remove(at: index!)
            DBProvider.instance.answerRef.child(self.answersID[0]).updateChildValues(["votes": (self.votes[0] - 1)])
            DBProvider.instance.answerRef.child(self.answersID[0]).updateChildValues(["answerVoters": self.voters[0]])
            updateData(questionID: self.questionID)
            updateChartWithData()
            updatePieChartWithData()
        }
    }
    
    @IBAction func answer2Button(_ sender: AnyObject) {
        if (answer2Button.titleLabel?.text == "+") {
            let prevVote = self.didVoteAns.index(of: true)
            if (prevVote == nil) {
                answer2Button.setTitle("-", for: .normal)
                self.voters[1].append(self.loginUserID)
                DBProvider.instance.answerRef.child(self.answersID[1]).updateChildValues(["votes": (self.votes[1] + 1)])
                DBProvider.instance.answerRef.child(self.answersID[1]).updateChildValues(["answerVoters": self.voters[1]])
                updateData(questionID: self.questionID)
                updateChartWithData()
                updatePieChartWithData()
            } else {
                let userIdx = self.voters[prevVote!].index(of: "\(self.loginUserID)")
                self.voters[prevVote!].remove(at: userIdx!)
                answer2Button.setTitle("-", for: .normal)
                self.voters[1].append(self.loginUserID)
                DBProvider.instance.answerRef.child(self.answersID[prevVote!]).updateChildValues(["votes": (self.votes[prevVote!] - 1)])
                DBProvider.instance.answerRef.child(self.answersID[prevVote!]).updateChildValues(["answerVoters": self.voters[prevVote!]])
                DBProvider.instance.answerRef.child(self.answersID[1]).updateChildValues(["votes": (self.votes[1] + 1)])
                DBProvider.instance.answerRef.child(self.answersID[1]).updateChildValues(["answerVoters": self.voters[1]])
                updateData(questionID: self.questionID)
                updateChartWithData()
                updatePieChartWithData()
            }
        } else {
            answer2Button.setTitle("+", for: .normal)
            let index = self.voters[1].index(of: "\(self.loginUserID)")
            self.voters[1].remove(at: index!)
            DBProvider.instance.answerRef.child(self.answersID[1]).updateChildValues(["votes": (self.votes[1] - 1)])
            DBProvider.instance.answerRef.child(self.answersID[1]).updateChildValues(["answerVoters": self.voters[1]])
            updateData(questionID: self.questionID)
            updateChartWithData()
            updatePieChartWithData()
        }
    }
    
    @IBAction func answer3Button(_ sender: AnyObject) {
        if (answer3Button.titleLabel?.text == "+") {
            let prevVote = self.didVoteAns.index(of: true)
            if (prevVote == nil) {
                answer3Button.setTitle("-", for: .normal)
                self.voters[2].append(self.loginUserID)
                DBProvider.instance.answerRef.child(self.answersID[2]).updateChildValues(["votes": (self.votes[2] + 1)])
                DBProvider.instance.answerRef.child(self.answersID[2]).updateChildValues(["answerVoters": self.voters[2]])
                updateData(questionID: self.questionID)
                updateChartWithData()
                updatePieChartWithData()
            } else {
                let userIdx = self.voters[prevVote!].index(of: "\(self.loginUserID)")
                self.voters[prevVote!].remove(at: userIdx!)
                answer3Button.setTitle("-", for: .normal)
                self.voters[2].append(self.loginUserID)
                DBProvider.instance.answerRef.child(self.answersID[prevVote!]).updateChildValues(["votes": (self.votes[prevVote!] - 1)])
                DBProvider.instance.answerRef.child(self.answersID[prevVote!]).updateChildValues(["answerVoters": self.voters[prevVote!]])
                DBProvider.instance.answerRef.child(self.answersID[2]).updateChildValues(["votes": (self.votes[2] + 1)])
                DBProvider.instance.answerRef.child(self.answersID[2]).updateChildValues(["answerVoters": self.voters[2]])
                updateData(questionID: self.questionID)
                updateChartWithData()
                updatePieChartWithData()
            }
        } else {
            answer3Button.setTitle("+", for: .normal)
            let index = self.voters[2].index(of: "\(self.loginUserID)")
            self.voters[2].remove(at: index!)
            DBProvider.instance.answerRef.child(self.answersID[2]).updateChildValues(["votes": (self.votes[2] - 1)])
            DBProvider.instance.answerRef.child(self.answersID[2]).updateChildValues(["answerVoters": self.voters[2]])
            updateData(questionID: self.questionID)
            updateChartWithData()
            updatePieChartWithData()
        }
    }
    
    @IBAction func answer4Button(_ sender: AnyObject) {
        if (answer4Button.titleLabel?.text == "+") {
            let prevVote = self.didVoteAns.index(of: true)
            if (prevVote == nil) {
                answer4Button.setTitle("-", for: .normal)
                self.voters[3].append(self.loginUserID)
                DBProvider.instance.answerRef.child(self.answersID[3]).updateChildValues(["votes": (self.votes[3] + 1)])
                DBProvider.instance.answerRef.child(self.answersID[3]).updateChildValues(["answerVoters": self.voters[3]])
                updateData(questionID: self.questionID)
                updateChartWithData()
                updatePieChartWithData()
            } else {
                let userIdx = self.voters[prevVote!].index(of: "\(self.loginUserID)")
                self.voters[prevVote!].remove(at: userIdx!)
                answer4Button.setTitle("-", for: .normal)
                self.voters[3].append(self.loginUserID)
                DBProvider.instance.answerRef.child(self.answersID[prevVote!]).updateChildValues(["votes": (self.votes[prevVote!] - 1)])
                DBProvider.instance.answerRef.child(self.answersID[prevVote!]).updateChildValues(["answerVoters": self.voters[prevVote!]])
                DBProvider.instance.answerRef.child(self.answersID[3]).updateChildValues(["votes": (self.votes[3] + 1)])
                DBProvider.instance.answerRef.child(self.answersID[3]).updateChildValues(["answerVoters": self.voters[3]])
                updateData(questionID: self.questionID)
                updateChartWithData()
                updatePieChartWithData()
            }
        } else {
            answer4Button.setTitle("+", for: .normal)
            let index = self.voters[3].index(of: "\(self.loginUserID)")
            self.voters[3].remove(at: index!)
            DBProvider.instance.answerRef.child(self.answersID[3]).updateChildValues(["votes": (self.votes[3] - 1)])
            DBProvider.instance.answerRef.child(self.answersID[3]).updateChildValues(["answerVoters": self.voters[3]])
            updateData(questionID: self.questionID)
            updateChartWithData()
            updatePieChartWithData()
        }
    }
    
    @IBAction func answer5Button(_ sender: AnyObject) {
        if (answer5Button.titleLabel?.text == "+") {
            let prevVote = self.didVoteAns.index(of: true)
            if (prevVote == nil) {
                answer5Button.setTitle("-", for: .normal)
                self.voters[4].append(self.loginUserID)
                DBProvider.instance.answerRef.child(self.answersID[4]).updateChildValues(["votes": (self.votes[4] + 1)])
                DBProvider.instance.answerRef.child(self.answersID[4]).updateChildValues(["answerVoters": self.voters[4]])
                updateData(questionID: self.questionID)
                updateChartWithData()
                updatePieChartWithData()
                
            } else {
                let userIdx = self.voters[prevVote!].index(of: "\(self.loginUserID)")
                self.voters[prevVote!].remove(at: userIdx!)
                answer5Button.setTitle("-", for: .normal)
                self.voters[4].append(self.loginUserID)
                DBProvider.instance.answerRef.child(self.answersID[prevVote!]).updateChildValues(["votes": (self.votes[prevVote!] - 1)])
                DBProvider.instance.answerRef.child(self.answersID[prevVote!]).updateChildValues(["answerVoters": self.voters[prevVote!]])
                DBProvider.instance.answerRef.child(self.answersID[4]).updateChildValues(["votes": (self.votes[4] + 1)])
                DBProvider.instance.answerRef.child(self.answersID[4]).updateChildValues(["answerVoters": self.voters[4]])
                updateData(questionID: self.questionID)
                updateChartWithData()
                updatePieChartWithData()
            }
        } else {
            answer5Button.setTitle("+", for: .normal)
            let index = self.voters[4].index(of: "\(self.loginUserID)")
            self.voters[4].remove(at: index!)
            DBProvider.instance.answerRef.child(self.answersID[4]).updateChildValues(["votes": (self.votes[4] - 1)])
            DBProvider.instance.answerRef.child(self.answersID[4]).updateChildValues(["answerVoters": self.voters[4]])
            updateData(questionID: self.questionID)
            updateChartWithData()
            updatePieChartWithData()
        }
    }
    
    @IBOutlet weak var barView: HorizontalBarChartView!
    @IBOutlet weak var pieView: PieChartView!
    
    func sumOfVote() {
        var result = 0
        for i in 0..<self.votes.count {
            result += self.votes[i]
        }
        self.numOfVotes = result
    }
    
    func updatePieChartWithData() {
        var dataEntries: [ChartDataEntry] = []
        sumOfVote()
        for i in 0..<self.votes.count {
            let percentVote = 100.0 * Double(self.votes[i]) / Double(self.numOfVotes)
            let dataEntry = ChartDataEntry(x: Double(i), y: percentVote)
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Answer Choices")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieView.data = pieChartData
        pieView.descriptionText = ""
        pieChartDataSet.colors = ChartColorTemplates.colorful()
        pieView.legend.enabled = false
        pieView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        pieView.centerText = "Votes (%)"
        pieView.usePercentValuesEnabled = true
    }
    
    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<self.votes.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(self.votes[i]))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Answer Choices")
        //        let chartData = BarChartData(xVals: self.answers, dataSet: [chartDataSet])
        let chartData = BarChartData(dataSet: chartDataSet)
        barView.data = chartData
        barView.rightAxis.axisMinimum = 0.0
        barView.leftAxis.axisMinimum = 0.0
        barView.legend.enabled = false
        let xAxis:XAxis = barView.xAxis
        //        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        barView.leftAxis.drawGridLinesEnabled = false
        barView.rightAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = false
        barView.leftAxis.granularityEnabled = true
        barView.leftAxis.granularity = 1.0
        barView.rightAxis.granularityEnabled = true
        barView.rightAxis.granularity = 1.0
        barView.drawValueAboveBarEnabled = true;
        barView.descriptionText = ""
        chartDataSet.colors = ChartColorTemplates.colorful()
        barView.xAxis.labelPosition = .bottom
        barView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }

    @IBAction func backButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    private func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil);
        alert.addAction(ok);
        self.present(alert, animated: true, completion: nil);
    }
    
}
