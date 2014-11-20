//
//  PDRowsViewController.swift
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/19/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

import UIKit

class PDRowsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var className: String = ""
    
    var datasource: [AnyObject] = []
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = className
        
        var query = PFQuery(className: className)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            println(objects)
            
            if objects != nil {
                self.datasource = objects
                
                self.title = NSString(format: "%@ (%d)", self.className, objects.count)
                self.tableView.reloadData()
            } else {
            UIAlertView(title: "Error", message: "Could not find any objects for the class.", delegate: nil, cancelButtonTitle: "Ok").show()
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel.text = datasource[indexPath.row]["caption"] as? String
        
        return cell
    }
}
