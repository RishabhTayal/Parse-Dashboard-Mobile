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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.datasource = []
        var appInfo: AppInfo = PDUtitility.getCurrentApp()
        
        self.title = appInfo.appname
        
        var classes: NSMutableSet = appInfo.classes as NSMutableSet
        
        if classes.count != 0 {
            classes.enumerateObjectsUsingBlock({ (object: AnyObject!, stop: UnsafeMutablePointer) -> Void in
                var pfClass: PFClass = object as PFClass
                self.datasource.append(pfClass.classname)
                self.tableView.reloadData()
            })
        }
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        tableView.setEditing(editing, animated: animated)
        if (editing) {
            self.navigationItem.rightBarButtonItem?.enabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.enabled = true
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
        
//        let classes: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey(UDClassNames)
        var app: AppInfo = PDUtitility.getCurrentApp()
        var classes: NSMutableSet? = app.classes as? NSMutableSet

        
        var newClass: PFClass = PFClass.MR_createEntity() as PFClass
        newClass.app = app
        newClass.classname = className
        
        classes?.addObject(newClass)
        
        app.addClasses(classes)
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion(nil);
        
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
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            var apps: [AppInfo] = AppInfo.MR_findAll() as [AppInfo]
            for (var i = 0; i < apps.count; i++) {
                var app: AppInfo = apps[i] as AppInfo
                if (app.appname == datasource[indexPath.row]) {
                    app.MR_deleteEntity()
                }
            }
            datasource.removeAtIndex(indexPath.row)
        }
    }
}

