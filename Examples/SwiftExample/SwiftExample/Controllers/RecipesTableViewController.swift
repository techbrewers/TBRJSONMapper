//
//  RecipesTableViewController.swift
//  SwiftExample
//
//  Created by Nahuel Marisi on 2015-09-06.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
   
    private var recipes:[Recipe] = []
    private let recipeFiles = ["fleskfile_recipe", "kalops_recipe", "kotbullar_recipe"]
    private let reuseIdentifier = "RecipeTableViewCell"
    private let stepSegueIdentifier = "StepsTableViewController"
    private var selectedRecipeIndex: Int = 0
    
    func loadRecipes() {
        let mapper = TBRJSONMapper(swiftModuleName: "SwiftExample")
        
        for filename in recipeFiles {
            guard let recipe =
                mapper.objectGraphForJSONResource(filename, withRootClassName: "Recipe") as? Recipe else {
                continue
            }
            recipes.append(recipe)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRecipes()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! RecipesTableViewCell
        cell.configure(recipes[indexPath.row])
        
        return cell
    }
    
    // MARK: = Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRecipeIndex = indexPath.row
        self.performSegueWithIdentifier(stepSegueIdentifier, sender: self)
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == stepSegueIdentifier {
            let destVC = segue.destinationViewController as! StepsTableViewController
            destVC.steps = recipes[selectedRecipeIndex].steps
        }
    }

}
