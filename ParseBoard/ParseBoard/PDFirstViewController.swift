//
//  FirstViewController.swift
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/19/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

import UIKit

class PDFirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PDAddClassDelegate {
    
    @IBOutlet var tableView: UITableView!
    var datasource: [NSString] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMenuButton()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.datasource = []
        var appInfo: AppInfo = PDUtitility.getCurrentApp()
        
        self.title = appInfo.appname
        
        var classes: NSMutableSet = NSMutableSet(set: appInfo.classes)
        
        if classes.count != 0 {
            classes.enumerateObjectsUsingBlock({ (object: AnyObject!, stop: UnsafeMutablePointer) -> Void in
                var pfClass: PFClass = object as! PFClass
                self.datasource.append(pfClass.classname)
                self.tableView.reloadData()
            })
        }
        
        var buttons: [AnyObject] = []
        var addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addClass")
        buttons.append(addButton)
        buttons.append(self.editButtonItem())
        
        self.navigationItem.rightBarButtonItems = buttons
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMenuButton() {
        var barButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        barButton.setBackgroundImage(UIImage(named: "menu-button"), forState: UIControlState.Normal)
        barButton.frame = CGRectMake(0, 0, 30, 30)
        barButton.addTarget(self, action: "leftSideMenuButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: barButton)
    }
    
    func leftSideMenuButtonPressed(sender: UIButton) {
        println("pressed")
        self.menuContainerViewController.toggleLeftSideMenuCompletion(nil)
    }
    
    func addClass() {
        var vc: PDAddClassViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PDAddClassViewController") as! PDAddClassViewController
        vc.delegate = self
        var nav: UINavigationController = UINavigationController(rootViewController: vc)
        self.presentViewController(nav, animated: true, completion: nil)
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
            var addClassVC: PDAddClassViewController = (segue.destinationViewController as! UINavigationController).viewControllers[0] as! PDAddClassViewController
            addClassVC.delegate = self
        }
        if (segue.identifier == "showRowsSegue") {
            var rowsVC: PDRowsViewController = segue.destinationViewController as! PDRowsViewController
            
            var indexPath: NSIndexPath = tableView.indexPathForSelectedRow()!
            rowsVC.className = datasource[indexPath.row] as String
            
            tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow()!, animated: true)
        }
    }
    
    func addClassDidDismiss(controller: PDAddClassViewController, className: String) {
        println(className)
        
        //        let classes: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey(UDClassNames)
        var app: AppInfo = PDUtitility.getCurrentApp()
        var classes: NSMutableSet? = NSMutableSet(set: app.classes)
        
        
        var newClass: PFClass = PFClass.MR_createEntity() as! PFClass
        newClass.app = app
        newClass.classname = className
        
        classes?.addObject(newClass)
        
//        app.addClasses(classes)
        
        //        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion(nil);
        PDUtitility.saveContext()
        datasource.append(className)
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel!.text = datasource[indexPath.row] as String
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        var className = datasource[indexPath.row]
        if className == "_User" {
            return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            var apps: [PFClass] = PFClass.MR_findAll() as! [PFClass]
            for (var i = 0; i < apps.count; i++) {
                var app: PFClass = apps[i] as PFClass
                if (app.classname == datasource[indexPath.row]) {
                    app.MR_deleteEntity()
                    //                    NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion(nil)
                    PDUtitility.saveContext()
                }
            }
            datasource.removeAtIndex(indexPath.row)
        }
        tableView.reloadData()
    }
}

