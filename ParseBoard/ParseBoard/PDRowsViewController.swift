//
//  PDRowsViewController.swift
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/19/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

import UIKit

class PDRowsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
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
    
    // MARK: UITableView Datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        var data: PFObject = datasource[indexPath.row] as PFObject
//        let string = data["objectId"] as String
        cell.textLabel.text = data.objectId

        return cell
    }
    
    // MARK: UISearchBar Delegate
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        var filteredArray : [AnyObject] = []
        
//        for (index, participant) in enumerate(datasource) {
//            for (index2, participant2) in enumerate(participant.allKeys) {
////                println(participant2)
//                var key: String = participant2 as String
//                var string = ""
//                if (participant.objectForKey(key)?.isKindOfClass(NSString) != nil) {
//                    var string: String = participant.objectForKey(key) as String
//                }
//                
//                if (string as NSString).containsString(searchText) {
//                    filteredArray.append(participant)
//                }
//            }
//        }
        
        println(filteredArray)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "dataSegue" {
            var vc: PDDataViewController = segue.destinationViewController as PDDataViewController
            var indexPath: NSIndexPath = tableView.indexPathForSelectedRow()!
            vc.datasource = datasource[indexPath.row]
        }
    }
}
