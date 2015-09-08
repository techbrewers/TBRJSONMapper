//
//  StepTableViewCell.swift
//  SwiftExample
//
//  Created by Nahuel Marisi on 2015-09-06.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import UIKit

class StepTableViewCell: UITableViewCell {

    @IBOutlet weak var stepTextLabel: UILabel!
    @IBOutlet weak var stepNumberLabel: UILabel!
    
    func configure(step: Step, stepIndex: Int) {
        stepNumberLabel.text = "\(stepIndex + 1)"
        stepTextLabel.text = step.text
    }
    

}
