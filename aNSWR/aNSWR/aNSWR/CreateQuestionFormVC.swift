//
//  CreateQuestionFormVC.swift
//  aNSWR
//
//  Created by Hui Jun on 2/6/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateQuestionFormVC: UIViewController, UITextFieldDelegate {

    var amountOfLinesToBeShown:CGFloat = 6
    var maxHeight:CGFloat = 17*6
    var ansArr = [String]()
    var checkValidityQuestionText = true
    var checkValidityAnswerText = true
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnswerText1.delegate = self
        AnswerText2.delegate = self
        AnswerText3.delegate = self
        AnswerText4.delegate = self
        AnswerText5.delegate = self
        QuestionText2.layer.cornerRadius = 5
        QuestionText2.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        QuestionText2.layer.borderWidth = 0.5
        QuestionText2.clipsToBounds = true
        AnswerButton1.isHidden = false
        AnswerButton2.isHidden = true
        AnswerButton3.isHidden = true
        AnswerButton4.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        AnswerText1.resignFirstResponder()
        AnswerText2.resignFirstResponder()
        AnswerText3.resignFirstResponder()
        AnswerText4.resignFirstResponder()
        AnswerText5.resignFirstResponder()
        return true;
    }
    
    @IBOutlet weak var QuestionText2: UITextView!
    @IBOutlet weak var AnswerText1: CustomTextField!
    @IBOutlet weak var AnswerText2: CustomTextField!
    @IBOutlet weak var AnswerText3: CustomTextField!
    @IBOutlet weak var AnswerText4: CustomTextField!
    @IBOutlet weak var AnswerText5: CustomTextField!
    
    @IBOutlet weak var AnswerButton1: UIButton!
    @IBOutlet weak var AnswerButton2: UIButton!
    @IBOutlet weak var AnswerButton3: UIButton!
    @IBOutlet weak var AnswerButton4: UIButton!
    
    @IBAction func AddAnswer2(_ sender: AnyObject) {
        if AnswerButton1.titleLabel!.text == "+" {
            AnswerText2.isHidden = false
            AnswerButton2.isHidden = false
            AnswerButton1.setTitle("-", for: .normal)
        } else {
            AnswerText2.isHidden = true
            AnswerText2.text = ""
            AnswerText3.isHidden = true
            AnswerText3.text = ""
            AnswerText4.isHidden = true
            AnswerText4.text = ""
            AnswerText5.isHidden = true
            AnswerText5.text = ""
            AnswerButton2.isHidden = true
            AnswerButton2.setTitle("+", for: .normal)
            AnswerButton3.isHidden = true
            AnswerButton3.setTitle("+", for: .normal)
            AnswerButton4.isHidden = true
            AnswerButton4.setTitle("+", for: .normal)
            AnswerButton1.setTitle("+", for: .normal)
        }
    }
    
    @IBAction func AddAnswer3(_ sender: AnyObject) {
        if AnswerButton2.titleLabel!.text == "+" {
            AnswerText3.isHidden = false
            AnswerButton3.isHidden = false
            AnswerButton2.setTitle("-", for: .normal)
        } else {
            AnswerText3.isHidden = true
            AnswerText3.text = ""
            AnswerText4.isHidden = true
            AnswerText4.text = ""
            AnswerText5.isHidden = true
            AnswerText5.text = ""
            AnswerButton3.isHidden = true
            AnswerButton3.setTitle("+", for: .normal)
            AnswerButton4.isHidden = true
            AnswerButton4.setTitle("+", for: .normal)
            AnswerButton2.setTitle("+", for: .normal)
        }
    }
    
    @IBAction func AddAnswer4(_ sender: AnyObject) {
        if AnswerButton3.titleLabel!.text == "+" {
            AnswerText4.isHidden = false
            AnswerButton4.isHidden = false
            AnswerButton3.setTitle("-", for: .normal)
        } else {
            AnswerText4.isHidden = true
            AnswerText4.text = ""
            AnswerText5.isHidden = true
            AnswerText5.text = ""
            AnswerButton4.isHidden = true
            AnswerButton4.setTitle("+", for: .normal)
            AnswerButton3.setTitle("+", for: .normal)
        }
    }
    
    @IBAction func AddAnswer5(_ sender: AnyObject) {
        if AnswerButton4.titleLabel!.text == "+" {
            AnswerText5.isHidden = false
            
            AnswerButton4.setTitle("-", for: .normal)
        } else {
            AnswerText5.isHidden = true
            AnswerText5.text = ""
            AnswerButton4.setTitle("+", for: .normal)
        }
    }
    
    @IBAction func CancelQuestionButton(_ sender: AnyObject)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CreateQuestionButton(_ sender: AnyObject) {
        
        let answers = [AnswerText1, AnswerText2, AnswerText3, AnswerText4, AnswerText5]
        let questionArr = QuestionText2.text.components(separatedBy: " ")
        
        for word in questionArr {
            if (badWord.contains(word.lowercased())) {
                checkValidityQuestionText = false
                break
            }
        }
        for answer in answers {
            print("..............................")
            if answer?.text != "" {
                let answerArr = answer?.text?.components(separatedBy: " ")
                for word in answerArr! {
                    if (badWord.contains(word.lowercased())) {
                        checkValidityAnswerText = false
                        break
                    }
                }
            }
        }
        if QuestionText2.text != "" && AnswerText1.text != "" && AnswerText2.text != "" && checkValidityAnswerText == true && checkValidityQuestionText == true {
            
            if !AnswerText1.text! .isEqual("") {
                ansArr.append(AnswerText1.text!)
            }
            if !AnswerText2.text! .isEqual("") {
                ansArr.append(AnswerText2.text!)
            }
            if !AnswerText3.text! .isEqual("") {
                ansArr.append(AnswerText3.text!)
            }
            if !AnswerText4.text! .isEqual("") {
                ansArr.append(AnswerText4.text!)
            }
            if !AnswerText5.text! .isEqual("") {
                ansArr.append(AnswerText5.text!)
            }

            DBProvider.instance.saveQuestion(questionText: QuestionText2.text!, answers: ansArr, userID: (FIRAuth.auth()?.currentUser?.uid)!, questionVoters: [""])
           
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference()
            ref.child("questions").queryLimited(toLast: 1).observeSingleEvent(of: .value, with: { (snapshot) in
                
                for singleSnap in snapshot.children.allObjects {
                    
                    let question = singleSnap as! FIRDataSnapshot
                    for answer in answers {
                        if !(answer?.text?.isEmpty)! {
                            DBProvider.instance.saveAnswer(answerText: (answer?.text)!, userID: (FIRAuth.auth()?.currentUser?.uid)!, questionID: question.key, votes: 0, answerVoters: [""])
                        }
                    }
                }
                self.dismiss(animated: true, completion: nil)
            })
            
            
        } else {
            if checkValidityQuestionText == false {
                showAlertMessage(title: "Error", message: "Your question contains inappropriate word")
                checkValidityQuestionText = true
            } else if checkValidityAnswerText == false {
                showAlertMessage(title: "Error", message: "Your answer contains inappropriate word")
                checkValidityAnswerText = true
            } else {
                showAlertMessage(title: "Answers Required", message: "Please fill out at least 2 answers");
            }
        }
    }
    
    private func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil);
        alert.addAction(ok);
        self.present(alert, animated: true, completion: nil);
    }
    
}
