//
//  Step.swift
//  SwiftExample
//
//  Created by Nahuel Marisi on 2015-09-03.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import Foundation

@objc class Step: NSObject {
    
    var text: String
    var ingredients:[Ingredient]
    
    init(text: String, ingredients: [Ingredient]) {
        self.text = text
        self.ingredients = ingredients
    }
    
    override init() {
        self.text = ""
        self.ingredients = Array<Ingredient>()
        super.init()
    }

}