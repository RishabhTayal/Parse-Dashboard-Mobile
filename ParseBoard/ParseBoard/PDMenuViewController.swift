//
//  PDMenuViewController.swift
//  Parse Dashboard
//
//  Created by Rishabh Tayal on 11/19/14.
//  Copyright (c) 2014 Appikon Mobile. All rights reserved.
//

import UIKit

class PDMenuViewController: UITableViewController {
    
    var apps: [AppInfo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apps = AppInfo.MR_findAll() as [AppInfo]
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var footerView: UIView = NSBundle.mainBundle().loadNibNamed("MenuTableFooter", owner: self, options: nil)[0] as UIView
        
        footerView.frame = CGRectMake(0, 0, tableView.frame.size.width, footerView.frame.size.height)
        return footerView;
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellId = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? UITableViewCell
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        
        if (indexPath.row == apps.count) {
            cell?.textLabel.text = "Add new app"
            cell?.textLabel.textAlignment = NSTextAlignment.Center
        } else {
            cell?.textLabel.text = (apps[indexPath.row] as AppInfo).appname
        }
       
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var nav: UINavigationController = self.menuContainerViewController.centerViewController as UINavigationController
        
        if (indexPath.row == apps.count) {
            
        } else {
            var app: AppInfo = apps[indexPath.row] as AppInfo
            PDUtitility.setCurrentAppWithAppID(app.appid)
            
            var array:[AnyObject] = []
            var vc : PDFirstViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("PDFirstViewController") as PDFirstViewController
            nav.viewControllers = [vc]
        }
      
        self.menuContainerViewController.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
            if indexPath.row == self.apps.count {
                var viewC: UIViewController = nav.viewControllers[0] as UIViewController
                
                var sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                var vc: PDAddAppViewController = sb.instantiateViewControllerWithIdentifier("PDAddAppViewController") as PDAddAppViewController
                viewC.presentViewController(vc, animated: true, completion: nil)
            }
        })
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == apps.count {
            return false
        }
        return true
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {            
            
            var app: AppInfo = apps[indexPath.row] as AppInfo
            app.MR_deleteEntity()
            PDUtitility.saveContext()
            apps.removeAtIndex(indexPath.row)
        }
        tableView.reloadData()
    }
}
