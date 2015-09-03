//
//  Recipe.swift
//  SwiftExample
//
//  Created by Nahuel Marisi on 2015-09-03.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import Foundation

@objc class Recipe: NSObject {
   
    // Properties stored in the JSON file
    var title: String
    var subtitle: String
    var category: String
    var ingredients: [Ingredient]
    
    var difficulty: Int
    var abstract: String?
    
    var time: Int
    var steps: [Step]
    
    override init() {
        self.title = ""
        self.subtitle = ""
        self.category = ""
        self.difficulty = 1
        self.ingredients = []
        self.steps = []
        self.time = 0
    }
    
   init(title: String, subtitle: String, ingredients: [Ingredient]? = [],
        steps: [Step]? = [], category: String? = "Unasigned",
        difficulty: Int? = 1) {
            self.title = title
            self.subtitle = subtitle
            self.category = category!
            self.difficulty = difficulty!
            self.ingredients = ingredients!
            self.steps = steps!
            self.time = 0
    }
    
}
 