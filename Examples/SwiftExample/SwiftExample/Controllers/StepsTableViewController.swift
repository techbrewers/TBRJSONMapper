//
//  StepsTableViewController.swift
//  SwiftExample
//
//  Created by Nahuel Marisi on 2015-09-06.
//  Copyright © 2015 TechBrewers. All rights reserved.
//

import UIKit

class StepsTableViewController: UITableViewController {
    
    let reuseIdentifier = "StepCell"
    var steps:[Step]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let s = steps else {
            return 0
        }
        
        return s.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! StepTableViewCell
        
        if let s = steps  {
            cell.configure(s[indexPath.row], stepIndex: indexPath.row)
        }

        return cell
    }
}
