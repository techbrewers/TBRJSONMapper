//
//  Ingredient.swift
//  SwiftExample
//
//  Created by Nahuel Marisi on 2015-09-03.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import Foundation

@objc class Ingredient: NSObject {
    
    var name: String
    var quantity: Int
    
    override init() {
        
        self.name = ""
        self.quantity = 0
    }
    
    init(name: String, quantity: Int) {
        self.name = name
        self.quantity = quantity
    }

}