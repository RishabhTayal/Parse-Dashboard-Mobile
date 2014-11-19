//
//  FirstViewController.swift
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/19/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

import UIKit

class PDFirstViewController: UIViewController, PDAddClassDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var datasource: [NSString] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        datasource = NSUserDefaults.standardUserDefaults().objectForKey("classes") as [String]!
        
        let classes: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey(UDClassNames)
        if classes != nil {
            var readArray: [NSString] = classes! as [NSString]
            datasource = readArray
        }
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if (editing) {
            
        } else {
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "addClassSegue") {
            var addClassVC: PDAddClassViewController = (segue.destinationViewController as UINavigationController).viewControllers[0] as PDAddClassViewController
            addClassVC.delegate = self
        }
        if (segue.identifier == "showRowsSegue") {
            var rowsVC: PDRowsViewController = segue.destinationViewController as PDRowsViewController
            
            var indexPath: NSIndexPath = tableView.indexPathForSelectedRow()!
            rowsVC.className = datasource[indexPath.row]
            
            tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated: true)
        }
    }
    
    func addClassDidDismiss(controller: PDAddClassViewController, className: String) {
        println(className)
        
        let classes: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey(UDClassNames)
        
        if classes == nil {
            var newClasses: [NSString] = [NSString]()
            newClasses.append(className)
            NSUserDefaults.standardUserDefaults().setObject(newClasses, forKey: UDClassNames)
            NSUserDefaults.standardUserDefaults().synchronize()
        } else {
            var readArray: [NSString] = classes! as [NSString]
            readArray.append(className)
            NSUserDefaults.standardUserDefaults().setObject(readArray, forKey: UDClassNames)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
//         classes.append(className)
        NSUserDefaults.standardUserDefaults().synchronize()
//        if (classes) {
//            classes = []
//            NSUserDefaults.standardUserDefaults().setObject(, forKey: )
//        }
        
        datasource.append(className)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        cell.textLabel.text = datasource[indexPath.row]
        return cell
    }
}

