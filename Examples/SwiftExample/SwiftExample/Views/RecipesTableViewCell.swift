//
//  RecipesTableViewCell.swift
//  SwiftExample
//
//  Created by Nahuel Marisi on 2015-09-06.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(recipe: Recipe) {
        titleLabel.text = recipe.title
        subtitleLabel.text = recipe.subtitle
        abstractLabel.text = recipe.abstract
    }

}
