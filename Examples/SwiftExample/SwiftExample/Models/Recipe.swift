//
//  Recipe.swift
//  SwiftExample
//
//  Created by Nahuel Marisi on 2015-09-03.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import Foundation

class Recipe: NSObject {
   
    // Properties stored in the JSON file
    var title: String
    var subtitle: String
    var category: String
    
    var difficulty: Int
    var abstract: String?
    
    var time: Int
    var steps: [Step]
    
    var ingredient: Ingredient?
    
    override init() {
        self.title = ""
        self.subtitle = ""
        self.category = ""
        self.difficulty = 1
        self.steps = []
        self.time = 0
    }
    
   init(title: String, subtitle: String, steps: [Step]? = [],
        category: String? = "Unasigned", difficulty: Int? = 1) {
            self.title = title
            self.subtitle = subtitle
            self.category = category!
            self.difficulty = difficulty!
            self.steps = steps!
            self.time = 0
    }
    
}
 