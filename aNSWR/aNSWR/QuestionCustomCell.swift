//
//  QuestionCustomCell.swift
//  aNSWR
//
//  Created by Hui Jun on 2/1/17.
//  Copyright © 2017 aNSWR. All rights reserved.
//

import UIKit

class QuestionCustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var AnswerText: UILabel!
    @IBOutlet weak var AnswerText2: UILabel!
    @IBOutlet weak var AnswerText3: UILabel!
    @IBOutlet weak var AnswerText4: UILabel!
    @IBOutlet weak var AnswerText5: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
